 
set project_name "adc_lab"
create_project ${project_name} ./vivado -part xc7z020clg400-1 -force

set proj_dir [get_property directory [current_project]]
set obj [current_project]
 
add_files -fileset sources_1 -norecurse ./src/toplevel_tb.vhd
add_files -fileset sources_1 -norecurse ./src/AD9467_INTERFACE.vhd
add_files -fileset sources_1 -norecurse ./src/ad_9467_model.vhd


set_property target_language VHDL [current_project]

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clk_wiz_0
set_property -dict [list CONFIG.USE_DYN_PHASE_SHIFT {true} CONFIG.CLK_IN1_BOARD_INTERFACE {Custom} CONFIG.CLK_IN2_BOARD_INTERFACE {Custom} CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} CONFIG.PRIM_IN_FREQ {125} CONFIG.RESET_BOARD_INTERFACE {Custom} CONFIG.CLKOUT2_USED {true} CONFIG.CLK_OUT1_USE_FINE_PS_GUI {true} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {125} CONFIG.CLKIN1_JITTER_PS {80.0} CONFIG.MMCM_CLKFBOUT_MULT_F {8.000} CONFIG.MMCM_CLKIN1_PERIOD {8.000} CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} CONFIG.MMCM_CLKOUT0_USE_FINE_PS {true} CONFIG.MMCM_CLKOUT1_DIVIDE {8} CONFIG.NUM_OUT_CLKS {2} CONFIG.CLKOUT1_JITTER {119.348} CONFIG.CLKOUT1_PHASE_ERROR {96.948} CONFIG.CLKOUT2_JITTER {119.348} CONFIG.CLKOUT2_PHASE_ERROR {96.948} CONFIG.USE_LOCKED {false} CONFIG.USE_RESET {false}] [get_ips clk_wiz_0]



update_compile_order -fileset sources_1
 
close_project

 
