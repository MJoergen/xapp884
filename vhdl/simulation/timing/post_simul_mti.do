# Create work library
#
vlib work
#
# Compile sources
#
vcom -explicit  -93 "../../implement/results/routed.vhd"
vcom -explicit  -93 "../../src/prbs_top_tb.vhd"
#
# Call vsim to invoke simulator
#
vsim -voptargs="+acc" -t 1ps -sdfmax "/uut=../../implement/results/routed.sdf"  -lib work prbs_top_tb

# Add waves
add wave -noupdate -format Logic /prbs_top_tb/clk
add wave -noupdate -divider {inject error}
add wave -noupdate -format Logic /prbs_top_tb/inj_err
add wave -noupdate -divider {PRBS 8 bits checher error}
add wave -noupdate -format Logic /prbs_top_tb/err_detect_8
add wave -noupdate -divider {PRBS 9 bits checher error}
add wave -noupdate -format Logic /prbs_top_tb/err_detect_9

# Run simulation for this time
run 2 us