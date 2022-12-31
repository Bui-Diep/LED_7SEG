library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity numeric_led is
port (
	clk : in std_logic;
	nreset : in std_logic;
	anod : out std_logic_vector(3 downto 0);
	seg_7 : out std_logic_vector (6 downto 0);
	idle : out std_logic_vector (4 downto 0)
	);
end numeric_led;
architecture structure of numeric_led is
---------------------------------------------------
component counter10
port (
	clk : in std_logic ;
	reset : in std_logic;
	clock_enable : in std_logic;
	count_out : out std_logic_vector (3 downto 0)
	);
end component;
----------------------------------------------------
component clk_div20
generic (
	baudDivede : std_logic_vector (19 downto 0) := (others => '0')
		);
port (
	clk_in : in std_logic;
	clk_out : out std_logic
	);
end component;
------------------------------------------------------
component scan_digit
port (
	clk : in std_logic;
	reset : in std_logic;
	anod : out std_logic_vector(3 downto 0)
	);
end component;
--------------------------------------------------------
component bcd_adder
port (
	a, b : in std_logic_vector (3 downto 0);
	s1, s2 : out std_logic_vector (3 downto 0)
	);
end component;
--------------------------------------------------------
component bcd_7seg
port(
	nbcd : in std_logic_vector(3 downto 0);
	seg : out std_logic_vector (6 downto 0)
	);
end component;
------------------------------------------------------------
signal reset, cnt1_enable : std_logic;
signal clk1, clk0 : std_logic;
signal nbcd0, nbcd1, nbcd2, nbcd3, nbcd : std_logic_vector (3 downto 0);
signal anod_sig, nanod : std_logic_vector (3 downto 0);
begin
reset <= not (nreset);
cnt0: component counter10 
	port map (clk1, reset, '1', nbcd0);
	cnt1_enable <= '1' when nbcd0 = x"9" else '0';
cnt1: component counter10
	port map (clk1, reset, cnt1_enable, nbcd1);
bcda: component bcd_adder
	port map (nbcd0, nbcd1, nbcd3, nbcd2);
nanod <= not (anod_sig);
------------------------------------------------------
nbcd(0) <= (nanod(0) and nbcd0 (0)) or (nanod(1) and nbcd1 (0)) or (nanod(2) and nbcd2 (0)) or (nanod(3) and nbcd3 (0));
nbcd(1) <= (nanod(0) and nbcd0 (1)) or (nanod(1) and nbcd1 (1)) or (nanod(2) and nbcd2 (1)) or (nanod(3) and nbcd3 (1));
nbcd(2) <= (nanod(0) and nbcd0 (2)) or (nanod(1) and nbcd1 (2)) or (nanod(2) and nbcd2 (2)) or (nanod(3) and nbcd3 (2));
nbcd(3) <= (nanod(0) and nbcd0 (3)) or (nanod(1) and nbcd1 (3)) or (nanod(2) and nbcd2 (3)) or (nanod(3) and nbcd3 (3));

bcd_seg0: component bcd_7seg
	port map (nbcd, seg_7);
clk_div0: component clk_div20
	generic map (x"186a0")
	port map (clk, clk0);
clk_div1: component clk_div20
	generic map (x"000fa")
	port map (clk0, clk1);
scan0: component scan_digit
	port map (clk0, reset, anod_sig);
anod <= anod_sig;
idle <= (others =>'1');
end structure;

	