# Makefile for Tiny Tapeout cocotb test

SIM ?= icarus
FST ?= -fst

TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src
# File chứa mạch giải mã 7 đoạn của bạn phải được đặt trong thư mục src/
PROJECT_SOURCES = project.v

ifneq ($(GATES),yes)
SIM_BUILD = sim_build/rtl
VERILOG_SOURCES += $(addprefix $(SRC_DIR)/,$(PROJECT_SOURCES))
else
SIM_BUILD = sim_build/gl
COMPILE_ARGS += -DGL_TEST
COMPILE_ARGS += -DFUNCTIONAL
COMPILE_ARGS += -DUSE_POWER_PINS
COMPILE_ARGS += -DSIM
COMPILE_ARGS += -DUNIT_DELAY=\#1
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/primitives.v
VERILOG_SOURCES += $(PDK_ROOT)/sky130A/libs.ref/sky130_fd_sc_hd/verilog/sky130_fd_sc_hd.v
VERILOG_SOURCES += $(PWD)/gate_level_netlist.v
endif

COMPILE_ARGS += -I$(SRC_DIR)
VERILOG_SOURCES += $(PWD)/tb.v

# tb ở đây là module testbench (tb.v) bọc ngoài cùng, giữ nguyên không đổi thành tên module của bạn
TOPLEVEL = tb
COCOTB_TEST_MODULES = test

include $(shell cocotb-config --makefiles)/Makefile.sim
