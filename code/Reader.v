module Reader(input clk, En, output reg [14:0] captured_data, output reg dataFinish);
	integer               data_file    ; // file handler
	integer               scan_file    ; // file handler
	`define NULL 0

	initial begin
	  data_file = $fopen("./Addresses.txt", "r");
	  if (data_file == `NULL) begin
	    $display("data_file handle was NULL");
	    $finish;
	  end
	end

	always @(posedge clk) begin
		if(En) begin
			scan_file = $fscanf(data_file, "%b\n", captured_data); 
			if ($feof(data_file))
			    dataFinish = 1;
			else
				dataFinish = 0;	
		end
	end
	
endmodule