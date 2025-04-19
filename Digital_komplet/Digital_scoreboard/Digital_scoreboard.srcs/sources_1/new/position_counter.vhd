library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity position_counter is
    Port (
        clk      : in  STD_LOGIC;
        en       : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        position : out STD_LOGIC_VECTOR (2 downto 0)
    );
end position_counter;

architecture Behavioral of position_counter is
    signal sig_position : integer range 0 to 7 := 7;
    signal en_last      : STD_LOGIC := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                sig_position <= 7;

            elsif en = '1' and en_last = '0' then  -- detekce nábìhu signálu 'en'
                if sig_position = 0 then
                    sig_position <= 7;
                else
                    sig_position <= sig_position - 1;
                end if;
            end if;

            en_last <= en; -- uložíme hodnotu 'en' pro další porovnání
        end if;
    end process;

    position <= std_logic_vector(to_unsigned(sig_position, 3));

end Behavioral;
