module RexControl (
    Clk, Reset, Start, Restart, Jump, Duck, Pause
);

input Clk, Reset, Start, Restart, Jump, Duck, Pause;

output q_Start, q_Stop, q_Jump, q_Duck, q_Run, q_Pause;
output reg [7:0] x_pos, y_pos, point, speed;
output reg hit_obs, g_flag, j_flag, d_flag;
//Needs more output?

reg [5:0] state;
reg [8:0] clk_cnt_stage_1, clk_cnt_stage_2, y_speed;
assign {q_Pause, q_Run, q_Duck, q_Jump, q_Restart, q_Start} = state;

localparam
START = 6'b000001,
RUN = 6'b000010,
JUMP = 6'b000100,
DUCK = 6'b001000,
PAUSE = 6'b010000,
STOP = 6'b100000;

always @ (posedge Clk, posedge Reset)
begin CLOCK_COUNTER
    clk_cnt_stage_1 <= clk_cnt_stage_1 + 1;
    if(Reset)
        begin
            clk_cnt_stage_1 <= 0;
            clk_cnt_stage_2 <= 0;
        end
    if (clk_cnt_stage_1 == 8'd11111111)
        begin
            clk_cnt_stage_1 <= 0;
            clk_cnt_stage_2 <= clk_cnt_stage_2 + 1;
        end



always @ (posedge clk, posedge Reset ) 
begin STATE_MACHINE_BLOCK
    if (Reset)
        begin
            state <= START;
            //Initialze other param
            speed <= 8'bx;
            point <= 8'bx;
            hit_obs <= 1'bx;
            g_flag <= 1'bx;
            j_flag <= 1'bx;
            y_speed <= 8'bx;
            d_flag <= 1'bx;
        end
    else
            case(state)
                START:
                begin
                    //State Transistions
                    if (Start)
                        state <= RUN;

                    //RTL operations
                    speed <= 0;
                    point <= 0;
                    hit_obs <= 0;
                    g_flag <= 0;
                    y_speed <= 20;
                    j_flag <= 0;
                    d_flag <= 0;
                end
                RUN:
                begin
                    //State Transistions
                    if(Pause)
                        state <= PAUSE;
                    else if (Jump)
                        state <= JUMP;
                    else if (Duck)
                        state <= DUCK;
                    else if (hit_obs)
                        state <= STOP;

                    //RTL operations
                    if (clk_cnt_stage_2 == 8'd11111111)
                        begin
                            speed <= speed + 1;
                            point <= point + 1;
                            //Potentially a two stage design for speed and point?
                        end
                end

                JUMP:
                begin
                    //State Transistion
                    if ((y_pos == 0) && (j_flag))
                        state <= RUN;
                    if (hit_obs)
                        state <= STOP;

                    //RTL Statement
                    if ((g_flag == 0) && (clk_cnt_stage_2 == 8'd11111111))
                    begin
                            y_speed <= y_speed - 1;
                            y_pos <= y_pos + y_speed;
                    end

                    if (y_speed == 0) && (g_flag == 0)
                        g_flag <= 1;
                    
                    if (g_flag == 1) && (clk_cnt_stage_2 == 8'd11111111)
                    begin
                        y_pos <= y_pos - y_speed;
                    end
                    
                    if (y_pos == 0) && (g_flag == 1)
                    begin
                        g_flag <= 0;
                        y_speed <= 20;
                        j_flag <= 1;
                    end
                end

                DUCK:
                begin
                    //state transistion
                    if (hit_obs)
                        state <= STOP;
                    else if  (Duck == 0)
                        state <= RUN;
                    
                    //RTL Statement
                    if (clk_cnt_stage_2 == 8'd11111111)
                        begin
                            if (Duck == 0)
                            begin
                                d_flag <= 0;
                            end
                            else
                            d_flag <= 1;
                        end
                
                PAUSE:
                begin
                    //state transition
                    if (Pause == 0)
                        state <= RUN;
                end

                STOP:
                begin
                    //state transition
                    if (Restart)
                        state <= START;
                end

                        
                    







                    




    
end
    
endmodule