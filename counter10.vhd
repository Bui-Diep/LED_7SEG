library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter10 is	
port (
	clk : in std_logic ;
	reset : in std_logic;
	clock_enable : in std_logic;
	count_out : out std_logic_vector (3 downto 0)
	);
end counter10;
architecture behavioral of counter10 is
signal cnt : std_logic_vector (3 downto 0);
begin
process (clk, reset)
begin
	if reset = '1' then
		cnt <= (others => '0');
	elsif rising_edge (clk) then
		if clock_enable = '1' then
			if cnt = x"9" then
				cnt <= x"0";
			else
				cnt <= cnt + 1 ;
			end if;
		end if;
	end if;
end process;
count_out <= cnt;
end behavioral;

		