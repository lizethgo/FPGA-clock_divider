module clk_1Hz(input clk_50MHz, input reset, output reg clk_1Hz);
reg [25:0] aux;


always @(posedge clk_50MHz)
begin
 if (reset == 1) 
 begin
 aux = 0;
 clk_1Hz = 0; 
 end
 if (aux == 25_000_000)
 begin
 clk_1Hz =! clk_1Hz; 
 aux = 0;
 end
 else aux <= aux +1;
 end
 
endmodule
