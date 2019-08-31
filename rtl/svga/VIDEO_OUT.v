module VIDEO_OUT
(
	input				pixel_clock,
	input				reset,
	input	[7:0]		vga_red_data,
	input	[7:0]		vga_green_data,
	input	[7:0]		vga_blue_data,
	input				h_synch,
	input				v_synch,
	input				blank,
					
	output	reg			VGA_OUT_HSYNC,
	output	reg			VGA_OUT_VSYNC,
	output	reg	[7:0]	VGA_OUT_RED,
	output	reg	[7:0]	VGA_OUT_GREEN,
	output	reg	[7:0]	VGA_OUT_BLUE
);

// make the external video connections
always @ (posedge pixel_clock or posedge reset) begin
	if (reset) begin
		// shut down the video output during reset
		VGA_OUT_HSYNC 			<= 1'b1;
		VGA_OUT_VSYNC 			<= 1'b1;
		VGA_OUT_RED				<= 8'b0;
		VGA_OUT_GREEN			<= 8'b0;
		VGA_OUT_BLUE			<= 8'b0;
	end
	
	else if (blank) begin
		// output black during the blank signal
		VGA_OUT_HSYNC	 		<= h_synch;
		VGA_OUT_VSYNC 	 		<= v_synch;
		VGA_OUT_RED				<= 8'b0;
		VGA_OUT_GREEN			<= 8'b0;
		VGA_OUT_BLUE			<= 8'b0;
	end
	
	else begin
		// output color data otherwise
		VGA_OUT_HSYNC	 		<= h_synch;
		VGA_OUT_VSYNC 	 		<= v_synch;
		VGA_OUT_RED				<= vga_red_data;
		VGA_OUT_GREEN			<= vga_green_data;
		VGA_OUT_BLUE			<= vga_blue_data;
	end
end

endmodule // VIDEO_OUT
