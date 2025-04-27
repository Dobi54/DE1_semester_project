library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity position_counter is
    Port (
        clk      : in  STD_LOGIC;                    -- Clock input
        en       : in  STD_LOGIC;                    -- Enable input for counting
        rst      : in  STD_LOGIC;                    -- Asynchronous reset
        position : out STD_LOGIC_VECTOR (2 downto 0) -- 3-bit output representing the current position
    );
end position_counter;

architecture Behavioral of position_counter is
    -- Internal signal to hold the current position as an integer (range 0 to 7)
    signal sig_position : integer range 0 to 7 := 7;

    -- Previous value of 'en' for edge detection
    signal en_last      : STD_LOGIC := '0';
begin

    process(clk)
    begin
        if rising_edge(clk) then
            -- If reset is active, set position to initial value (7)
            if rst = '1' then
                sig_position <= 7;

            -- On rising edge of 'en'
            elsif en = '1' and en_last = '0' then
                -- If counter reaches 0, wrap around to 7
                if sig_position = 0 then
                    sig_position <= 7;
                else
                    -- Otherwise, decrement the position
                    sig_position <= sig_position - 1;
                end if;
            end if;

            -- Store the current value of 'en' for edge detection in the next clock cycle
            en_last <= en;
        end if;
    end process;

    -- Convert internal integer position to 3-bit std_logic_vector for output
    position <= std_logic_vector(to_unsigned(sig_position, 3));

end Behavioral;
