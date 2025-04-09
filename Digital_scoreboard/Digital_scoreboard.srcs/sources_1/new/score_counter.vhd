library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity score_counter is
    Port ( 
        clk              : in  STD_LOGIC;  -- hodinový signál
        pointup_team1    : in  STD_LOGIC;  -- přidání bodu týmu 1
        pointup_team2    : in  STD_LOGIC;  -- přidání bodu týmu 2
        rst              : in  STD_LOGIC;  -- reset skóre
        score_team1_unit : out STD_LOGIC_VECTOR(3 downto 0); -- jednotky tým 1
        score_team1_tens : out STD_LOGIC_VECTOR(3 downto 0); -- desítky tým 1
        score_team2_unit : out STD_LOGIC_VECTOR(3 downto 0); -- jednotky tým 2
        score_team2_tens : out STD_LOGIC_VECTOR(3 downto 0)  -- desítky tým 2
    );
end score_counter;

architecture Behavioral of score_counter is

    signal team1_unit : integer range 0 to 9 := 0;
    signal team1_tens : integer range 0 to 9 := 0;

    signal team2_unit : integer range 0 to 9 := 0;
    signal team2_tens : integer range 0 to 9 := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                -- reset skóre obou týmů
                team1_unit <= 0;
                team1_tens <= 0;
                team2_unit <= 0;
                team2_tens <= 0;

            else
                -- přidání bodu pro tým 1
                if pointup_team1 = '1' then
                    if team1_unit = 9 then
                        team1_unit <= 0;
                        if team1_tens < 9 then
                            team1_tens <= team1_tens + 1;
                        end if;
                    else
                        team1_unit <= team1_unit + 1;
                    end if;
                end if;

                -- přidání bodu pro tým 2
                if pointup_team2 = '1' then
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
        end if;
    end process;

    -- převod výstupů na std_logic_vector
    score_team1_unit <= std_logic_vector(to_unsigned(team1_unit, 4));
    score_team1_tens <= std_logic_vector(to_unsigned(team1_tens, 4));
    score_team2_unit <= std_logic_vector(to_unsigned(team2_unit, 4));
    score_team2_tens <= std_logic_vector(to_unsigned(team2_tens, 4));

end Behavioral;
