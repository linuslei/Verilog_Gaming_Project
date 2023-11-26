'timescale 1ns/1ps
module rex_control(clk, rst, up, down, left, right, hCount, vCount, xpos, ypos, score, bright, rgb, background);
    input clk, rst, up, down, left, right;
    input [9:0] hCount, vCount;
    output reg [9:0] xpos, ypos;
    output reg [15:0] score;
    output reg bright;
    output reg [11:0] rgb, background;
    
    wire block_fill;
    
    //these two values dictate the center of the block, incrementing and decrementing them leads the block to move in certain directions
    parameter RED   = 12'b1111_0000_0000;
    
    /*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
    will output some data to every pixel and not just the images you are trying to display*/
    always@ (*) begin
    	if(~bright )	//force black if not inside the display area
            rgb = 12'b0000_0000_0000;
        else if (block_fill) 
            rgb = RED; 
        else	
            rgb=background;
    end
        //the +-5 for the positions give the dimension of the block (i.e. it will be 10x10 pixels)
    assign block_fill=vCount>=(ypos-5) && vCount<=(ypos+5) && hCount>=(xpos-5) && hCount<=(xpos+5);
    
    always@(posedge clk, posedge rst) 
    begin
        if(rst)
        begin 
            //rough values for center of screen
            xpos<=450;
            ypos<=250;
        end
        else if (clk) begin
            
        
        /* Note that the top left of the screen does NOT correlate to vCount=0 and hCount=0. The display_controller.v file has the 
            synchronizing pulses for both the horizontal sync and the vertical sync begin at vcount=0 and hcount=0. Recall that after 
            the length of the pulse, there is also a short period called the back porch before the display area begins. So effectively, 
            the top left corner corresponds to (hcount,vcount)~(144,35). Which means with a 640x480 resolution, the