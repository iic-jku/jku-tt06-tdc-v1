/*  
    SPDX-FileCopyrightText: 2023-2024 Harald Pretl
    Johannes Kepler University, Institute for Integrated Circuits
    SPDX-License-Identifier: Apache-2.0

    This is a simple time-to-digital converter (TDC) consisting of
    a long string inverters (configurable by N_DELAY) with a parallel
    chain of latches. When `i_start` goes high, this transition runs
    along the inverter chain, when `i_stop` goes high, the current
    state of the inverter chain is latched. This essentially measures
    the time between the rising edges of `i_start` and `i_stop` in
    number of inverter delays.

    The result of the capture is given out via `o_result`.

    When __TDC_INTERLEAVED__ is defined than an interlaved delay line
    is implemented.
*/

`ifndef __TDC__
`define __TDC__
`default_nettype none

/* verilator lint_off INCABSPATH */
/* verilator lint_off UNUSEDSIGNAL */
/* verilator lint_off DECLFILENAME */
//`include "/foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v"
//`include "/foss/pdks/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v"
/* verilator lint_on INCABSPATH */
/* verilator lint_on UNUSEDSIGNAL */
/* verilator lint_on DECLFILENAME */

module tdc #(parameter N_DELAY = 64) (
    input wire                  i_start,
    input wire                  i_stop,
    output wire [N_DELAY-1:0]   o_result
);

`define __TDC_INTERLEAVED__

    /* verilator lint_off MULTIDRIVEN */
    (* keep = "true" *) wire [N_DELAY+1:0] w_dly_sig;
    (* keep = "true" *) wire [N_DELAY:0] w_dly_sig_n;
    /* verilator lint_on MULTIDRIVEN */
    reg [N_DELAY-1:0] r_dly_store;
    /* verilator lint_off UNUSEDSIGNAL */
    wire dummy1 = w_dly_sig[N_DELAY+1];
    /* verilator lint_on UNUSEDSIGNAL */

    assign w_dly_sig[0] = i_start;

    // we generate a chain of inverters as a long delay chain. a rising edge on `start` is
    // "running" through the inverter chain.
	
    genvar i;
    generate
        for (i=0; i<=N_DELAY; i=i+1) begin : g_dly_chain_even
`ifdef SIM
            assign w_dly_sig_n[i] = ~w_dly_sig[i];
            assign w_dly_sig[i+1] = ~w_dly_sig_n[i];
`else
            (* keep = "true" *) sky130_fd_sc_hd__inv_2 dly_stg1 (.A(w_dly_sig[i]),.Y(w_dly_sig_n[i]));
            (* keep = "true" *) sky130_fd_sc_hd__inv_2 dly_stg2 (.A(w_dly_sig_n[i]),.Y(w_dly_sig[i+1]));
`endif
        end

`ifdef __TDC_INTERLEAVED__
`ifndef SIM
        // use an interlaved delay line to increase time resolution

       /* verilator lint_off MULTIDRIVEN */
        for (i=0; i<=(N_DELAY-1); i=i+1) begin : g_dly_chain_interleave
            (* keep = "true" *) sky130_fd_sc_hd__inv_2 dly_stg1 (.A(w_dly_sig[i]),.Y(w_dly_sig_n[i+1]));
            (* keep = "true" *) sky130_fd_sc_hd__inv_2 dly_stg2 (.A(w_dly_sig_n[i]),.Y(w_dly_sig[i+2]));
        end
       /* verilator lint_on MULTIDRIVEN */
`endif
`endif
    endgenerate

    // on a rising edge on `stop` we sample the current state of the inverter chain into an
    // equal amount of registers
    always @(posedge i_stop) begin
        r_dly_store <= w_dly_sig[N_DELAY:1];
    end

    assign o_result = r_dly_store;

endmodule // tdc
`endif
