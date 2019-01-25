// implementing signed and fixed_point multiplication based on Booth's algorithm\
// input word [7:0].[7:0]
// output word = 2n = [31:0]
// Real size would be input [s][6:0].[7:0] 
// output [s][30:0] or [s][13:0].[16:0] 
module booth(input signed [3:0] A1, input signed [3:0] B1, input clk, input reset, output reg signed [7:0] C);
reg signed [3:0] A, M, Q;
reg Q0 = 0; 
reg [3:0] N;

always @(posedge clk)
 begin 
 if (reset) 
 begin 
 N = 4;
 C = 0;
 end
 if (N == 0 && reset == 0) C = {A,Q};
 if (N != 0 && reset == 0)
    begin
    if (N == 4)
     begin
     A = 0;
     Q = A1;
     M = B1;
     Q0 = 0;
     end 
    if (Q0 == 0 && Q[0] == 1) A = A - M;
    else if (Q0 == 1 && Q[0] == 0) A = A + M;
   Q0 = Q[0];
   Q = Q >>>1;
   Q[3] = A[0];
   A = A >>>1;
   N = N-1;
  end
 end
 
endmodule


module tb_booth();
reg signed [3:0] A, B;
wire signed [7:0] C;
reg clk, reset;


initial 
 begin
 $dumpfile("tb_booth.vcd");
 $dumpvars;
 end
 
initial
begin
A <= 0;
B <= 0;
clk <= 0;
reset <= 0;
end

always 
 begin 
 #1
 clk = !clk;
 end

booth booth1(.A1(A), .B1(B), .clk(clk), .reset(reset), .C(C));

initial 
 begin
  reset <= 1;
  #4 
  reset <= 0;
  A <= 4'd3;
  B <= -4'd7;
  #100
  reset <= 1;
  #4 
  reset <= 0;
  A <= -4'd3;
  B <= -4'd1;
  #100
  reset <= 1;
  #4 
  reset <= 0;
  A <= -4'd5;
  B <= 4'd4;
  #200
  $finish();
 end

initial
$monitor("At time %time, A is %d, B is %d and out is %d", $time, A, B, C);

endmodule
