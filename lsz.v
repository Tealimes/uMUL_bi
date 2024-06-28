`define lsz

module lsz # (
    parameter BITWIDTH = 4,
    parameter LOGBITWIDTH = $clog2(BITWIDTH) //ceiling of log base 2 of value
) (
    input wire [BITWIDTH - 1: 0] iGrey, //grey number
    output wire [BITWIDTH - 1: 0] oOneHot, //one-hot encoding
    output reg [LOGBITWIDTH - 1: 0] lszIdx //index of LS 0
);
    wire [BITWIDTH - 1: 0] tc; //priority based

    genvar i;

    //temporal/thermometer coding
    assign tc[0] = ~iGrey[0]; 
    generate 
        for (i = 1; i < BITWIDTH; i = i + 1) begin
            assign tc[i] = tc[i - 1] | ~iGrey[i];
        end
    endgenerate

    //one-hot coding
    genvar j;
    
    assign oOneHot[0] = tc[0];
    generate 
        for(j = 1; j < BITWIDTH; j = j + 1) begin
            assign oOneHot[j] = tc[j - 1] ^ tc[j];
        end
    endgenerate

    always@(*) begin
        case(oOneHot)
            'd1 : lszIdx = 'd0;
            'd2 : lszIdx = 'd1;
            'd4 : lszIdx = 'd2;
            'd8 : lszIdx = 'd3;
            'd16 : lszIdx = 'd4;
            'd32 : lszIdx = 'd5;
            'd64 : lszIdx = 'd6;
            'd128 : lszIdx = 'd7;
            'd256 : lszIdx = 'd8;
            'd512 : lszIdx = 'd9;
            default : lszIdx = 'd0;
        endcase
    end

endmodule
