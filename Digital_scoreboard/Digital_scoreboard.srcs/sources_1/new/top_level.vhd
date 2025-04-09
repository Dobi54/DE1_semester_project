
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
    
    signal sig_50Hz   : std_logic;
    signal sig_1Hz   : std_logic;
			
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
   <port_name> => <signal_name>,
   <other ports>...
);
			
<instance_name> : <component_name>
generic map (
   <generic_name> => <value>,
   <other generics>...
)
port map (
   <port_name> => <signal_name>,
   <other ports>...
);
			
<instance_name> : <component_name>
generic map (
   <generic_name> => <value>,
   <other generics>...
)
port map (
   <port_name> => <signal_name>,
   <other ports>...
);
			
												
end Behavioral;
