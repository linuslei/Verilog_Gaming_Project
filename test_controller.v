`timescale 1ns / 1ps

module test_rex_controller(
	input clk, //this clock must be a slow enough clock to view the changing positions of the objects
	input bright,
	input rst,
	input up, input down, input left, input right,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb,
	output reg [11:0] background
   );
	wire block_fill;
	
	//these two values dictate the center of the block, incrementing and decrementing them leads the block to move in certain directions
	reg [9:0] xpos, ypos, relative_x, relative_y;
	reg [22:0] dino [46:0];
	reg [6:0] jumping [26:0];
	reg [19:0] millisecond;
    reg [8:0] second;
    reg bool;

	initial begin
        dino[0] = 23'b00000000000000000000000;
        dino[1] = 23'b00000000000000000000000;
        dino[2] = 23'b00111111110000000000000;
        dino[3] = 23'b00111111110000000000000;
        dino[4] = 23'b01111111111000000000000;
        dino[5] = 23'b01111111011000000000000;
        dino[6] = 23'b01111111011000000000000;
        dino[7] = 23'b01111111111000000000000;
        dino[8] = 23'b01111111111000000000000;
        dino[9] = 23'b01111111111000000000000;
        dino[10] = 23'b01111111111000000000000;
        dino[11] = 23'b01111111111000000000000;
        dino[12] = 23'b01111111111000000000000;
        dino[13] = 23'b00000011111000000000000;
        dino[14] = 23'b00000011111000000000000;
        dino[15] = 23'b00011111111000000000000;
        dino[16] = 23'b00011111111000000000000;
        dino[17] = 23'b00000001111100000000100;
        dino[18] = 23'b00000001111100000000100;
        dino[19] = 23'b00000001111110000000100;
        dino[20] = 23'b00000001111110000000100;
        dino[21] = 23'b00000111111111100001100;
        dino[22] = 23'b00000111111111100001100;
        dino[23] = 23'b00000101111111110011100;
        dino[24] = 23'b00000101111111110011100;
        dino[25] = 23'b00000001111111111111100;
        dino[26] = 23'b00000001111111111111100;
        dino[27] = 23'b00000001111111111111100;
        dino[28] = 23'b00000001111111111111100;
        dino[29] = 23'b00000001111111111111000;
        dino[30] = 23'b00000000111111111111000;
        dino[31] = 23'b00000000111111111110000;
        dino[32] = 23'b00000000111111111110000;
        dino[33] = 23'b00000000011111111100000;
        dino[34] = 23'b00000000011111111100000;
        dino[35] = 23'b00000000001111111000000;
        dino[36] = 23'b00000000001111111000000;
        dino[37] = 23'b00000000011001110000000;
        dino[38] = 23'b00000000011001110000000;
        dino[39] = 23'b00000000000000110000000;
        dino[40] = 23'b00000000000000110000000;
        dino[41] = 23'b00000000000000010000000;
        dino[42] = 23'b00000000000000010000000;
        dino[43] = 23'b00000000000000110000000;
        dino[44] = 23'b00000000000000110000000;
        dino[45] = 23'b00000000000000000000000;
        dino[46] = 23'b00000000000000000000000;
        
        jumping[0] = 8'd0;  
        jumping[1] = 8'd12;   
        jumping[2] = 8'd23;  
        jumping[3] = 8'd33;
        jumping[4] = 8'd42;  
        jumping[5] = 8'd50;  
        jumping[6] = 8'd57;  
        jumping[7] = 8'd63;
        jumping[8] = 8'd68;  
        jumping[9] = 8'd72;  
        jumping[10] = 8'd75; 
        jumping[11] = 8'd72;
        jumping[12] = 8'd68; 
        jumping[13] = 8'd63; 
        jumping[14] = 8'd57;
         jumping[15] = 8'd50;
        jumping[16] = 8'd42; 
        jumping[17] = 8'd33; 
        jumping[18] = 8'd23; 
        jumping[19] = 8'd12;
        jumping[20] = 8'd0; 
//        jumping[21] = 8'd136; 
//        jumping[22] = 8'd139; 
//        jumping[23] = 8'd141;
//        jumping[24] = 8'd144; 
//        jumping[25] = 8'd145; 
//        jumping[26] = 8'd147; 
//        jumping[27] = 8'd148;
//        jumping[28] = 8'd149; 
//        jumping[29] = 8'd149; 
//        jumping[30] = 8'd150; 
//        jumping[31] = 8'd149;
//        jumping[32] = 8'd149; 
//        jumping[33] = 8'd148; 
//        jumping[34] = 8'd147; 
//        jumping[35] = 8'd145;
//        jumping[36] = 8'd144; 
//        jumping[37] = 8'd141; 
//        jumping[38] = 8'd139; 
//        jumping[39] = 8'd136;
//        jumping[40] = 8'd133; 
//        jumping[41] = 8'd129; 
//        jumping[42] = 8'd126; 
//        jumping[43] = 8'd121;
//        jumping[44] = 8'd117; 
//        jumping[45] = 8'd112; 
//        jumping[46] = 8'd107; 
//        jumping[47] = 8'd101;
//        jumping[48] = 8'd95;  
//        jumping[49] = 8'd89;  
//        jumping[50] = 8'd83;  
//        jumping[51] = 8'd76;
//        jumping[52] = 8'd69;  
//        jumping[53] = 8'd61;  
//        jumping[54] = 8'd54;  
//        jumping[55] = 8'd45;
//        jumping[56] = 8'd37; 
//        jumping[57] = 8'd28; 
//        jumping[58] = 8'd19;  
//        jumping[59] = 8'd9;

           millisecond <= 0;
           second <= 0;
           bool <= 0;
        
        
    end

	
	parameter RED   = 12'b1111_0000_0000;
	
	/*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
	will output some data to every pixel and not just the images you are trying to display*/
	always@ (*) begin
    	if(~bright )	//force black if not inside the display area
			rgb = 12'b0000_0000_0000;
		 else 
		 begin
        // Calculate relative position in the bitmap
        relative_x = hCount - xpos + 11; // Adjusted for sprite width (centering)
       relative_y = vCount - ypos;
        

        // Check if within the bounds of the bitmap
        if (relative_x >= 0 && relative_x < 23 && relative_y >= 0 && relative_y < 47) begin
            // Check if the corresponding bit in the bitmap is set
            if (dino[relative_y][22 - relative_x])
                rgb = RED; // Set color to red if the bit is set
            else
                rgb = background; // Else, use the background color
        end
        else
            rgb = background; // Outside the bitmap, use the background color
	end
end
		//the +-5 for the positions give the dimension of the block (i.e. it will be 10x10 pixels
	
	always@(posedge clk, posedge rst) 
	begin
		if(rst)
		begin 
			//rough values for center of screen
			xpos<=200;
			ypos<=400;
			millisecond <= 0;
            second <= 0;
            bool <= 0;
		end
		else if (clk) begin
		  if ((bool == 0) && (up)) begin
		      bool <= 1;
		      end
	      if (bool == 1) begin
	          millisecond <= millisecond + 1;
	          if (millisecond == 5) begin
	               millisecond <= 0;
	               second <= second + 1;
	               if (second == 20) begin
	                   second <= 0;
	                   bool <= 0;
	               end
	          end
	          ypos = 400-jumping[second];
	     end
	    
	    
		
		
		/* Note that the top left of the screen does NOT correlate to vCount=0 and hCount=0. The display_controller.v file has the 
			synchronizing pulses for both the horizontal sync and the vertical sync begin at vcount=0 and hcount=0. Recall that after 
			the length of the pulse, there is also a short period called the back porch before the display area begins. So effectively, 
			the top left corner corresponds to (hcount,vcount)~(144,35). Which means with a 640x480 resolution, the bottom right corner 
			corresponds to ~(783,515).  
		*/
			if(right) begin
				xpos<=xpos+2; //change the amount you increment to make the speed faster 
				if(xpos==800) //these are rough values to attempt looping around, you can fine-tune them to make it more accurate- refer to the block comment above
					xpos<=150;
			end
			else if(left) begin
				xpos<=xpos-2;
				if(xpos==150)
					xpos<=800;
			end
			end
		end
	


//	always@(posedge clk, posedge rst)begin
//	   if (rst) begin
//	        millisecond <= 0;
//            second <= 0;
//            bool <= 0;
//        end
//       else if (clk) begin
//           if(up == 1 && bool == 0)begin //Check for jump button status
//                    bool <= 1;
//                end
//           if(bool == 1)begin //If the button has been pressed then poll y value from file every 10 milliseconds
//                    millisecond <= millisecond + 1;
//                    if(millisecond == 5)begin
//                        millisecond <= 0;
//                        second <= second + 1;
//                    end
//                    if(second == 20)begin
//                        second <= 0;
//                        bool <= 0;
//                    end
//                end
//                 //Assign output to the current line in the y position data file
//            end
//    end //end of main block
	
	//the background color reflects the most recent button press
	always@(posedge clk, posedge rst) begin
		if(rst)
			background <= 12'b1111_1111_1111;
		else 
			if(right)
				background <= 12'b1111_1111_0000;
			else if(left)
				background <= 12'b0000_1111_1111;
			else if(down)
				background <= 12'b0000_1111_0000;
			else if(up)
				background <= 12'b0000_0000_1111;
	end

	
	
endmodule
