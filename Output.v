module OutputReg(input en, input [31:0] in, output reg [31:0] out);
	initial out = 0;
	always @(*) begin
		if(en) out = in;
	end
endmodule