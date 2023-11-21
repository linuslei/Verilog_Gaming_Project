module rex_top (
    input QuadSpiFlashCS,

    input ClkPort,

    input BtnD, 
    input BtnU,
    input BtnC,
    input Sw0, 
    input Sw1,
    input Sw2,
    output Ld5, Ld4, Ld3, Ld2, Ld1, Ld0, 
    output hSync, vSync,
    output [3:0] vgaR, vgaG, vgaB,
);

//Local Signals
wire Reset, ClkPort;
assign Reset=BtnC;
wire board_clk, sys_clk; //VGA Clock
wire bright;
wire[9:0] hc, vc;
wire[15:0] score;
wire up,down,left,right;
wire [11:0] rgb;

//Local signals for state machine
wire Start, Restart, Jump, Duck, Pause;
wire q_Start, q_Stop, q_Jump, q_Duck, q_Run, q_Pause;

//Assign external signals
assign Restart = Sw0;
assign Jump = BtnU;
assign Duck = BtnD;
assign Pause = Sw1;
assign Start = Sw2;

assign Ld5 = q_Start;
assign Ld4 = q_Stop;
assign Ld3 = q_Jump;
assign Ld2 = q_Duck;
assign Ld1 = q_Run;
assign Ld0 = q_Pause;


//Disable memory ports
assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;

//Clock divider
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
wire [11:0] background;

//Display Controller
display_controller dc(.clk(ClkPort), .hSync(hSync), .vSync(vSync), .bright(bright), .hCount(hc), .vCount(vc));
//T-rex controller
rex_rom rr(.clk(move_clk), .row(hc), .col(vc), .color_data(rgb));
//REX FSM
rex rx(.clk(move_clk), .Reset(Reset), .Start(Start), .Restart(Restart), .Jump(Jump), .Duck(Duck), .Pause(Pause), .q_Start(q_Start), .q_Stop(q_Stop), .q_Jump(q_Jump), .q_Duck(q_Duck), .q_Run(q_Run), .q_Pause(q_Pause), .x_pos(hc), .y_pos(vc), .point(point), .speed(speed), .hit_obs(hit_obs));


assign vgaR = rgb[11 : 8];
assign vgaG = rgb[7  : 4];
assign vgaB = rgb[3  : 0];





always @(posedge board_clk, posedge Reset)
begin
    
end
    
endmodule