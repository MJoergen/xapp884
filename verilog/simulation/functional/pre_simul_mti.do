#
# Create work library
#
vlib work
#
# Compile sources
#
vlog  "../../../verilog/src/prbs_any.v"
vlog  "../../../verilog/src/prbs_top.v"
vlog  "../../../verilog/src/prbs_top_tb.v"
vlog  $env(XILINX)/verilog/src/glbl.v
#
# Call vsim to invoke simulator
#
vsim -voptargs="+acc" -t 1ps  -L xilinxcorelib_ver -L unisims_ver -lib work prbs_top_tb work.glbl

# Add waves
add wave -noupdate -format Logic /prbs_top_tb/CLK
add wave -noupdate -divider {PRBS generator}
add wave -noupdate -format Logic /prbs_top_tb/INJ_ERR
add wave -noupdate -format Literal -radix binary /prbs_top_tb/uut/prbs_out
add wave -noupdate -divider {PRBS 8 bit checker}
add wave -noupdate -format Literal -radix hexadecimal /prbs_top_tb/uut/prbs_8bits
add wave -noupdate -format Logic -radix binary /prbs_top_tb/uut/chk_en_8
add wave -noupdate -format Literal -radix hexadecimal -expand /prbs_top_tb/uut/I_PRBS_ANY_CHK8/DATA_OUT
add wave -noupdate -format Logic /prbs_top_tb/ERR_DETECT_8
add wave -noupdate -divider {PRBS 9 bit checker}
add wave -noupdate -format Literal -radix hexadecimal /prbs_top_tb/uut/prbs_9bits
add wave -noupdate -format Literal -radix hexadecimal -expand /prbs_top_tb/uut/I_PRBS_ANY_CHK9/DATA_OUT
add wave -noupdate -format Logic /prbs_top_tb/uut/chk_en_9
add wave -noupdate -format Logic /prbs_top_tb/ERR_DETECT_9

# Run simulation for this time
#
run 2 us