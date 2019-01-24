module counter_mod(input reset, input enable, input clk_1Hz, output reg [2:0] out);


always @(posedge clk_1Hz or posedge reset)
 begin
 if (reset == 1'b1) out <= 3'd0;
 else if (enable == 1'b1 & reset == 1'b0) out <= out + 1;
 else if (out == 7) out <= 0;
 end

endmodule
