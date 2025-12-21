SIM       = iverilog
CPU_OUT   = cpu.vvp
CPU_FILES =	$(CURDIR)/../design/adder.v \
			$(CURDIR)/../design/alu.v \
			$(CURDIR)/../design/control_unit.v \
			$(CURDIR)/../design/memory.v \
			$(CURDIR)/../design/mux.v \
			$(CURDIR)/../design/register.v \
			$(CURDIR)/../design/zext.v \
			$(CURDIR)/../design/cpu.v \
			$(CURDIR)/../test/cpuTB.v

ADDER_OUT   = adder.vvp
ADDER_FILES = $(CURDIR)/../design/adder.v \
			  $(CURDIR)/../test/adderTB.v 

ALU_OUT   = alu.vvp
ALU_FILES = $(CURDIR)/../design/alu.v \
			$(CURDIR)/../test/aluTB.v 

CONTROL_RESET_OUT   = control_unit_reset.vvp
CONTROL_RESET_FILES = $(CURDIR)/../design/control_unit.v \
			  		  $(CURDIR)/../test/control_unitTB_reset.v 

CONTROL_FETCH_OUT   = control_unit_fetch.vvp
CONTROL_FETCH_FILES = $(CURDIR)/../design/control_unit.v \
			  		  $(CURDIR)/../test/control_unitTB_fetch.v 

CONTROL_DECODE_OUT   = control_unit_decode.vvp
CONTROL_DECODE_FILES = $(CURDIR)/../design/control_unit.v \
			  		   $(CURDIR)/../test/control_unitTB_decode.v 

CONTROL_EXECUTE_OUT   = control_unit_execute.vvp
CONTROL_EXECUTE_FILES = $(CURDIR)/../design/control_unit.v \
			  		    $(CURDIR)/../test/control_unitTB_execute.v 

CONTROL_MEMORY_OUT   = control_unit_memory.vvp
CONTROL_MEMORY_FILES = $(CURDIR)/../design/control_unit.v \
			  		   $(CURDIR)/../test/control_unitTB_memory.v 

CONTROL_WRITEBACK_OUT   = control_unit_writeback.vvp
CONTROL_WRITEBACK_FILES = $(CURDIR)/../design/control_unit.v \
			  		  	  $(CURDIR)/../test/control_unitTB_writeback.v 

CONTROL_HALT_OUT   = control_unit_halt.vvp
CONTROL_HALT_FILES = $(CURDIR)/../design/control_unit.v \
			  		 $(CURDIR)/../test/control_unitTB_halt.v 

MEMORY_OUT   = memory.vvp
MEMORY_FILES = $(CURDIR)/../design/memory.v \
			   $(CURDIR)/../test/memoryTB.v

MEMORY_LOAD_OUT   = memory_load.vvp
MEMORY_LOAD_FILES = $(CURDIR)/../design/memory.v \
			   		$(CURDIR)/../test/memory_loadTB.v

MUX_OUT   = mux.vvp
MUX_FILES = $(CURDIR)/../design/mux.v \
			$(CURDIR)/../test/muxTB.v

REGISTER_OUT   = register.vvp
REGISTER_FILES = $(CURDIR)/../design/register.v \
			     $(CURDIR)/../test/registerTB.v

ZEXT_OUT   = zext.vvp
ZEXT_FILES = $(CURDIR)/../design/zext.v \
			 $(CURDIR)/../test/zextTB.v

all: cpu

cpu:
	$(SIM) -o $(CPU_OUT) $(CPU_FILES)
	vvp $(CPU_OUT)
	gtkwave cpuTB.vcd

adder:
	$(SIM) -o $(ADDER_OUT) $(ADDER_FILES)
	vvp $(ADDER_OUT)
	gtkwave adderTB.vcd

alu:
	$(SIM) -o $(ALU_OUT) $(ALU_FILES)
	vvp $(ALU_OUT)
	gtkwave aluTB.vcd
	
ctrl_reset:
	$(SIM) -o $(CONTROL_RESET_OUT) $(CONTROL_RESET_FILES)
	vvp $(CONTROL_RESET_OUT)
	gtkwave control_unitTB_reset.vcd

ctrl_fetch:
	$(SIM) -o $(CONTROL_FETCH_OUT) $(CONTROL_FETCH_FILES)
	vvp $(CONTROL_FETCH_OUT)
	gtkwave control_unitTB_fetch.vcd

ctrl_decode:
	$(SIM) -o $(CONTROL_DECODE_OUT) $(CONTROL_DECODE_FILES)
	vvp $(CONTROL_DECODE_OUT)
	gtkwave control_unitTB_decode.vcd

ctrl_execute:
	$(SIM) -o $(CONTROL_EXECUTE_OUT) $(CONTROL_EXECUTE_FILES)
	vvp $(CONTROL_EXECUTE_OUT)
	gtkwave control_unitTB_execute.vcd

ctrl_memory:
	$(SIM) -o $(CONTROL_MEMORY_OUT) $(CONTROL_MEMORY_FILES)
	vvp $(CONTROL_MEMORY_OUT)
	gtkwave control_unitTB_memory.vcd

ctrl_writeback:
	$(SIM) -o $(CONTROL_WRITEBACK_OUT) $(CONTROL_WRITEBACK_FILES)
	vvp $(CONTROL_WRITEBACK_OUT)
	gtkwave control_unitTB_writeback.vcd
	
ctrl_halt:
	$(SIM) -o $(CONTROL_HALT_OUT) $(CONTROL_HALT_FILES)
	vvp $(CONTROL_HALT_OUT)
	gtkwave control_unitTB_halt.vcd

memory:
	$(SIM) -o $(MEMORY_OUT) $(MEMORY_FILES)
	vvp $(MEMORY_OUT)
	gtkwave memoryTB.vcd

memory_load:
	$(SIM) -o $(MEMORY_LOAD_OUT) $(MEMORY_LOAD_FILES)
	vvp $(MEMORY_LOAD_OUT)
	gtkwave memory_loadTB.vcd

mux:
	$(SIM) -o $(MUX_OUT) $(MUX_FILES)
	vvp $(MUX_OUT)
	gtkwave muxTB.vcd

register:
	$(SIM) -o $(REGISTER_OUT) $(REGISTER_FILES)
	vvp $(REGISTER_OUT)
	gtkwave registerTB.vcd

zext:
	$(SIM) -o $(ZEXT_OUT) $(ZEXT_FILES)
	vvp $(ZEXT_OUT)
	gtkwave zextTB.vcd

clean:
	rm -f *.vvp *.vcd
