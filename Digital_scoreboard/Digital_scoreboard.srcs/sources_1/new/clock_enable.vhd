library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all; -- Package for arithmetic operations with std_logic_vector
    use ieee.math_real.all; -- To calculate the number of bits needed to represent an integer

entity clock_enable is
	generic (
        N_PERIODS_50Hz : integer := 2_000_000 --! Default number of clk periodes to generate one pulse
    	N_PERIODS_1Hz : integer := 100_000_000 --! Default number of clk periodes to generate one pulse
    );
    port (
        clk      : in  std_logic; --! Hlavní hodinový signál 100 MHz
        rst      : in  std_logic; --! Synchronous reset
        clk1Hz   : out std_logic; --! Výstupní signál 1 Hz
        clk50Hz  : out std_logic  --! Výstupní signál 50 Hz
    );
end entity clock_enable;

architecture behavioral of clock_enable is
	--! Get number for needed bits for PERIOD value
    constant bits_needed_50HZ  : integer := integer(ceil(log2(real(N_PERIODS_50Hz + 1))));
    constant bits_needed_1HZ : integer := integer(ceil(log2(real(N_PERIODS_1Hz + 1))));
	--! Local counter with needed number of bits
    signal sig_count_50Hz : std_logic_vector(bits_needed_50Hz - 1 downto 0);
    signal sig_count_1Hz  : std_logic_vector(bits_needed_1Hz - 1 downto 0);

begin

    p_clk_enable : process (clk) is
    begin
        if (rising_edge(clk)) then
            if rst = '1' then
                sig_count_50Hz    <= (others => '0');
                sig_count_1Hz    <= (others => '0');
                clk1Hz     <= '0';
                clk50Hz    <= '0';

            else
                -- 1Hz generátor
                if cnt_1Hz = N1HZ - 1 then
                    cnt_1Hz  <= (others => '0');
                    clk1Hz   <= '1';
                else
                    cnt_1Hz  <= cnt_1Hz + 1;
                    clk1Hz   <= '0';
                end if;

                -- 50Hz generátor
                if cnt_50Hz = N50HZ - 1 then
                    cnt_50Hz <= (others => '0');
                    clk50Hz  <= '1';
                else
                    cnt_50Hz <= cnt_50Hz + 1;
                    clk50Hz  <= '0';
                end if;
	end process p_clk_enable;

end architecture behavioral;

            end if;
        end if;
    end process;

end architecture behavioral;
