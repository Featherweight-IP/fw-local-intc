/****************************************************************************
 * fw_local_intc_4_mask.v
 ****************************************************************************/
`include "rv_addr_line_en_macros.svh"
  
/**
 * Module: fw_local_intc_4_mask
 * 
 * TODO: Add module documentation
 */
module fw_local_intc_4_mask(
		input			clock,
		input			reset,
		`RV_ADDR_LINE_EN_TARGET_PORT(r_, 2, 32),
		input[3:0]		src,
		output			irq
		);
	
	fw_local_intc #(
		.N_SRCS   (4  ), 
		.EN_MASK  (1 )
		) u_core (
		.clock    (clock   ), 
		.reset    (reset   ), 
		`RV_ADDR_LINE_EN_CONNECT(r_, r_),
		.src      (src     ), 
		.irq      (irq     ));

endmodule


