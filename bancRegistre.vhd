----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:38 05/15/2018 
-- Design Name: 
-- Module Name:    registre - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity registre is
    Port ( adra : in  STD_LOGIC_VECTOR (3 downto 0);
           adrb : in  STD_LOGIC_VECTOR (3 downto 0);
           adrw : in  STD_LOGIC_VECTOR (3 downto 0);
			  clk : in  STD_LOGIC;
			  w : in  STD_LOGIC;
			  data : in  STD_LOGIC_VECTOR (15 downto 0);
           qa : out  STD_LOGIC_VECTOR (15 downto 0);
           qb : out  STD_LOGIC_VECTOR (15 downto 0));
end registre;

architecture Behavioral of registre is
type typeBancRegistre is array (0 to 15) of STD_LOGIC_VECTOR (15 downto 0);
signal bancRegistre : typeBancRegistre;
begin
	qa <= data when adrw=adra and w='1' else
			bancRegistre(conv_integer(adra));
	qb <= data when adrw=adrb and w='1' else
			bancRegistre(conv_integer(adrb));
	process
		begin
		wait until rising_edge(clk);
		if w = '1' then
			bancRegistre(conv_integer(adrw)) <= data;
		end if;
	end process;
end Behavioral;

