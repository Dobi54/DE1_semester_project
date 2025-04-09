library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity game_timer is
    Port (
        start_stop    : in  STD_LOGIC;
        clk           : in  STD_LOGIC;
        reset         : in  STD_LOGIC;
        en            : in  STD_LOGIC;
        time_run      : out STD_LOGIC;
        time_pause    : out STD_LOGIC;
        time_end      : out STD_LOGIC;
        sec_out_unit  : out STD_LOGIC_VECTOR (3 downto 0);
        sec_out_tens  : out STD_LOGIC_VECTOR (2 downto 0);
        min_out_unit  : out STD_LOGIC_VECTOR (3 downto 0);
        min_out_tens  : out STD_LOGIC_VECTOR (1 downto 0)
    );
end game_timer;

architecture Behavioral of game_timer is
    signal sec_unit  : integer range 0 to 9 := 0;
    signal sec_tens  : integer range 0 to 5 := 0;
    signal min_unit  : integer range 0 to 9 := 0;
    signal min_tens  : integer range 0 to 2 := 0;

    signal running   : std_logic := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- Nastavíme čas zpět na 20:00
                sec_unit <= 0;
                sec_tens <= 0;
                min_unit <= 0;
                min_tens <= 2;
                running  <= '0';
                time_end <= '0';

            elsif en = '1' then
                -- Změna stavu podle start_stop
                if start_stop = '1' then
                    running <= '1';
                else
                    running <= '0';
                end if;

                -- Pokud běží časovač a ještě nevypršel
                if running = '1' and time_end = '0' then

                    -- Když dosáhneme 00:00
                    if sec_unit = 0 and sec_tens = 0 and min_unit = 0 and min_tens = 0 then
                        time_end <= '1';
                        running  <= '0';

                    -- Jinak počítáme dolů
                    else
                        if sec_unit > 0 then
                            sec_unit <= sec_unit - 1;
                        else
                            sec_unit <= 9;
                            if sec_tens > 0 then
                                sec_tens <= sec_tens - 1;
                            else
                                sec_tens <= 5;
                                if min_unit > 0 then
                                    min_unit <= min_unit - 1;
                                else
                                    min_unit <= 9;
                                    if min_tens > 0 then
                                        min_tens <= min_tens - 1;
                                    end if;
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- Výstupy
    time_run   <= running;
    time_pause <= not running;
    
    sec_out_unit <= std_logic_vector(to_unsigned(sec_unit, 4));
    sec_out_tens <= std_logic_vector(to_unsigned(sec_tens, 3));
    min_out_unit <= std_logic_vector(to_unsigned(min_unit, 4));
    min_out_tens <= std_logic_vector(to_unsigned(min_tens, 2));

end Behavioral;
