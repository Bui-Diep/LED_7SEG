library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity scan_digit is
port (
	clk : in std_logic;
	reset : in std_logic;
	anod : out std_logic_vector(3 downto 0)
	);
end scan_digit;
architecture behavioral of scan_digit is
signal anod_sig	: std_logic_vector (3 downto 0);
begin
process (clk, reset)
begin
	if reset = '1' then
		anod_sig <= "1110";
	elsif rising_edge (clk) then
		anod_sig <= anod_sig(0) & anod_sig(3 downto 1);
	end if;
end process;
anod <= anod_sig;
end behavioral;

		