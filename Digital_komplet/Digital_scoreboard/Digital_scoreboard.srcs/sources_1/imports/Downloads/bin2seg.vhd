library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin2seg is
    Port (
        clk                   : in STD_LOGIC;  -- Clock signal for synchronization
        clear                 : in STD_LOGIC;  -- Asynchronous clear signal
        bin_sec_unit          : in STD_LOGIC_VECTOR (3 downto 0); -- Seconds (units digit)
        bin_sec_tens          : in STD_LOGIC_VECTOR (3 downto 0); -- Seconds (tens digit)
        bin_min_unit          : in STD_LOGIC_VECTOR (3 downto 0); -- Minutes (units digit)
        bin_min_tens          : in STD_LOGIC_VECTOR (3 downto 0); -- Minutes (tens digit)
        bin_point_team1_unit  : in STD_LOGIC_VECTOR (3 downto 0); -- Team 1 score (units)
        bin_point_team1_tens  : in STD_LOGIC_VECTOR (3 downto 0); -- Team 1 score (tens)
        bin_point_team2_unit  : in STD_LOGIC_VECTOR (3 downto 0); -- Team 2 score (units)
        bin_point_team2_tens  : in STD_LOGIC_VECTOR (3 downto 0); -- Team 2 score (tens)
        position              : in STD_LOGIC_VECTOR(2 downto 0);  -- Active digit position (0-7)
        seg                   : out STD_LOGIC_VECTOR (6 downto 0); -- 7-segment display output (A-G)
        an                    : out STD_LOGIC_VECTOR (7 downto 0)  -- Digit enable signals (anodes)
    );
end bin2seg;

architecture Behavioral of bin2seg is
    signal bin : STD_LOGIC_VECTOR (3 downto 0); -- Internal signal to hold selected BCD digit
begin

    process (clk)
    begin
        if rising_edge(clk) then
            if clear = '1' then
                -- If clear is active, turn off all segments and all digits
                seg <= "1111111";
                an  <= "11111111";
            else
                -- Select which BCD input to display based on current digit position
                case position is
                    when "111" =>
                        bin <= bin_min_tens;
                        an  <= b"0111_1111"; -- Enable digit 7
                    when "110" =>
                        bin <= bin_min_unit;
                        an  <= b"1011_1111"; -- Enable digit 6
                    when "101" =>
                        bin <= bin_sec_tens;
                        an  <= b"1101_1111"; -- Enable digit 5
                    when "100" =>
                        bin <= bin_sec_unit;
                        an  <= b"1110_1111"; -- Enable digit 4
                    when "011" =>
                        bin <= bin_point_team1_tens;
                        an  <= b"1111_0111"; -- Enable digit 3
                    when "010" =>
                        bin <= bin_point_team1_unit;
                        an  <= b"1111_1011"; -- Enable digit 2
                    when "001" =>
                        bin <= bin_point_team2_tens;
                        an  <= b"1111_1101"; -- Enable digit 1
                    when others =>
                        bin <= bin_point_team2_unit;
                        an  <= b"1111_1110"; -- Enable digit 0 (rightmost)
                end case;

                -- Convert selected BCD digit to 7-segment code
                case bin is
                    when x"0" =>
                        seg <= "0000001"; -- Displays 0
                    when x"1" =>
                        seg <= "1001111"; -- Displays 1
                    when x"2" =>
                        seg <= "0010010"; -- Displays 2
                    when x"3" =>
                        seg <= "0000110"; -- Displays 3
                    when x"4" =>
                        seg <= "1001100"; -- Displays 4
                    when x"5" =>
                        seg <= "0100100"; -- Displays 5
                    when x"6" =>
                        seg <= "0100000"; -- Displays 6
                    when x"7" =>
                        seg <= "0001111"; -- Displays 7
                    when x"8" =>
                        seg <= "0000000"; -- Displays 8
                    when x"9" =>
                        seg <= "0000100"; -- Displays 9
                    when others =>
                        seg <= "1111111"; -- Blank display
                end case;
            end if;
        end if;
    end process;

end Behavioral;
