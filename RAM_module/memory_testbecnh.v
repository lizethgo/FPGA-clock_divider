`include "memory_read_write.v"
module memory_testbench();

parameter ADD_WIDTH = 6, DATA_WIDTH = 4, DEPTH = 64;

reg read, wr, clk;
reg [ADD_WIDTH-1 :0] address;
reg [DATA_WIDTH-1:0] data_write; 
wire [DATA_WIDTH-1:0] out;
integer add;

initial 
 begin
  $dumpfile("memorry_tb.vcd");
  for (add = 0; add < DEPTH; add = add + 1) $dumpvars(0, mem1.mem[add]);
  $dumpvars;
 end
 
initial
 begin
 clk <= 0;
 wr <= 0;
 read <= 0;
 end
 
always 
begin 
 #1
 clk = ~clk;
 end
 
 
 memory_read_write mem1(.clk(clk), .read(read), .wr(wr), .address(address), .data_write(data_write), .out(out));

initial 
 begin 
  // writing - reading
  #2
  wr = 1;
  #2
  //address <= {ADD_WIDTH-1{1'b0}};
  address = #ADD_WIDTH'd0;
  data_write = #DATA_WIDTH'd1;
  #2
  wr = 0;
  read = 1;
  #2
  address <=  #ADD_WIDTH'b0;
  #2
  read = 0;
  wr = 1;
  #2
  //address <= {ADD_WIDTH-1{1'b0}};
  address = #ADD_WIDTH'd0;
  data_write = #DATA_WIDTH'd2;
  #2
  wr = 0;
  read = 1;
  #2
  address <=  #ADD_WIDTH'b1;
  #2
  $finish();
  
 end
 
 initial 
 $monitor("At time %t, output is %h", $time, out);
 
 endmodule

