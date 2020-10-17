`timescale 1ns / 1ps

module labi3_tb;

	// Inputs
	reg CLOCK_125_p=1;
	wire [1:0] KEY;
	reg [1:0] SW;

	// Outputs
	wire [1:0] LEDR;
	
	reg rst_i=0, btn_i=0;

	// Instantiate the Unit Under Test (UUT)
	lab3 uut (
		.CLOCK_125_p(CLOCK_125_p), 
		.KEY(KEY), 
		.LEDR(LEDR), 
		.SW(SW)
	);
assign KEY[0] = !rst_i;
assign KEY[1] = !btn_i;

always #20 CLOCK_125_p = !CLOCK_125_p;
//always #100 btn_i = !btn_i;
	
	initial begin
		// Initialize Inputs
		//CLOCK_125_p = 0;
		btn_i = 0;
		SW = 0;
		#100;
		
		rst_i = 1; # 100 rst_i = 0; //rst
		SW = 0;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here

		btn_i = 1; # 100 btn_i = 0; //rst
		//LD=11
#300;
		#100; SW = 3;	#100;	btn_i = 1; # 100 btn_i = 0; //rst
		#100; SW = 1;	#100;	btn_i = 1; # 100 btn_i = 0; //rst
		#100; SW = 2;	#100;	btn_i = 1; # 100 btn_i = 0; //rst
		
	end
      
endmodule

