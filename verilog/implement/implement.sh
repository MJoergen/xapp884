#!/bin/sh
# file: implement.sh

# ----------------------------------------------------------------------------
# Script to synthesize and place & route the sample design.
# ----------------------------------------------------------------------------

# Clean up the results directory
rm -rf results
mkdir results

# Copy unisim_comp.v file to results directory
cp $XILINX/verilog/src/iSE/unisim_comp.v ./results/

# Synthesize the Verilog Files
echo 'Synthesizing verilog sample design with XST'
xst -ifn prbs_top.scr

# Copy the synthesized netlist and the constraints into the results directory
echo 'Copying files to results directory'
cp prbs_top.ngc ./results/
cp prbs_top.ucf ./results/prbs_top.ucf
cd results

echo 'Running ngdbuild'
ngdbuild -uc prbs_top.ucf prbs_top

echo 'Running map'
map -ol high prbs_top -o mapped.ncd

echo 'Running par'
par -ol high mapped.ncd routed.ncd

echo 'Running trce'
trce -v 10 routed.ncd mapped.pcf -o routed

echo 'Running design through bitgen'
bitgen -w routed routed mapped.pcf

echo 'Running netgen to create gate level verilog model'
netgen -pcf mapped.pcf -sdf_anno true -sdf_path "../../implement/results" -ofmt verilog -sim -tm prbs_top -w routed.ncd routed.v

cd ..
