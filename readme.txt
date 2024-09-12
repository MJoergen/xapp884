*******************************************************************************
** © Copyright 2010 Xilinx, Inc. All rights reserved.
** This file contains confidential and proprietary information of Xilinx, Inc. and 
** is protected under U.S. and international copyright and other intellectual property laws.
*******************************************************************************
**   ____  ____ 
**  /   /\/   / 
** /___/  \  /   Vendor: Xilinx 
** \   \   \/    
**  \   \        readme.txt Version: 1.0  
**  /   /        Date Last Modified: 12 nov 2010 
** /___/   /\    Date Created: 12 nov 2010
** \   \  /  \   Associated Filename: xapp884.zip
**  \___\/\___\ 
** 
**  Device:     Any Virtex or Spartan® family 
**  Purpose:    PRBS generator/checker
**  Reference:  xapp884.pdf
**  Revision History: version 1.0 - initial release
**   
*******************************************************************************
**
**  Disclaimer: 
**
**		This disclaimer is not a license and does not grant any rights to the materials 
**              distributed herewith. Except as otherwise provided in a valid license issued to you 
**              by Xilinx, and to the maximum extent permitted by applicable law: 
**              (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND WITH ALL FAULTS, 
**              AND XILINX HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, 
**              INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-INFRINGEMENT, OR 
**              FITNESS FOR ANY PARTICULAR PURPOSE; and (2) Xilinx shall not be liable (whether in contract 
**              or tort, including negligence, or under any other theory of liability) for any loss or damage 
**              of any kind or nature related to, arising under or in connection with these materials, 
**              including for any direct, or any indirect, special, incidental, or consequential loss 
**              or damage (including loss of data, profits, goodwill, or any type of loss or damage suffered 
**              as a result of any action brought by a third party) even if such damage or loss was 
**              reasonably foreseeable or Xilinx had been advised of the possibility of the same.


**  Critical Applications:
**
**		Xilinx products are not designed or intended to be fail-safe, or for use in any application 
**		requiring fail-safe performance, such as life-support or safety devices or systems, 
**		Class III medical devices, nuclear facilities, applications related to the deployment of airbags,
**		or any other applications that could lead to death, personal injury, or severe property or 
**		environmental damage (individually and collectively, "Critical Applications"). Customer assumes 
**		the sole risk and liability of any use of Xilinx products in Critical Applications, subject only 
**		to applicable laws and regulations governing limitations on product liability.

**  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS PART OF THIS FILE AT ALL TIMES.

*******************************************************************************

This readme describes how to use the files that come with XAPP884
*******************************************************************************

Database structure

vhdl 
|__src                       hdl sources
|  |__Prbs_any.vhd           prbs gen/check macro
|  |__Prbs_top.vhd           example design
|  |__Prbs_top_tb.vhd        simulation test bench
| 
|__simulation                simulation example
|  |__functional   
|  |  |__ pre_simul_mti.do   mti functional simulation script 
|  |  |
|  |__timing   
|     |__ post_simul_mti.do  mti timing simulation script 
|     
|_implement                  implementation example
|  |__prbs_top.ucf           implementation constraints
|  |__implement.bat          windows implementation script
|  |__implement.sh           linux implementation script
|
|
verilog
|__src                       hdl sources
|  |__Prbs_any.v             prbs gen/check macro
|  |__Prbs_top.v             example design
|  |__Prbs_top_tb.v          simulation test bench
| 
|__simulation                simulation example
|  |__functional   
|  |  |__ pre_simul_mti.do   mti functional simulation script 
|  |  |
|  |__timing   
|     |__ post_simul_mti.do  mti timing simulation script 
|
|_implement                  implementation example
|  |__prbs_top.ucf           implementation constraints
|  |__implement.bat          windows implementation script
|  |__implement.sh           linux implementation script

*******************************************************************************
1) Running the functional simulation

The functional simulation is run by opening ModelSim, changing the working directory to 
"<language>/simulation/functional" , and running the ModelSim script 
"pre_simul_mti.do".
This script automatically configures and runs ModelSim to simulate the testbench.

2) Running the timing simulation

The timing simulation is run by opening ModelSim, changing the working directory to 
"<language>/simulation/timing" , and running the ModelSim script 
"post_simul_mti.do".
This script automatically configures and runs ModelSim to simulate the testbench.
Before running the timing simulation, the example design must be implemented as
described in the following point.

3) Implementing the example design

To implement the example design, change directory to "<language>/implement" and
run the appropriate script ("implement.bat" for Windows, "implement.sh" for Unix).
Note : Before running the implementation script, make sure your environment 
       variables are set for the desired ISE release.       


