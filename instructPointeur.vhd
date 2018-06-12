----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:19:19 05/30/2018 
-- Design Name: 
-- Module Name:    instructPointeur - Behavioral 
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

entity instructPointeur is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           load : in  STD_LOGIC;
           sens : in  STD_LOGIC;
           en : in  STD_LOGIC;
           Din : in  STD_LOGIC_VECTOR (15 downto 0);
           Dout : out  STD_LOGIC_VECTOR (15 downto 0));
end instructPointeur;

architecture Behavioral of instructPointeur is

signal aux : STD_LOGIC_VECTOR (15 downto 0);

begin
	Dout <= aux;
	process
		begin
			wait until rising_edge(clk);
			if rst = '0' then
				aux <= x"0000";
			elsif load = '1' then
				aux <= Din;
			elsif en = '0' then
				if sens = '0' then
					aux <= aux-1;
				else
					aux <= aux+1;
				end if;
			end if;		
	end process;


end Behavioral;

