library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity clk_div20 is
generic (
	baudDivede : std_logic_vector (19 downto 0) := "00000"
		);
port (
	clk_in : in std_logic;
	clk_out : out std_logic
	);
end clk_div20;
architecture behavioral of clk_div20 is
signal cnt_div : std_logic_vector (19 downto 0);
signal clk_temp : std_logic := '0';
begin
process (clk_in, clk_temp, cnt_div)
begin
	if rising_edge (clk_in) then
		if cnt_div = baudDivede then
			cnt_div <= (others => '0');
			clk_temp <= not (clk_temp);
		else
			cnt_div <= cnt_div + 1 ;
		end if;
	end if;
end process;
clk_out <= clk_temp;
end behavioral;

		