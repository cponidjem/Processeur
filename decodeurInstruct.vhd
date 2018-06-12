----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:01:59 05/29/2018 
-- Design Name: 
-- Module Name:    decodeurInstruct - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodeurInstruct is
    Port ( instruct32 : in  STD_LOGIC_VECTOR (31 downto 0);
           op : out  STD_LOGIC_VECTOR (7 downto 0);
           arga : out  STD_LOGIC_VECTOR (15 downto 0);
           argb : out  STD_LOGIC_VECTOR (15 downto 0);
           argc : out  STD_LOGIC_VECTOR (15 downto 0));
end decodeurInstruct;

architecture Behavioral of decodeurInstruct is

begin
	op <= instruct32(31 downto 24);
	arga <= instruct32(23 downto 8) when instruct32(31 downto 24) = x"08" or instruct32(31 downto 24) = x"0E" or instruct32(31 downto 24) = x"0F" else
				x"00" & instruct32(23 downto 16);
	argb <= instruct32(15 downto 0) when instruct32(31 downto 24) = x"06" or instruct32(31 downto 24) = x"07" else
				x"00" & instruct32(15 downto 8);
	argc <= x"00" & instruct32(7 downto 0);

end Behavioral;

