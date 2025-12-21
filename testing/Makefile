SIM      = iverilog
OUT      = run_cpu.vvp
FILELIST = 	$(CURDIR)/../design/adder.v \
			$(CURDIR)/../design/alu.v \
			$(CURDIR)/../design/control_unit.v \
			$(CURDIR)/../design/memory.v \
			$(CURDIR)/../design/mux.v \
			$(CURDIR)/../design/register.v \
			$(CURDIR)/../design/zext.v \
			$(CURDIR)/../design/cpu.v \
			$(CURDIR)/../test/cpuTB.v

all:
	$(SIM) -o $(OUT) $(FILELIST)

run: all
	vvp $(OUT)
