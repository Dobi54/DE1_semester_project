library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    use ieee.math_real.all;

entity clock_enable is
    generic (
        N_PERIODS_2000Hz : integer := 50_000;   -- Number of clock cycles for 2000Hz
        N_PERIODS_1Hz  : integer := 100_000_000  -- Number of clock cycles for 1Hz
    );
    port (
        clk      : in  std_logic;  -- Main input clock (100 MHz)
        rst      : in  std_logic;  -- Reset
        clk1Hz   : out std_logic;  -- Output pulse at 1 Hz
        clk2000Hz  : out std_logic   -- Output pulse at 2000 Hz
    );
end entity clock_enable;

architecture behavioral of clock_enable is
    -- Calculate number of bits needed for each counter
    constant bits_needed_2000HZ : integer := integer(ceil(log2(real(N_PERIODS_2000Hz + 1))));
    constant bits_needed_1HZ  : integer := integer(ceil(log2(real(N_PERIODS_1Hz + 1))));

    -- Define counters with the required bit width
    signal sig_count_2000Hz : std_logic_vector(bits_needed_2000HZ - 1 downto 0);
    signal sig_count_1Hz  : std_logic_vector(bits_needed_1HZ - 1 downto 0);

begin

    -- Main process triggered on rising edge of the clock
    p_clk_enable : process (clk) is
    begin
        if (rising_edge(clk)) then
            if rst = '1' then
                -- On reset, clear counters and outputs
                sig_count_2000Hz <= (others => '0');
                sig_count_1Hz  <= (others => '0');
                clk1Hz         <= '0';
                clk2000Hz        <= '0';

            else
                -- 1 Hz clock pulse generator
                if sig_count_1Hz = N_PERIODS_1Hz - 1 then
                    sig_count_1Hz <= (others => '0'); -- Reset counter
                    clk1Hz        <= '1';             -- Generate a pulse
                else
                    sig_count_1Hz <= sig_count_1Hz + 1;
                    clk1Hz        <= '0';             -- No pulse
                end if;

                -- 50 Hz clock pulse generator
                if sig_count_2000Hz = N_PERIODS_2000Hz - 1 then
                    sig_count_2000Hz <= (others => '0'); -- Reset counter
                    clk2000Hz        <= '1';             -- Generate a pulse
                else
                    sig_count_2000Hz <= sig_count_2000Hz + 1;
                    clk2000Hz        <= '0';             -- No pulse
                end if;
            end if;
        end if;
    end process;

end architecture behavioral;
