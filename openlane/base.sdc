set_units -time ns

# Clock definition
create_clock [get_ports i_clk] -name clk -period 20.0

# Clock uncertainty
set_clock_uncertainty 0.5 [get_clocks clk]
