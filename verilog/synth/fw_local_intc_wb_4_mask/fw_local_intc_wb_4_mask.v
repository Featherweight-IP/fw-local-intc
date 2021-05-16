/****************************************************************************
 * fw_local_intc_4_mask.v
 ****************************************************************************/
`include "wishbone_macros.svh"
  
/**
 * Module: fw_local_intc_4_mask
 * 
 * TODO: Add module documentation
 */
module fw_local_intc_wb_4_mask(
		input			clock,
		input			reset,
		`WB_TARGET_PORT(r_, 2, 32),
		input[3:0]		src,
		output			irq
		);
	
	fw_local_intc_wb #(
		.N_SRCS   (4  ), 
		.EN_MASK  (1 )
		) u_core (
		.clock    (clock   ), 
		.reset    (reset   ), 
		`WB_CONNECT(r_, r_),
		.src      (src     ), 
		.irq      (irq     ));

endmodule


