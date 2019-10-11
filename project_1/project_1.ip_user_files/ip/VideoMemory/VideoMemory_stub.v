// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Oct  3 11:43:54 2019
// Host        : DELL-TVA running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               D:/tijsv/Documents/UAsem3/DigitaleElektronica/Opdracht1/project_1/IP/VideoMemory/VideoMemory_stub.v
// Design      : VideoMemory
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-3
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module VideoMemory(clka, wea, addra, dina, douta, clkb, web, addrb, dinb, 
  doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[18:0],dina[2:0],douta[2:0],clkb,web[0:0],addrb[18:0],dinb[2:0],doutb[2:0]" */;
  input clka;
  input [0:0]wea;
  input [18:0]addra;
  input [2:0]dina;
  output [2:0]douta;
  input clkb;
  input [0:0]web;
  input [18:0]addrb;
  input [2:0]dinb;
  output [2:0]doutb;
endmodule
