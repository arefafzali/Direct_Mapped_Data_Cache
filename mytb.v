`timescale 1ns/1ns
module TB ();
  reg clk=0, cacheClk=0, memClk=0;
  wire ready;
  
  CA_CA5 ca(clk, cacheClk, memClk, ready);

  always #73 memClk = ~memClk;
  always #43 cacheClk = ~cacheClk;
  always #13 clk = ~clk;
  
  initial begin 
    #14000 $stop;
  end

endmodule
  