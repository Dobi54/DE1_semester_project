library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity game_timer is
    Port (
        start_stop    : in  STD_LOGIC;  -- Input signal to start or stop the timer
        clk           : in  STD_LOGIC;  -- Clock input
        reset         : in  STD_LOGIC;  -- Asynchronous reset
        en            : in  STD_LOGIC;  -- Enable signal for timer update
        time_run      : out STD_LOGIC;  -- Output indicating that the timer is running
        time_pause    : out STD_LOGIC;  -- Output indicating that the timer is paused
        time_end      : out STD_LOGIC;  -- Output indicating that the countdown reached 00:00
        sec_out_unit  : out STD_LOGIC_VECTOR (3 downto 0); -- Units digit of seconds
        sec_out_tens  : out STD_LOGIC_VECTOR (3 downto 0); -- Tens digit of seconds
        min_out_unit  : out STD_LOGIC_VECTOR (3 downto 0); -- Units digit of minutes
        min_out_tens  : out STD_LOGIC_VECTOR (3 downto 0)  -- Tens digit of minutes
    );
end game_timer;

architecture Behavioral of game_timer is
    -- Internal counters for seconds and minutes
    signal sec_unit  : integer range 0 to 9 := 0;
    signal sec_tens  : integer range 0 to 5 := 0;
    signal min_unit  : integer range 0 to 9 := 0;
    signal min_tens  : integer range 0 to 2 := 2;

    -- Internal state signals
    signal running   : std_logic := '0';        -- Indicates if the timer is currently running
    signal pause   : std_logic := '0';          -- Indicates if the timer is currently pause
    signal time_runout : std_logic := '0';      -- Indicates if the countdown reached 00:00
    signal en_last      : STD_LOGIC := '0';     -- Previous value of enable, for edge detection

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- Set time to 20:00 and reset internal state
                sec_unit <= 0;
                sec_tens <= 0;
                min_unit <= 0;
                min_tens <= 2;
                running  <= '0';
		pause	 <= '0';
                time_runout <= '0';
                en_last <= '0';

            -- Detect rising edge on enable signal
            else
				if en = '1' and en_last = '0' then
					-- Change running state based on start_stop input
					if start_stop = '1' then
						running <= '1';  -- Start the timer
						pause <= '0';
					else
						running <= '0';  -- Pause the timer
						pause <= '1';
					end if;
				end if;	

                -- Proceed with countdown if timer is running and not finished
                if running = '1' and en = '1' then

                    -- If countdown reached 00:00, stop and signal end
                    if sec_unit = 0 and sec_tens = 0 and min_unit = 0 and min_tens = 0 then
                        time_runout <= '1';
                        running  <= '0';
                        pause <= '0';

                    -- Countdown logic
                    else
                        if sec_unit > 0 then
                            sec_unit <= sec_unit - 1;
                        else
                            sec_unit <= 9;
                            if sec_tens > 0 then
                                sec_tens <= sec_tens - 1;
                            else
                                sec_tens <= 5;
                                if min_unit > 0 then
                                    min_unit <= min_unit - 1;
                                else
                                    min_unit <= 9;
                                    if min_tens > 0 then
                                        min_tens <= min_tens - 1;
                                    end if;
                                end if;
                            end if;
                        end if;
                    end if;
                end if;
            end if;
            -- Save current enable state for edge detection in next cycle
            en_last <= en;
        end if;
    end process;

    -- Assign output signals
    time_run   <= running;                     -- High when timer is running
    time_pause <= pause;                       -- High when timer is paused
    time_end   <= time_runout;                 -- High when countdown reaches 00:00

    -- Convert internal integer time values to 4-bit binary for display
    sec_out_unit <= std_logic_vector(to_unsigned(sec_unit, 4));
    sec_out_tens <= std_logic_vector(to_unsigned(sec_tens, 4));
    min_out_unit <= std_logic_vector(to_unsigned(min_unit, 4));
    min_out_tens <= std_logic_vector(to_unsigned(min_tens, 4));

end Behavioral;
