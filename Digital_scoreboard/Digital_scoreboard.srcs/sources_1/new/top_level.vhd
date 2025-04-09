
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port ( CLK100MHZ : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           SW : in STD_LOGIC;
           CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           LED17_R : out STD_LOGIC;
           LED17_G : out STD_LOGIC;
           LED17_B : out STD_LOGIC);
end top_level;

architecture Behavioral of top_level is
   
    component clock_enable
    generic (
        N_PERIODS_50Hz : integer := 2_000_000; --! Default number of clk periodes to generate one pulse
    	N_PERIODS_1Hz : integer := 100_000_000 --! Default number of clk periodes to generate one pulse
    );
    port (
        clk      : in  std_logic; --! Hlavní hodinový signál 100 MHz
        rst      : in  std_logic; --! Synchronous reset
        clk1Hz   : out std_logic; --! Výstupní signál 1 Hz
        clk50Hz  : out std_logic  --! Výstupní signál 50 Hz
    );
    end component;
			

    component game_timer
    port (
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
    end component;
			

    component position_counter
    port (
        clk : in  STD_LOGIC;
        en   : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        position   : out STD_LOGIC_VECTOR (2 downto 0)
    );
    end component;
			

    component bin2seg
    port ( clear : in STD_LOGIC;
           bin_sec_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_sec_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_min_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_min_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   position : in STD_LOGIC_VECTOR(3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
		   an : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
	
	component bin2seg
    port ( clear : in STD_LOGIC;
           bin_sec_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_sec_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_min_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_min_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_point_team1_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_point_team1_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_point_team2_unit : in STD_LOGIC_VECTOR (3 downto 0);
		   bin_point_team2_tens : in STD_LOGIC_VECTOR (3 downto 0);
		   position : in STD_LOGIC_VECTOR(3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
		   an : out STD_LOGIC_VECTOR (7 downto 0)
    );
    end component;
    
    signal sig_50Hz   : std_logic;
    signal sig_1Hz   : std_logic;
    
    signal sig_sec_unit : std_logic_vector;
    signal sig_sec_tens : std_logic_vector;
    signal sig_min_unit : std_logic_vector;
    signal sig_min_tens : std_logic_vector;
    
    signal sig_position : std_logic_vector;
	
	signal sig_team1_unit : std_logic_vector;
	signal sig_team1_tens : std_logic_vector;
	signal sig_team2_unit : std_logic_vector;
	signal sig_team2_tens : std_logic_vector;
    
    signal sig_an : std_logic_vector;
			
begin

CLOCKEN : clock_enable
generic map (
   N_PERIODS_50Hz => 2_000_000,
   N_PERIODS_1Hz => 100_000_000
)
port map (
    clk => CLK100MHZ,
    rst => BTNC,
    clk1Hz => sig_1Hz,
    clk50Hz => sig_50Hz
);
			
TIMER : game_timer
port map (
    start_stop => SW,
    clk => CLK100MHZ,
    reset => BTNC,
    en => sig_1Hz,
    time_run => LED17_G,
    time_pause => LED17_B,
    time_end => LED17_R,
    sec_out_unit => sig_sec_unit,
    sec_out_tens => sig_sec_tens,
    min_out_unit => sig_min_unit,
    min_out_tens => sig_min_tens
);
			
POSITION : position_counter
port map (
    clk => CLK100MHZ,
    en => sig_50Hz,
    rst => BTNC,
    position => sig_position
   
);

SCORE : score_counter
port map (
    clk => CLK100MHZ,
    pointup_team1 => BTNL,
    pointup_team2 => BTNR,
    rst => BTND,
    score_team1_unit => sig_team1_unit,
    score_team1_tens => sig_team1_tens,
    score_team2_unit => sig_team2_unit,
    score_team2_tens => sig_team2_tens
);
			
DISPLAY : bin2seg
port map (
    clear => BTNC,
    bin_sec_unit => sig_sec_unit,
	bin_sec_tens => sig_sec_tens,
	bin_min_unit => sig_min_unit,
	bin_min_tens => sig_min_tens,
	bin_point_team1_unit => sig_team1_unit,
	bin_point_team1_tens => sig_team1_tens,
	bin_point_team2_unit => sig_team2_unit,
	bin_point_team2_tens => sig_team2_tens,
	position => sig_position,
    seg(6) => CA,
    seg(5) => CB,
    seg(4) => CC,
    seg(3) => CD,
    seg(2) => CE,
    seg(1) => CF,
    seg(0) => CG,
    an => sig_an
);

DP <= '1';			
AN(7 downto 0) <= sig_an;
												
end Behavioral;
