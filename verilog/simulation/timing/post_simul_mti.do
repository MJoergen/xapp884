# Create work library
#
vlib work
#
# Compile sources
#
vlog  "../../implement/results/routed.v"
vlog  "../../src/prbs_top_tb.v"
#
# Compile glbl (Global Reset) source
#
vlog  $env(XILINX)/verilog/src/glbl.v
#
# Call vsim to invoke simulator
#
vsim -voptargs="+acc" -t 1ps +maxdelays  -L simprims_ver -lib work work.prbs_top_tb work.glbl
#
# Add waves
add wave -noupdate -format Logic /prbs_top_tb/CLK
add wave -noupdate -divider {inject error}
add wave -noupdate -format Logic /prbs_top_tb/INJ_ERR
add wave -noupdate -divider {PRBS 8 bits checher error}
add wave -noupdate -format Logic /prbs_top_tb/ERR_DETECT_8
add wave -noupdate -divider {PRBS 9 bits checher error}
add wave -noupdate -format Logic /prbs_top_tb/ERR_DETECT_9

# Run simulation for this time
run 2 us
