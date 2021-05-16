
FW_LOCAL_INTC_VERILOG_RTLDIR := $(dir $(lastword $(MAKEFILE_LIST)))

ifneq (1,$(RULES))

ifeq (,$(findstring $(FW_LOCAL_INTC_VERILOG_RTLDIR),$(MKDV_INCLUDED_DEFS)))
MKDV_INCLUDED_DEFS += $(FW_LOCAL_INTC_VERILOG_RTLDIR)

include $(PACKAGES_DIR)/fwprotocol-defs/verilog/rtl/defs_rules.mk
MKDV_VL_SRCS += $(wildcard $(FW_LOCAL_INTC_VERILOG_RTLDIR)/*.v)
endif

else # Rules

endif