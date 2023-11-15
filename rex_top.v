module rex_top (
    QuadSpiFlashCS,

    ClkPort,

    BtnL, BtnU,
    Sw0, Sw1,
    Ld5, Ld4, Ld3, Ld2, Ld1, Ld0, 
);

input ClkPort;

input BtnL, BtnU, Btnc;
input Sw0, Sw1;

output Ld5, Ld4, Ld3, Ld2, Ld1, Ld0;
output QuadSpiFlashCS;  

//Local Signals
wire Reset, ClkPort;
wire board_clk, sys_clk; //VGA Clock


wire Start, Restart, Jump, Duck, Pause;
wire q_Start, q_Stop, q_Jump, q_Duck, q_Run, q_Pause;

assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;

BUFGP BUFGP1 (board_clk, ClkPort);

assign Reset = BtnC;

always @(posedge board_clk, posedge Reset)
begin
    
end
    
endmodule