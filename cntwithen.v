//Generates position of lsz
`define cntwithen

module cntwithen #(
    parameter BITWIDTH = 4 //specifies bitwidth
) (
    input wire iClk, //clock
    input wire iRstN, //asynch reset active low
    input wire iEn, 
    input wire iClr, 
    output reg [BITWIDTH - 1:0] oCnt
);
    always@(posedge iClk or negedge iRstN) begin
        if(~iRstN) begin
            oCnt <= 0;
        end else begin
            if(iClr) begin
                oCnt <= 0;
            end else begin
                oCnt <= oCnt + iEn;
            end
        end
    end


endmodule

