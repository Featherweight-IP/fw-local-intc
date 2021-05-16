/****************************************************************************
 * fw_local_intc.v
 ****************************************************************************/
`include "rv_addr_line_en_macros.svh"
  
/**
 * Module: fw_local_intc
 * 
 * TODO: Add module documentation
 */
module fw_local_intc #(
		parameter N_SRCS=1,
		parameter EN_MASK=1
		) (
		input				clock,
		input				reset,
		`RV_ADDR_LINE_EN_TARGET_PORT(r_, 2, 32),
		input[N_SRCS-1:0]	src,
		output reg			irq
		);

	reg						sw_req;
	reg[N_SRCS-1:0]			mask;
	reg[31:0]				dat_r;
	assign r_dat_r = dat_r;
	
	always @* begin
		dat_r = {32{1'b0}};
		case (r_adr[1:0]) // synopsys parallel_case full_case
			// Pending
			2'b00: dat_r = {sw_req, {32-N_SRCS-1{1'b0}}, src};
			2'b01: dat_r = {{32-N_SRCS{1'b0}}, mask};
			2'b10: dat_r = {{31{1'b0}}, sw_req};
		endcase
	end
	
	
	assign r_ready = 1'b1;
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			sw_req <= 1'b0;
			irq <= 1'b0;
			if (EN_MASK) begin
				mask <= {N_SRCS{1'b0}};
			end else begin
				mask <= {N_SRCS{1'b1}};
			end
		end else begin
			irq <= (sw_req | (|(mask & src)));
			if (r_valid) begin
				case (r_adr[1:0])
					2'b01: begin
						if (EN_MASK) begin
							mask <= r_dat_w[N_SRCS-1:0];
						end
					end
					2'b10: sw_req <= r_dat_w[0];
				endcase
			end
		end
	end
endmodule


