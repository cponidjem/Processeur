----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:36:10 05/14/2018 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
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

entity pipeline is
    Port ( EN : in STD_LOGIC;
			  NOP : in  STD_LOGIC;
			  CK : in  STD_LOGIC;
			  OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           ARG1_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           ARG2_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           ARG3_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           FLAG_IN : in  STD_LOGIC_VECTOR (3 downto 0);
           OP_OUT : out  STD_LOGIC_VECTOR (7 downto 0);
           ARG1_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           ARG2_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           ARG3_OUT : out  STD_LOGIC_VECTOR (15 downto 0);
           FLAG_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
end pipeline;

architecture Behavioral of pipeline is


begin
	process
		begin
		wait until rising_edge(CK);
		if (NOP='1') then
			OP_OUT <= x"FF";
			ARG1_OUT <= x"FFFF";
			ARG2_OUT <= x"FFFF";
			ARG3_OUT <= x"FFFF";
			FLAG_OUT <= "0000";
		elsif EN = '0' then
			OP_OUT <= OP_IN;
			ARG1_OUT <= ARG1_IN;
			ARG2_OUT <= ARG2_IN;
			ARG3_OUT <= ARG3_IN;
			FLAG_OUT <= FLAG_IN;
		end if;
		
	end process;


end Behavioral;
