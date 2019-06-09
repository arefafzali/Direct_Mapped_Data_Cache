module Cache(input clk, start, WE, forc, input [14:0] Adr, input [31:0] R1, R2, R3, R4, output reg ready, writed, need, find, output reg[31:0] dout);
    reg [35:0] Registers [0:4*1024-1];
    reg[11:0] index;
    reg[2:0] tag;
    // Adr : index = [11:0] , tag = [14:12]
    // CacheReg : [35:33] = tag , [32] = valid , [31:0] data

    integer i;
    initial begin
        for (i=0; i<4*1024; i=i+1) begin
            Registers[i] = 0;
        end
        {ready, writed, need, find} = 4'b 0000;
    end

    always@(clk) begin
        index = Adr[11:0];
        tag = Adr[14:12];

        if(start) begin
            if(Registers[index][32] && (Registers[index][35:33] == tag)) begin
                dout = Registers[index][31:0];
                find = 1;
                ready = 1;
            end else begin
                need = 1;
                ready = 1;
            end
        end

        if(WE) begin
            {tag, index} = Adr-(Adr%4);
            Registers[index] = {tag, 1'b 1, R1};
            {tag, index} = Adr-(Adr%4)+1;
            Registers[index] = {tag, 1'b 1,R2};
            {tag, index} = Adr-(Adr%4)+2;
            Registers[index] = {tag, 1'b 1,R3};
            {tag, index} = Adr-(Adr%4)+3;
            Registers[index] = {tag, 1'b 1,R4};
            writed = 1;
        end
    end

    always@(*) if(forc) {ready, writed, need, find} = 4'b 0000;

endmodule