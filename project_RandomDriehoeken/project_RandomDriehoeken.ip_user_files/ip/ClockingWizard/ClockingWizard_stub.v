// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Oct 31 11:01:16 2019
// Host        : DELL-TVA running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/Documenten/UAsem3/DigitaleElektronica/Digitale_elektronica/project_RandomDriehoek/IP/ClockingWizard/ClockingWizard_stub.v
// Design      : ClockingWizard
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ClockingWizard(PixelClk, Clk100MHz)
/* synthesis syn_black_box black_box_pad_pin="PixelClk,Clk100MHz" */;
  output PixelClk;
  input Clk100MHz;
endmodule
