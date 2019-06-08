module Controller(input clk, dataFinish, readyCache, readyMem, need, find, writed,
	output reg startCache, startMem, forc, We, MemSel, readerEn, outputEn, adrEn, ready);

	reg [2:0] presentStage, nextStage;
	initial begin
		presentStage = 0;
		nextStage = 1;
	end

	always @(posedge clk) begin
		presentStage = nextStage;
	end

	always @(presentStage, dataFinish, clk) begin
		case(presentStage)
			0: nextStage = dataFinish ? 6 : 1;
			1: nextStage = 2;
			2: nextStage = !readyCache ? 2 : need ? 4 : find ? 3 : 2;
			3: nextStage = 0;
			4: nextStage = readyMem ? 5 : 4;
			5: nextStage = writed ? 0 : 5;
			6: nextStage = 6;
			default: nextStage = 0;
		endcase
	end

	always @(presentStage) begin
		{startCache, startMem, forc, We, MemSel, readerEn, outputEn, adrEn, ready} = 10'b 0;
	
		case(presentStage)
			0: {readerEn, forc} = 2'b 11;
			1: adrEn = 1;
			2: startCache = 1;
			3: {outputEn, ready} = 2'b 11;
			4: startMem = 1;
			5: {MemSel, outputEn, ready, We} = 4'b 1111;
			6: ;
		endcase
	end
	
endmodule