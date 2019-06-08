module CA_CA5(input clk, cacheClk, memClk, output ready);
 
	wire startCache, startMem, forc, We, MemSel, readerEn, outputEn,
		adrEn, dataFinish, readyCache, readyMem, need, find, writed;

	DataPath dp(clk, cacheClk, memClk, startCache, startMem, forc, We, MemSel, readerEn, outputEn, adrEn,
                dataFinish, readyCache, readyMem, need, find, writed);

	Controller cl(clk, dataFinish, readyCache, readyMem, need, find, writed,
				startCache, startMem, forc, We, MemSel, readerEn, outputEn, adrEn, ready);

endmodule