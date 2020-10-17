module baseline_c5gx(
        ///////// CLOCK /////////
      input              CLOCK_125_p, ///LVDS
      ///////// KEY ///////// 1.2 V ///////
      input       [1:0]  KEY,
      ///////// LEDR ///////// 2.5 V ///////
      output      [1:0]  LEDR,
      ///////// SW ///////// 1.2 V ///////
      input       [1:0]  SW
);

	wire clk;
	wire rst;
	wire button;
	wire[1:0] switches;
	wire buttonTrigger;
	wire rstDeb;
	reg [1:0] leds;
	
	assign LEDR[1:0]= leds;
	assign clk = CLOCK_125_p;
	assign switches = SW[1:0];
	assign button = !KEY[1];
	assign rst = !KEY[0];
	
	parameter green = 2'b00, blue = 2'b01, pink = 2'b10, yellow = 2'b11;


	reg[1:0] next_state;
	reg[1:0] current_state;
	reg buttonPrev;

	
	assign buttonTrigger = !buttonPrev & button; 


	always @(posedge clk) begin
		buttonPrev <= button;
		
		if(rst) begin
			current_state <= green;
		end else if(buttonTrigger ) begin
			current_state <= next_state;
		end
	end


	always @(switches,current_state)begin
			case(current_state)
				green   : next_state <= blue;
				blue    : next_state <= switches[0] == 1 ? yellow : pink;
				pink    : next_state <= switches[0] == 1 ? blue : green;
				yellow  : next_state <= switches[1] == 1 ? yellow : green;
				default : begin
					current_state <= green;
					next_state <= blue;
				end
			endcase
	end


	always @(posedge clk) begin
		if(rst) begin
			leds[0] <= 0;
			leds[1] <= 0;
		end
		else begin
			leds[0] <= !current_state[1] && switches[0] || !current_state[0]; 
			leds[1] <= !current_state[0] && switches[0] || !current_state[1] && !switches[0] || current_state[1] && current_state[0] && switches[1]; 
		end
	end

endmodule 