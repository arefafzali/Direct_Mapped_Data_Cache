module DataPath(input clk, cacheClk, memClk, startCache, startMem, forc, We, MemSel, readerEn, outputEn, adrEn,
                output dataFinish, readyCache, readyMem, need, find, writed);
 
  wire [14:0] Adr, readerOut;
  wire [31:0] dout, R1, R2, R3, R4, in_out, out_out;

  Reader reader(clk, readerEn, readerOut, dataFinish);
  AdrReg adrreg(adrEn, readerOut, Adr);
  Cache cache(cacheClk, startCache, We, forc, Adr, R1, R2, R3, R4, readyCache, writed, need, find, dout);
  DataMemory dm(memClk, startMem, forc, Adr, readyMem, R1, R2, R3, R4);
  assign in_out = MemSel ? R1 : dout;
  OutputReg oreg(outputEn, in_out, out_out);

endmodule