`ifndef sobolrng
`define sobolrng
`define BITWIDTH8

`include "sobolrng_core.v"
`include "lsz.v"
`include "cntwithen.v"

module sobolrng #(
    parameter BITWIDTH = 8
) (
    input wire iClk, //clock
    input wire iRstN, //asynch reset active low
    input wire iEn, 
    input wire iClr, 
    output reg [BITWIDTH - 1: 0] sobolseq
);

    wire [BITWIDTH - 1: 0] cntNum;
    wire [BITWIDTH - 1: 0] oneHot;
    wire [BITWIDTH*BITWIDTH - 1: 0] dirVec;

    //for position of lsz
    cntwithen #(
        .BITWIDTH(BITWIDTH)
    ) u_cntwithen (
        .iClk(iClk),
        .iRstN(iRstN),
        .iEn(iEn),
        .iClr(iClr),
        .oCnt(cntNum)
    );

    lsz #(
        .BITWIDTH(BITWIDTH)
    ) u_lsz (
        .iGrey(cntNum),
        .oOneHot(oneHot),
        .lszIdx()
    );

    //initialization of directional vectors for current dimension
    `ifdef BITWIDTH2
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd2;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd1;
    `endif
    
    `ifdef BITWIDTH3
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd4;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd2;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH4
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd8;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd4;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd2;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH5
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd16;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd8;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd4;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd2;
        assign dirVec[5*BITWIDTH-1 : 4*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH6
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd32;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd16;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd8;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd4;
        assign dirVec[5*BITWIDTH-1 : 4*BITWIDTH] = 'd2;
        assign dirVec[6*BITWIDTH-1 : 5*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH7
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd64;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd32;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd16;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd8;
        assign dirVec[5*BITWIDTH-1 : 4*BITWIDTH] = 'd4;
        assign dirVec[6*BITWIDTH-1 : 5*BITWIDTH] = 'd2;
        assign dirVec[7*BITWIDTH-1 : 6*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH8
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd128;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd64;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd32;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd16;
        assign dirVec[5*BITWIDTH-1 : 4*BITWIDTH] = 'd8;
        assign dirVec[6*BITWIDTH-1 : 5*BITWIDTH] = 'd4;
        assign dirVec[7*BITWIDTH-1 : 6*BITWIDTH] = 'd2;
        assign dirVec[8*BITWIDTH-1 : 7*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH9
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd256;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd128;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd64;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd32;
        assign dirVec[5*BITWIDTH-1 : 4*BITWIDTH] = 'd16;
        assign dirVec[6*BITWIDTH-1 : 5*BITWIDTH] = 'd8;
        assign dirVec[7*BITWIDTH-1 : 6*BITWIDTH] = 'd4;
        assign dirVec[8*BITWIDTH-1 : 7*BITWIDTH] = 'd2;
        assign dirVec[9*BITWIDTH-1 : 8*BITWIDTH] = 'd1;
    `endif

    `ifdef BITWIDTH10
        assign dirVec[1*BITWIDTH-1 : 0*BITWIDTH] = 'd512;
        assign dirVec[2*BITWIDTH-1 : 1*BITWIDTH] = 'd256;
        assign dirVec[3*BITWIDTH-1 : 2*BITWIDTH] = 'd128;
        assign dirVec[4*BITWIDTH-1 : 3*BITWIDTH] = 'd64;
        assign dirVec[5*BITWIDTH-1 : 4*BITWIDTH] = 'd32;
        assign dirVec[6*BITWIDTH-1 : 5*BITWIDTH] = 'd16;
        assign dirVec[7*BITWIDTH-1 : 6*BITWIDTH] = 'd8;
        assign dirVec[8*BITWIDTH-1 : 7*BITWIDTH] = 'd4;
        assign dirVec[9*BITWIDTH-1 : 8*BITWIDTH] = 'd2;
        assign dirVec[10*BITWIDTH-1 : 9*BITWIDTH] = 'd1;
    `endif

    sobolrng_core #(
        .BITWIDTH(BITWIDTH)
    ) u_sobolrng_core (
        .iClk(iClk),
        .iRstN(iRstN),
        .iEn(iEn),
        .iClr(iClr),
        .iOneHot(oneHot),
        .dirVec(dirVec),
        .oRand(sobolseq)
    );

endmodule

`endif
