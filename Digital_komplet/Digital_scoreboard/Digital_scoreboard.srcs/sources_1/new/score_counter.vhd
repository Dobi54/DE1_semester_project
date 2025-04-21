library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity score_counter is
    Port ( 
        clk              : in  STD_LOGIC;  -- Clock signal
        pointup_team1    : in  STD_LOGIC;  -- Add point for team 1
        pointup_team2    : in  STD_LOGIC;  -- Add point for team 2
        rst              : in  STD_LOGIC;  -- Reset score for both teams
        score_team1_unit : out STD_LOGIC_VECTOR(3 downto 0); -- Units digit for team 1 score
        score_team1_tens : out STD_LOGIC_VECTOR(3 downto 0); -- Tens digit for team 1 score
        score_team2_unit : out STD_LOGIC_VECTOR(3 downto 0); -- Units digit for team 2 score
        score_team2_tens : out STD_LOGIC_VECTOR(3 downto 0)  -- Tens digit for team 2 score
    );
end score_counter;

architecture Behavioral of score_counter is

    -- Internal counters for both teams (units and tens digits)
    signal team1_unit : integer range 0 to 9 := 0;
    signal team1_tens : integer range 0 to 9 := 0;

    signal team2_unit : integer range 0 to 9 := 0;
    signal team2_tens : integer range 0 to 9 := 0;

    -- Previous states of input buttons for edge detection
    signal last_pointup_team1 : std_logic := '0';
    signal last_pointup_team2 : std_logic := '0';

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- Reset score for both teams to 00
                team1_unit <= 0;
                team1_tens <= 0;
                team2_unit <= 0;
                team2_tens <= 0;
            else
                -- Detect rising edge of pointup_team1 signal
                if pointup_team1 = '1' and last_pointup_team1 = '0' then
                    if team1_unit = 9 then
                        team1_unit <= 0;
                        if team1_tens < 9 then
                            team1_tens <= team1_tens + 1;
                        end if;
                    else
                        team1_unit <= team1_unit + 1;
                    end if;
                end if;

                -- Detect rising edge of pointup_team2 signal
                if pointup_team2 = '1' and last_pointup_team2 = '0' then
                    if team2_unit = 9 then
                        team2_unit <= 0;
                        if team2_tens < 9 then
                            team2_tens <= team2_tens + 1;
                        end if;
                    else
                        team2_unit <= team2_unit + 1;
                    end if;
                end if;
            end if;

            -- Store previous button states for edge detection in the next cycle
            last_pointup_team1 <= pointup_team1;
            last_pointup_team2 <= pointup_team2;
        end if;
    end process;

    -- Convert internal integer values to 4-bit std_logic_vector for display output
    score_team1_unit <= std_logic_vector(to_unsigned(team1_unit, 4));
    score_team1_tens <= std_logic_vector(to_unsigned(team1_tens, 4));
    score_team2_unit <= std_logic_vector(to_unsigned(team2_unit, 4));
    score_team2_tens <= std_logic_vector(to_unsigned(team2_tens, 4));

end Behavioral;
