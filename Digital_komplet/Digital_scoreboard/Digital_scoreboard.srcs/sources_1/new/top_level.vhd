library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port (
        CLK100MHZ : in STD_LOGIC;  -- 100 MHz main clock input
        BTNC : in STD_LOGIC;       -- Center button: Reset
        BTNL : in STD_LOGIC;       -- Left button: Add point to team 1
        BTNR : in STD_LOGIC;       -- Right button: Add point to team 2
        BTND : in STD_LOGIC;       -- Down button: Reset scores
        SW   : in STD_LOGIC;       -- Switch: Start/Stop timer
        CA : out STD_LOGIC;        -- 7-segment segment A
        CB : out STD_LOGIC;        -- 7-segment segment B
        CC : out STD_LOGIC;        -- 7-segment segment C
        CD : out STD_LOGIC;        -- 7-segment segment D
        CE : out STD_LOGIC;        -- 7-segment segment E
        CF : out STD_LOGIC;        -- 7-segment segment F
        CG : out STD_LOGIC;        -- 7-segment segment G
        DP : out STD_LOGIC;        -- Decimal point
        AN : out STD_LOGIC_VECTOR(7 downto 0); -- Display digit enable
        LED17_R : out STD_LOGIC;   -- Red LED: Time ended
        LED17_G : out STD_LOGIC;   -- Green LED: Timer running
        LED17_B : out STD_LOGIC    -- Blue LED: Timer paused
    );
end top_level;

architecture Behavioral of top_level is

    -- Clock enable component
    component clock_enable
        generic (
            N_PERIODS_50Hz : integer := 2_000_000;   -- 50 Hz pulse
            N_PERIODS_1Hz  : integer := 100_000_000  -- 1 Hz pulse
        );
        port (
            clk      : in  std_logic;
            rst      : in  std_logic;
            clk1Hz   : out std_logic;
            clk50Hz  : out std_logic
        );
    end component;

    -- Game timer component
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
            sec_out_tens  : out STD_LOGIC_VECTOR (3 downto 0);
            min_out_unit  : out STD_LOGIC_VECTOR (3 downto 0);
            min_out_tens  : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    -- Display position counter component
    component position_counter
        port (
            clk      : in  STD_LOGIC;
            en       : in  STD_LOGIC;
            rst      : in  STD_LOGIC;
            position : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Bin2seg component
    component bin2seg
        port (
            clear                  : in STD_LOGIC;
            bin_sec_unit           : in STD_LOGIC_VECTOR (3 downto 0);
            bin_sec_tens           : in STD_LOGIC_VECTOR (3 downto 0);
            bin_min_unit           : in STD_LOGIC_VECTOR (3 downto 0);
            bin_min_tens           : in STD_LOGIC_VECTOR (3 downto 0);
            bin_point_team1_unit   : in STD_LOGIC_VECTOR (3 downto 0);
            bin_point_team1_tens   : in STD_LOGIC_VECTOR (3 downto 0);
            bin_point_team2_unit   : in STD_LOGIC_VECTOR (3 downto 0);
            bin_point_team2_tens   : in STD_LOGIC_VECTOR (3 downto 0);
            position               : in STD_LOGIC_VECTOR(2 downto 0);
            seg                    : out STD_LOGIC_VECTOR (6 downto 0);
            an                     : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Score counter component
    component score_counter
        port (
            clk              : in  STD_LOGIC;
            pointup_team1    : in  STD_LOGIC;
            pointup_team2    : in  STD_LOGIC;
            rst              : in  STD_LOGIC;
            score_team1_unit : out STD_LOGIC_VECTOR(3 downto 0);
            score_team1_tens : out STD_LOGIC_VECTOR(3 downto 0);
            score_team2_unit : out STD_LOGIC_VECTOR(3 downto 0);
            score_team2_tens : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Internal signals
    signal sig_50Hz        : std_logic;
    signal sig_1Hz         : std_logic;

    signal sig_sec_unit    : std_logic_vector(3 downto 0);
    signal sig_sec_tens    : std_logic_vector(3 downto 0);
    signal sig_min_unit    : std_logic_vector(3 downto 0);
    signal sig_min_tens    : std_logic_vector(3 downto 0);

    signal sig_position    : std_logic_vector(2 downto 0);

    signal sig_team1_unit  : std_logic_vector(3 downto 0);
    signal sig_team1_tens  : std_logic_vector(3 downto 0);
    signal sig_team2_unit  : std_logic_vector(3 downto 0);
    signal sig_team2_tens  : std_logic_vector(3 downto 0);

    signal sig_an          : std_logic_vector(7 downto 0);

begin

    CLOCKEN : clock_enable
        generic map (
            N_PERIODS_50Hz => 2_000_000,
            N_PERIODS_1Hz  => 100_000_000
        )
        port map (
            clk     => CLK100MHZ,
            rst     => BTNC,
            clk1Hz  => sig_1Hz,
            clk50Hz => sig_50Hz
        );

    TIMER : game_timer
        port map (
            start_stop    => SW,
            clk           => CLK100MHZ,
            reset         => BTNC,
            en            => sig_1Hz,
            time_run      => LED17_G,
            time_pause    => LED17_B,
            time_end      => LED17_R,
            sec_out_unit  => sig_sec_unit,
            sec_out_tens  => sig_sec_tens,
            min_out_unit  => sig_min_unit,
            min_out_tens  => sig_min_tens
        );

    POSITION : position_counter
        port map (
            clk      => CLK100MHZ,
            en       => sig_50Hz,
            rst      => BTNC,
            position => sig_position
        );

    SCORE : score_counter
        port map (
            clk              => CLK100MHZ,
            pointup_team1    => BTNL,
            pointup_team2    => BTNR,
            rst              => BTND,
            score_team1_unit => sig_team1_unit,
            score_team1_tens => sig_team1_tens,
            score_team2_unit => sig_team2_unit,
            score_team2_tens => sig_team2_tens
        );

    DISPLAY : bin2seg
        port map (
            clear                => BTNC,
            bin_sec_unit         => sig_sec_unit,
            bin_sec_tens         => sig_sec_tens,
            bin_min_unit         => sig_min_unit,
            bin_min_tens         => sig_min_tens,
            bin_point_team1_unit => sig_team1_unit,
            bin_point_team1_tens => sig_team1_tens,
            bin_point_team2_unit => sig_team2_unit,
            bin_point_team2_tens => sig_team2_tens,
            position             => sig_position,
            seg(6)               => CA,
            seg(5)               => CB,
            seg(4)               => CC,
            seg(3)               => CD,
            seg(2)               => CE,
            seg(1)               => CF,
            seg(0)               => CG,
            an                   => sig_an
        );

    -- Disable decimal point
    DP <= '1';

    -- Assign digit enable output
    AN(7 downto 0) <= sig_an;

end Behavioral;
