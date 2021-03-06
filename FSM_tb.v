module FSM_tb;

	// Inputs
	reg CLOCK_125_p;
	reg[1:0] KEY;
	reg [1:0] SW;

	// Outputs
	wire [1:0] LEDR;

	// Instantiate the Unit Under Test (UUT)
	baseline_c5gx baseline_c5gx_instance(
		.CLOCK_125_p(CLOCK_125_p), 
		.KEY(KEY),  
		.SW(SW), 
		.LEDR(LEDR)
	);

	always #20 CLOCK_125_p = !CLOCK_125_p;
	always #100 KEY[0] = !KEY[0];

	initial begin
		// Initialize Inputs
		CLOCK_125_p = 0;
		KEY[0] = 0;
		KEY[1] = 0;
		SW = 0;

		// Wait 100 ns for global reset to finish
		SW = 3;
        
		// Add stimulus here

	end
      
endmodule

