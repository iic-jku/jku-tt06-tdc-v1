/*  
    SPDX-FileCopyrightText: 2023 Harald Pretl
    Johannes Kepler University, Institute for Integrated Circuits
    SPDX-License-Identifier: Apache-2.0

    This is a simple time-to-digital converter (TDC) consisting of
    a long string inverters (configurable by N_DELAY) with a parallel
    chain of latches. When `i_start` goes high, this transition runs
    along the inverter chain, when `i_stop` goes high, the current
    state of the inverter chain is latched. This essentially measures
    the time between the rising edges of `i_start` and `i_stop` in
    number of inverter delays.

    The result is given out in binary form via `o_result`.

    A simle bubble correction is implemented.
*/

`ifndef __TDC__
`define __TDC__
`default_nettype none

`ifdef SIM
`timescale 10ps/1ps
`endif

module tdc #(parameter N_DELAY = 16) (
    input wire                          i_start,
    input wire                          i_stop,
    output reg [$clog2(N_DELAY)-1:0]    o_result
`ifdef DEBUG_TDC
    , output wire [N_DELAY-1:0]         dbg_result_raw
`endif
);

    (* keep = "true" *) wire [N_DELAY+1:0] w_delay_sig;
    reg [N_DELAY-1:0] r_delay_store;
    reg [N_DELAY-1:0] r_delay_result_untwist;
    /* verilator lint_off UNUSEDSIGNAL */
    wire dummy_sig1;
    reg [31-$clog2(N_DELAY):0] dummy_sig2;
    /* verilator lint_on UNUSEDSIGNAL */

    assign dummy_sig1 = w_delay_sig[N_DELAY+1];
    assign w_delay_sig[0] = i_start;

    // we generate a chain of inverters as a long delay chain. a rising edge on `start` is
    // "running" through the inverter chain.
	
    genvar i;
    generate
        for (i=0; i<=N_DELAY; i=i+1) begin : delay_chain
`ifdef SIM
            assign #1 w_delay_sig[i+1] = ~w_delay_sig[i]; 
`else
            (* keep = "true" *) sky130_fd_sc_hd__inv_4 delay_stage (.A(w_delay_sig[i]),.Y(w_delay_sig[i+1]));
`endif
        end
    endgenerate

    // on a rising edge on `stop` we sample the current state of the inverter chain into an
    // equal amount of registers
    always @(posedge i_stop) begin
        r_delay_store <= w_delay_sig[N_DELAY:1];
    end

    // since we have a chain of inverters, every second bit needs to be inverted for readout
    // (to "untwist")
    integer j;
    always @(r_delay_store) begin
        for (j=0; j<N_DELAY; j=j+1) begin
            if (j[0] == 1'b1) begin
                // odd stage: do not invert
                r_delay_result_untwist[j] = r_delay_store[j];
            end else begin
                // even stage: do invert
                r_delay_result_untwist[j] = ~r_delay_store[j];
            end
        end
    end

/*  TODO

    Test different thermo-to-bin decoders:

    1) Simple adder structure (adding all ones)
    2) Bubble correction first order (implmented below)
*/
`define THERMO2BIN 2

if (`THERMO2BIN == 1) begin
    // thermo-to-bin decoder by counting all ones
    integer k;
    always @(r_delay_result_untwist) begin
        o_result = 0;
        for (k=0; k<(N_DELAY-1); k=k+1) begin
            o_result = o_result + r_delay_result_untwist[k];
        end
    end
end

if (`THERMO2BIN == 2) begin
    // here do a thermo-to-bin decoder, with looking for 111 or 101 to avoid bubbles like
    // ...0000101111...
    integer k;
    always @(r_delay_result_untwist) begin
        o_result = 0;
        dummy_sig2 = 0;
        for (k=0; k<(N_DELAY-1); k=k+1) begin
            if ( (k>1) && (r_delay_result_untwist[k-:3] == 3'b101) )
                {dummy_sig2, o_result} = k;

            if ( (k>1) && (r_delay_result_untwist[k-:3] == 3'b111) )
                {dummy_sig2, o_result} = k+1;

            if ( (k==1) && (r_delay_result_untwist[1:0] == 2'b11) )
                o_result = 2;
            
            if ( (k==0) && (r_delay_result_untwist[0] == 1'b1) )
                o_result = 1;
        end
    end
end

`ifdef DEBUG_TDC
    // debug interface: provide raw result of stored untwisted delayline
    assign dbg_result_raw = r_delay_result_untwist; 
`endif

endmodule // tdc
`endif
