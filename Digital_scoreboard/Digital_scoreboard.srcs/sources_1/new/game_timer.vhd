
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity game_timer is
    Port ( start_stop : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           en : in STD_LOGIC;
           time_run : out STD_LOGIC;
           time_pause : out STD_LOGIC;
           time_end : out STD_LOGIC;
           sec_out_unit : out STD_LOGIC_VECTOR (3 downto 0);
           sec_out_tens : out STD_LOGIC_VECTOR (2 downto 0);
           min_out_unit : out STD_LOGIC_VECTOR (3 downto 0);
           min_out_tens : out STD_LOGIC_VECTOR (1 downto 0));
end game_timer;

architecture Behavioral of game_timer is

begin


end Behavioral;
