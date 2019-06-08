module AdrReg(input en, input [14:0] in, output reg [14:0] out);
	initial out = 0;
	always @(*) begin
		if(en) out = in;
	end
endmodule