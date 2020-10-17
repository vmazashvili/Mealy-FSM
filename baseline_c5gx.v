`timescale 1ns / 1ps
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

	assign clk = CLOCK_125_p;
	assign switches = SW[1:0];
	assign button = !KEY[1];
	assign rst = !KEY[0];
reg [1:0] leds;

	assign LEDR[1:0]= leds;

	parameter green = 2'b00, blue = 2'b01,
			 pink = 2'b10, yellow = 2'b11;


	reg[1:0] next_state;
	reg[1:0] current_state;
	reg buttonPrev;
 
 	always @(posedge clk) begin
	buttonPrev <= button;
end
	assign buttonTrigger = !buttonPrev & button;


	always @(posedge clk) begin
	 
		if(rst)
			current_state <= green;
		else if(buttonTrigger) begin
			current_state <= green;
					case(current_state)
			green   : current_state <= blue;
			blue    : current_state <= switches[0] == 1 ? yellow : pink;
			pink    : current_state <= switches[0] == 1 ? blue : green;
			yellow  : current_state <= switches[1] == 1 ? yellow : green;
			default: current_state <=2'bxx;
			endcase
		end
	end

	always @(current_state, switches) begin
if(rst) begin
			leds[0] <= 0;
			leds[1] <= 0;
		end
		else begin
			leds[0] <= !current_state[1] && switches[0] || !current_state[0];
			leds[1] <= !current_state[0] && switches[0] || !current_state[1] 
			&& !switches[0] || current_state[1] && current_state[0] && switches[1];
		end
	end

endmodule 
















