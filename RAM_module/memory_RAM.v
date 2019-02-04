module memory_read_write #(parameter ADD_WIDTH = 6, DATA_WIDTH = 4, DEPTH = 64) (input clk,
                         input read, 
                         input wr, 
                         input[ADD_WIDTH-1:0] address, 
                         input[DATA_WIDTH-1:0] data_write, 
                         output[DATA_WIDTH-1:0] out);

reg [DATA_WIDTH-1:0] mem [DEPTH-1:0]; // memory 64X4
reg [DATA_WIDTH-1:0] out;



always @(posedge clk) 
 begin 
  if (read) out <= mem[address];
  else if (wr) mem[address] <= data_write;
end

endmodule 
   


