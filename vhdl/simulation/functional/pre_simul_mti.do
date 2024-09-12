vlib work
#
# Compile sources
#
vcom -explicit  -93 "../../../vhdl/src/prbs_any.vhd"
vcom -explicit  -93 "../../../vhdl/src/prbs_top.vhd"
vcom -explicit  -93 "../../../vhdl/src/prbs_top_tb.vhd"
#
# Call vsim to invoke simulator
#
vsim -voptargs="+acc" -t 1ps  -lib work prbs_top_tb
#
# Add waves
add wave -noupdate -format Logic /prbs_top_tb/clk
add wave -noupdate -divider {PRBS generator}
add wave -noupdate -format Logic /prbs_top_tb/inj_err
add wave -noupdate -format Literal -radix binary /prbs_top_tb/uut/prbs_out
add wave -noupdate -divider {PRBS 8 bit checker}
add wave -noupdate -format Literal -radix hexadecimal /prbs_top_tb/uut/prbs_8bits
add wave -noupdate -format Logic -radix binary /prbs_top_tb/uut/chk_en_8
add wave -noupdate -format Literal -radix hexadecimal -expand /prbs_top_tb/uut/i_prbs_any_chk8/data_out
add wave -noupdate -format Logic /prbs_top_tb/err_detect_8
add wave -noupdate -divider {PRBS 9 bit checker}
add wave -noupdate -format Literal -radix hexadecimal /prbs_top_tb/uut/prbs_9bits
add wave -noupdate -format Literal -radix hexadecimal -expand /prbs_top_tb/uut/i_prbs_any_chk9/data_out
add wave -noupdate -format Logic /prbs_top_tb/uut/chk_en_9
add wave -noupdate -format Logic /prbs_top_tb/err_detect_9

# Run simulation for this time
#
run 2 us