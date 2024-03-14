/*
 * Copyright (c) 2024 Harald Pretl, IIC@JKU
 * SPDX-License-Identifier: Apache-2.0
 *
 * This wrapper puts the TDC inside the TinyTapeout
 * harness adapting the IOs to the ones available.
 *
 */

`define default_netname none
`default_nettype none
`include "../src/tdc.v"

module tt_um_hpretl_tt06_tdc (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // Don't use (used for power gating)
    input  wire       clk,
    input  wire       rst_n     // Async to clk
);

  localparam N_DELAY = 192;

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out[7:0] = 8'b0;
  assign uio_oe = 8'b00000000;

  /* verilator lint_off UNUSED */
  wire [7:0] dummy1 = uio_in[7:0];
  wire dummy2 = ena;
  wire [1:0] dummy3 = ui_in[2:1];
  wire dummy4 = rst_n;
  /* verilator lint_on UNUSED */

  wire [N_DELAY-1:0] result;
  wire start = ui_in[0];
  wire stop = clk;

  // here a bit of trickery to mux out the wide result bus
  // to the limited 8b; up to 256 delay stages are supported

  wire [4:0] out_sel = ui_in[7:3];
  wire [7:0] res_sel[0:(N_DELAY/8)-1];
  assign uo_out = res_sel[out_sel];

  genvar i;
  generate
    for (i=0; i<(N_DELAY/8); i=i+1) begin : g_out_sel
      assign res_sel[i] = result[(i+1)*8-1:i*8];
    end
  endgenerate

  // instantiate the actual design into the TT harness

  tdc #(.N_DELAY(N_DELAY)) tdc0 (
    .i_start(start),
    .i_stop(stop),
    .o_result(result)
  );

endmodule // tt_um_hpretl_tt06_tdc
