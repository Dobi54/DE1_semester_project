library ieee;
use ieee.std_logic_1164.all;

entity tb_position_counter is
end tb_position_counter;

architecture tb of tb_position_counter is

    component position_counter
        port (
            clk      : in std_logic;
            en       : in std_logic;
            rst      : in std_logic;
            position : out std_logic_vector (2 downto 0)
        );
    end component;

    signal clk      : std_logic := '0';
    signal en       : std_logic := '0';
    signal rst      : std_logic := '0';
    signal position : std_logic_vector(2 downto 0);

    constant period : time := 100 ns;

begin

    -- Pøipojení DUT
    dut: position_counter
        port map (
            clk      => clk,
            en       => en,
            rst      => rst,
            position => position
        );

    -- Generování hodinového signálu
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for period / 2;
            clk <= '1';
            wait for period / 2;
        end loop;
    end process;

    -- Stimuly
    stim_proc: process
    begin
        -- První reset
        rst <= '1';
        wait for period;
        rst <= '0';
        wait for period;

        -- 3 kroky poèítání (napø. z 7 ? 6 ? 5 ? 4)
        for i in 1 to 3 loop
            en <= '1';
            wait for period;
            en <= '0';
            wait for period;
        end loop;

        -- Druhý reset
        rst <= '1';
        wait for period;
        rst <= '0';
        wait for period;

        -- Pokraèujeme v poèítání (mìlo by zaèít znovu od 7)
        for i in 1 to 4 loop
            en <= '1';
            wait for period;
            en <= '0';
            wait for period;
        end loop;

        -- Konec simulace
        wait;
    end process;

end tb;
