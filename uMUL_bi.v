//By Alexander Peacock, undergrad at UCF ECE
//email: alexpeacock56ten@gmail.com

`include "sobolrng.v"

module uMUL_bi #(
    parameter BITWIDTH = 8
) (
    input wire iClk,
    input wire iRstN,
    input wire iA,
    input wire [BITWIDTH - 1: 0] iB,
    input wire loadB,
    input wire iClr,
    output reg oMult
);

    reg [BITWIDTH-1:0] iB_buff; //to store a value in block
    wire [BITWIDTH-1:0] sobolseqIn;
    wire [BITWIDTH-1:0] sobolseq;
    wire andTop;
    wire andBot;
    wire iA_inv = ~iA;

    always@(posedge iClk or negedge iRstN) begin
        if(~iRstN) begin
            iB_buff <= 0;
        end else begin
            if(loadB) begin
                iB_buff <= iB;
            end else begin
                iB_buff <= iB_buff;
            end
            
        end
    end

    sobolrng #(
        .BITWIDTH(BITWIDTH)
    ) u_sobolrngTop (
        .iClk(iClk),
        .iRstN(iRstN),
        .iEn(iA_inv), 
        .iClr(iClr),
        .sobolseq(sobolseqIn)
    );

    sobolrng #(
        .BITWIDTH(BITWIDTH)
    ) u_sobolrngBot (
        .iClk(iClk),
        .iRstN(iRstN),
        .iEn(iA), 
        .iClr(iClr),
        .sobolseq(sobolseq)
    );
    
    assign andTop = iA_inv & ~(iB_buff > sobolseqIn);
    assign andBot = iA & (iB_buff > sobolseq);

    always@(*) begin
        oMult <= andTop | andBot;
    end

endmodule

