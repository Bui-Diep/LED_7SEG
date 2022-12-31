library IEEE;
use ieee.std_logic_1164.all;
entity bcd_7seg is
port(
	nbcd : in std_logic_vector(3 downto 0);
	seg : out std_logic_vector (6 downto 0)
	);
end bcd_7seg;
architecture behavioral of bcd_7seg is
signal temp : std_logic_vector (6 downto 0);
begin
process(nbcd)
  begin
	case nbcd is
									 --gfedcba
		when "0000" => temp <= "1000000"; --0
		when "0001" => temp <= "1111001"; --1
		when "0010" => temp <= "0100100"; --2
		when "0011" => temp <= "0110000"; --3
		when "0100" => temp <= "0011001"; --4
		when "0101" => temp <= "0010010"; --5
		when "0110" => temp <= "0000010"; --6
		when "0111" => temp <= "1111000"; --7
		when "1000" => temp <= "0000000"; --8
		when "1001" => temp <= "0010000"; --9
		when others => temp <= "XXXXXXX"; --vo dinh
	end case;
end process;
	seg <= temp;
end behavioral;