![](../../workflows/gds/badge.svg) ![](../../workflows/docs/badge.svg) ![](../../workflows/test/badge.svg)

# Time-to-Digital Converter (TDC)

## Copyright 2024 by Harald Pretl, Institute for Integrated Circuits, Johannes Kepler University, Linz, Austria

A TDC is implemented in Verilog and synthesized, with a configurable delay length, and based on an interleaved inverter chain.

The result of the delay line capture is output directly, without any bubble correction or coding.

This implementation shall allow to study the bubble signatures which are happening, and will allow to develop a proper bubble correction logic. In addition, the DNL and INL of the TDC can be quantified.
