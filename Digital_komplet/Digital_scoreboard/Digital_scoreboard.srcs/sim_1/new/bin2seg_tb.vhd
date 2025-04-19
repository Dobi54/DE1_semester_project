library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bin2seg is
end tb_bin2seg;

architecture tb of tb_bin2seg is

    component bin2seg
        port (
            clk                   : in std_logic;
            clear                 : in std_logic;
            bin_sec_unit          : in std_logic_vector (3 downto 0);
            bin_sec_tens          : in std_logic_vector (3 downto 0);
            bin_min_unit          : in std_logic_vector (3 downto 0);
            bin_min_tens          : in std_logic_vector (3 downto 0);
            bin_point_team1_unit  : in std_logic_vector (3 downto 0);
            bin_point_team1_tens  : in std_logic_vector (3 downto 0);
            bin_point_team2_unit  : in std_logic_vector (3 downto 0);
            bin_point_team2_tens  : in std_logic_vector (3 downto 0);
            position              : in std_logic_vector (2 downto 0);
            seg                   : out std_logic_vector (6 downto 0);
            an                    : out std_logic_vector (7 downto 0)
        );
    end component;

    signal clk                   : std_logic := '0';
    signal clear                 : std_logic;
    signal bin_sec_unit          : std_logic_vector (3 downto 0);
    signal bin_sec_tens          : std_logic_vector (3 downto 0);
    signal bin_min_unit          : std_logic_vector (3 downto 0);
    signal bin_min_tens          : std_logic_vector (3 downto 0);
    signal bin_point_team1_unit  : std_logic_vector (3 downto 0);
    signal bin_point_team1_tens  : std_logic_vector (3 downto 0);
    signal bin_point_team2_unit  : std_logic_vector (3 downto 0);
    signal bin_point_team2_tens  : std_logic_vector (3 downto 0);
    signal position              : std_logic_vector (2 downto 0);
    signal seg                   : std_logic_vector (6 downto 0);
    signal an                    : std_logic_vector (7 downto 0);

begin

    -- Pøipojení DUT
    dut : bin2seg
        port map (
            clk                   => clk,
            clear                 => clear,
            bin_sec_unit          => bin_sec_unit,
            bin_sec_tens          => bin_sec_tens,
            bin_min_unit          => bin_min_unit,
            bin_min_tens          => bin_min_tens,
            bin_point_team1_unit  => bin_point_team1_unit,
            bin_point_team1_tens  => bin_point_team1_tens,
            bin_point_team2_unit  => bin_point_team2_unit,
            bin_point_team2_tens  => bin_point_team2_tens,
            position              => position,
            seg                   => seg,
            an                    => an
        );

    -- Generování hodinového signálu
    clk_process : process
    begin
        loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Stimulace
    stim_proc : process
    begin
        -- Inicializace
        clear <= '1';
        bin_sec_unit         <= "0100"; -- 4
        bin_sec_tens         <= "0010"; -- 2
        bin_min_unit         <= "0101"; -- 5
        bin_min_tens         <= "0001"; -- 1
        bin_point_team1_unit <= "0011"; -- 3
        bin_point_team1_tens <= "0000"; -- 0
        bin_point_team2_unit <= "1001"; -- 9
        bin_point_team2_tens <= "0001"; -- 1
        position <= "000";

        wait for 100 ns;
        clear <= '0';
        wait for 50 ns;

        -- Test jednotlivých pozic
        position <= "000";-- team2_unit
        bin_sec_unit         <= "0010"; -- 4
        bin_sec_tens         <= "0110"; -- 2
        bin_min_unit         <= "0100"; -- 5
        bin_min_tens         <= "0101"; -- 1
        bin_point_team1_unit <= "0111"; -- 3
        bin_point_team1_tens <= "1000"; -- 0
        bin_point_team2_unit <= "0111"; -- 9
        bin_point_team2_tens <= "0001"; -- 1
        position <= "000";

        wait for 100 ns;
        position <= "001"; wait for 100 ns; -- team2_tens
        position <= "010"; wait for 100 ns; -- team1_unit
        position <= "011"; wait for 100 ns; -- team1_tens
        position <= "100"; wait for 100 ns; -- sec_unit
        position <= "101"; wait for 100 ns; -- sec_tens
        position <= "110"; wait for 100 ns; -- min_unit
        position <= "111"; wait for 100 ns; -- min_tens

        -- Aktivace clear bìhem provozu
        clear <= '1';
        wait for 100 ns;
        clear <= '0';
        wait for 100 ns;

        -- Zmìna vstupu a opìtovné testování jedné pozice
        bin_sec_unit <= "0001"; -- 1
        position <= "100"; -- sec_unit
        wait for 100 ns;

        wait;
    end process;

end tb;
