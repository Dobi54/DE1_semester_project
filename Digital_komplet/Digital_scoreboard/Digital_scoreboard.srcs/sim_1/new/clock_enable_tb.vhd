library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_clock_enable is
end tb_clock_enable;

architecture tb of tb_clock_enable is

    component clock_enable
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            clk1Hz  : out std_logic;
            clk50Hz : out std_logic
        );
    end component;

    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal clk1Hz  : std_logic;
    signal clk50Hz : std_logic;

begin

    dut : clock_enable
    port map (
        clk     => clk,
        rst     => rst,
        clk1Hz  => clk1Hz,
        clk50Hz => clk50Hz
    );

    clk <= not clk after 5 ns;

    stimuli : process
    begin

        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        
        wait for 200 ms;
        
        wait;
    end process;

end tb;

configuration cfg_tb_clock_enable of tb_clock_enable is
    for tb
    end for;
end cfg_tb_clock_enable;