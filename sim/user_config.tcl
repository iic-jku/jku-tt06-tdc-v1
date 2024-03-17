# Set design name
set ::env(DESIGN_NAME) "tt_um_hpretl_tt06_tdc"
# Set Verilog source files
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/tt_um_hpretl_tt06_tdc.v]
# Interpret instantiated SKY130-Standardcells as blackbox
set ::env(SYNTH_READ_BLACKBOX_LIB) 1
# Rexeg to flag nets where buffers are not allowed (analog signals)
# No linting
set ::env(QUIT_ON_SYNTH_CHECKS) 0
# Set die area
set ::env(DIE_AREA) "0 0 160 100"
