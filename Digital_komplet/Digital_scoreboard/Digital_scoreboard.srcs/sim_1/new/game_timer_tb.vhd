library ieee;
use ieee.std_logic_1164.all;

entity tb_game_timer is
end tb_game_timer;

architecture tb of tb_game_timer is

    component game_timer
        port (
            start_stop   : in std_logic;
            clk          : in std_logic;
            reset        : in std_logic;
            en           : in std_logic;
            time_run     : out std_logic;
            time_pause   : out std_logic;
            time_end     : out std_logic;
            sec_out_unit : out std_logic_vector (3 downto 0);
            sec_out_tens : out std_logic_vector (3 downto 0);
            min_out_unit : out std_logic_vector (3 downto 0);
            min_out_tens : out std_logic_vector (3 downto 0)
        );
    end component;

    signal start_stop   : std_logic := '0';
    signal clk          : std_logic := '0';
    signal reset        : std_logic := '0';
    signal en           : std_logic := '0';
    signal time_run     : std_logic;
    signal time_pause   : std_logic;
    signal time_end     : std_logic;
    signal sec_out_unit : std_logic_vector(3 downto 0);
    signal sec_out_tens : std_logic_vector(3 downto 0);
    signal min_out_unit : std_logic_vector(3 downto 0);
    signal min_out_tens : std_logic_vector(3 downto 0);

    constant clk_period : time := 10 ns;     -- 100 MHz
    constant en_period  : time := 1 sec;     -- 1 Hz

begin

    dut: game_timer
        port map (
            start_stop   => start_stop,
            clk          => clk,
            reset        => reset,
            en           => en,
            time_run     => time_run,
            time_pause   => time_pause,
            time_end     => time_end,
            sec_out_unit => sec_out_unit,
            sec_out_tens => sec_out_tens,
            min_out_unit => min_out_unit,
            min_out_tens => min_out_tens
        );

    -- CLK 100 MHz (perioda 10 ns)
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- EN 1 Hz (perioda 1 s, støídavì 0.5 s HIGH, 0.5 s LOW)
    en_process: process
    begin
        while true loop
            en <= '1';
            wait for 20 ms;
            en <= '0';
            wait for 20 ms;
        end loop;
    end process;

    -- Stimuly
    stim_proc: process
    begin
        -- Reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        wait for 50 ms;

        -- Spustíme èasovaè
        start_stop <= '1';
        wait for 1 sec;

        -- Pauza
        start_stop <= '0';
        wait for 500 ms;

        -- Znovu spuštìní
        start_stop <= '1';
        wait for 1 sec;

        -- Konec simulace
        wait;
    end process;

end tb;