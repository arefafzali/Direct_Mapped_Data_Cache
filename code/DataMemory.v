module DataMemory(input clk, start, forc, input [14:0] Adr, output reg ready, output reg[31:0] R0, R1, R2, R3, R4);
    reg [31:0] Registers [0:32*1024-1];
    
    integer i;
    initial begin
        for (i=0; i<32*1024; i=i+1) begin
            Registers[i] = i;
        end
    end

    always@(clk) begin
        if(start) begin
            R0 = Registers[Adr];
            R1 = Registers[Adr-(Adr%4)];
            R2 = Registers[Adr-(Adr%4)+1];
            R3 = Registers[Adr-(Adr%4)+2];
            R4 = Registers[Adr-(Adr%4)+3];
            ready = 1;
        end
    end

    always@(*) if(forc) ready = 0;
endmodule