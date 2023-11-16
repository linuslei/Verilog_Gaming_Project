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

reg [27:0]	DIV_CLK;
always @ (posedge ClkPort, posedge Reset)  
begin : CLOCK_DIVIDER
    if (Reset)
		DIV_CLK <= 0;
	else
		DIV_CLK <= DIV_CLK + 1'b1;
	end

wire vga_clk;
assign vga_clk=DIV_CLK[19]; //slower clock to drive the movement of objects on the vga screen


assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;

BUFGP BUFGP1 (board_clk, ClkPort);

assign Reset = BtnC;



always @(posedge board_clk, posedge Reset)
begin
    
end
    
endmodule