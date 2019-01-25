// This is the top file that gathers the counter, the 1 Hz clock and the 7-segment output

module top(input reset_counter, input enable_counter, input reset_clk, input clk_50MHz, output [2:0] out_counter, output clk_1Hz, output [6:0] out_num);


counter_mod counter1(.reset(reset_counter), .enable(enable_counter), .clk_1Hz(clk_1Hz), .out(out_counter));
clk_1Hz clk1(.clk_50MHz(clk_50MHz), .reset(reset_clk), .clk_1Hz(clk_1Hz));
display exit_num1(.counter(out_counter), .out_num(out_num)); 

endmodule 
