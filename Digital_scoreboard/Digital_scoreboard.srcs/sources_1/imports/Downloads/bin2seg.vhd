
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bin2seg is
    Port ( clear : in STD_LOGIC;
           bin_sec_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_sec_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_min_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_min_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   position : in STD_LOGIC_VECTOR(3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
		   an : out STD_LOGIC_VECTOR (7 downto 0)
    );
end bin2seg;

architecture Behavioral of bin2seg is
    signal bin  : STD_LOGIC_VECTOR (3 downto 0);

begin
    process (clear, bin) is
    begin
        if (clear = '1') then
            seg <= "1111111";
        else
			if (position = x"7") then
				bin <= bin_min_tens;
				an <= b"0111_1111";
				
			elsif (position = x"6") then
				bin <= bin_min_unit;
				an <= b"1011_1111";
				
			elsif (position	= x"5") then
				bin <= bin_sec_tens;
				an <= b"1101_1111";
				
			elsif (position = x"4") then 
				bin <= bin_sec_unit;
				an <= b"1110_1111";
				
				case bin is
					when x"0" =>
						seg <= "0000001";
					
					when x"1" =>
						seg <= "1001111";
						
					when x"2" =>
						seg <= "0010010";
						
					when x"3" =>
						seg <= "0000110";
					
					when x"4" =>
						seg <= "1001100";
					
					when x"5" =>
						seg <= "0100100";
					
					when x"6" =>
						seg <= "0100000";
					
					when x"7" =>
						seg <= "0001111";
						
					when x"8" =>
						seg <= "0000000";
					
					when x"9" =>
						seg <= "0000100";
						
					when others =>
						seg <= "1111111";
					
				end case;
			end if;
        end if;
    end process;

end Behavioral;