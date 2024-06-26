library verilog;
use verilog.vl_types.all;
entity elevator is
    port(
        buttons         : in     vl_logic_vector(4 downto 0);
        clk             : in     vl_logic
    );
end elevator;
