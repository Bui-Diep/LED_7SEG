library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity bcd_adder is
port (
	a, b : in std_logic_vector (3 downto 0);
	s1, s2 : out std_logic_vector (3 downto 0)
	);
end bcd_adder;
architecture behavioral of bcd_adder is
signal opa, opb, sum 	: std_logic_vector (4 downto 0);
signal temp 			: std_logic_vector (3 downto 0);
begin
opa <= '0'& a;
opb <= '0'& b;
sum <= opa + opb;
temp <= sum(3 downto 0) - "1010";
process (sum, temp)
begin
	if sum < x"10" then
		s1 <= x"0";
		s2 <= sum(3 downto 0);
	else
		s1 <= x"1";
		s2 <= temp(3 downto 0);
	end if;
end process;
end behavioral;

		