/****************************************************************************
 * fw_local_intc_wb.v
 ****************************************************************************/
`include "rv_addr_line_en_macros.svh"
`include "wishbone_macros.svh"
  
/**
 * Module: fw_local_intc_wb
 * 
 * TODO: Add module documentation
 */
module fw_local_intc_wb #(
		parameter N_SRCS=1,
		parameter EN_MASK=1
		) (
		input				clock,
		input				reset,
		`WB_TARGET_PORT(r_, 4, 32),
		input[N_SRCS-1:0]	src,
		output				irq
		);

	`RV_ADDR_LINE_EN_WIRES(rv_r_, 2, 32);
	
	reg state;
	assign r_dat_r = rv_r_dat_r;
	assign rv_r_dat_w = r_dat_w;
	assign rv_r_we = r_we;
	assign rv_r_valid = (r_cyc && r_stb);
	assign rv_r_adr = r_adr[3:2];
	assign r_ack = (state == 1'b1);
	
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			state <= 1'b0;
		end else begin
			case (state)
				1'b0: begin
					if (r_cyc && r_stb) begin
						state <= 1'b1;
					end
				end
				1'b1: begin
					state <= 1'b0;
				end
			endcase
		end
	end
	
	fw_local_intc #(
		.N_SRCS   (N_SRCS  ), 
		.EN_MASK  (EN_MASK )
		) u_core (
		.clock    (clock   ), 
		.reset    (reset   ), 
		`RV_ADDR_LINE_EN_CONNECT(r_, rv_r_),
		.src      (src     ), 
		.irq      (irq     ));

endmodule


