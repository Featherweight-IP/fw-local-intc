MKDV_MK := $(abspath $(lastword $(MAKEFILE_LIST)))
SYNTH_DIR := $(dir $(MKDV_MK))

TOP_MODULE = fw_local_intc_wb_4_mask
SDC_FILE=$(SYNTH_DIR)/$(TOP_MODULE).sdc
MKDV_VL_SRCS += $(SYNTH_DIR)/fw_local_intc_wb_4_mask.v

QUARTUS_FAMILY ?= "Cyclone V"
QUARTUS_DEVICE ?= 5CGXFC7C7F23C8

#QUARTUS_FAMILY ?= "Cyclone 10 LP"
#QUARTUS_DEVICE ?= 10CL025YE144A7G

include $(SYNTH_DIR)/../common/defs_rules.mk

RULES := 1

include $(SYNTH_DIR)/../common/defs_rules.mk

