//testbench for visualizing the output waves and data using icarus Verilog and gtkwave
`include "top.v"

module test_bench;
reg clk_50MHz, enable_counter, reset_counter, reset_clk;
wire clk_1Hz;
wire [2:0] out_counter;

initial 
 begin
 $dumpfile("test_bench.vcd");
 $dumpvars;
 end
 
 // instance
top top1(.reset_counter(reset_counter), .enable_counter(enable_counter),
.clk_50MHz(clk_50MHz), .reset_clk(reset_clk), .out_counter(out_counter) );

 
initial 
  begin
  clk_50MHz <= 1'b0;
  enable_counter <= 1'b0;
  reset_counter <= 1'b0;
  reset_clk <= 0;
  end
  
always 
 begin 
 #1
 clk_50MHz = !clk_50MHz;
 end
 
initial 
 begin
 #50
 reset_counter <= 1'b1;
 reset_clk <= 1'b1;
 #50
 reset_counter <= 1'b0;
 reset_clk <= 1'b0;
 #50
 enable_counter <= 1'b1;
 #250_000
 $finish();
 end

initial
$monitor("At time %t, output is %h", $time, out_counter);
 
endmodule 
  
