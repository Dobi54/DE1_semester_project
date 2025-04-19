library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_score_counter is
end tb_score_counter;

architecture tb of tb_score_counter is

    component score_counter
        port (clk              : in std_logic;
              pointup_team1    : in std_logic;
              pointup_team2    : in std_logic;
              rst              : in std_logic;
              score_team1_unit : out std_logic_vector (3 downto 0);
              score_team1_tens : out std_logic_vector (3 downto 0);
              score_team2_unit : out std_logic_vector (3 downto 0);
              score_team2_tens : out std_logic_vector (3 downto 0));
    end component;

    signal clk              : std_logic := '0';
    signal pointup_team1    : std_logic := '0';
    signal pointup_team2    : std_logic := '0';
    signal rst              : std_logic := '1';
    signal score_team1_unit : std_logic_vector (3 downto 0);
    signal score_team1_tens : std_logic_vector (3 downto 0);
    signal score_team2_unit : std_logic_vector (3 downto 0);
    signal score_team2_tens : std_logic_vector (3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin

    dut : score_counter
    port map (clk              => clk,
              pointup_team1    => pointup_team1,
              pointup_team2    => pointup_team2,
              rst              => rst,
              score_team1_unit => score_team1_unit,
              score_team1_tens => score_team1_tens,
              score_team2_unit => score_team2_unit,
              score_team2_tens => score_team2_tens);

    -- Clock generation
    clk <= not clk after CLK_PERIOD/2;

    stimuli : process
    begin
        -- Initial reset
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- Test 1: Add points to team 1
        for i in 1 to 5 loop
            pointup_team1 <= '1';
            wait for CLK_PERIOD;
            pointup_team1 <= '0';
            wait for CLK_PERIOD*4;
        end loop;

        -- Test 2: Add points to team 2
        for i in 1 to 3 loop
            pointup_team2 <= '1';
            wait for CLK_PERIOD;
            pointup_team2 <= '0';
            wait for CLK_PERIOD*4;
        end loop;

        -- Test 3: Reset
        rst <= '1';
        wait for CLK_PERIOD*2;
        rst <= '0';
        wait for CLK_PERIOD*2;

        -- Test 4: Add points to both teams
        for i in 1 to 11 loop
            pointup_team1 <= '1';
            pointup_team2 <= '1';
            wait for CLK_PERIOD;
            pointup_team1 <= '0';
            pointup_team2 <= '0';
            wait for CLK_PERIOD*4;
        end loop;

        -- End simulation
        wait for 100 ns;
        report "Simulation finished" severity note;
        wait;
    end process;

end tb;