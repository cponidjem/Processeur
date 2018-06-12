----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:30 06/11/2018 
-- Design Name: 
-- Module Name:    memoireInstructProc - Behavioral 
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

library work;
use work.common.all;


entity memInstruct is
    Port ( ip : in  STD_LOGIC_VECTOR (15 downto 0);
           instruct : out  STD_LOGIC_VECTOR (31 downto 0));
end memInstruct;

architecture Behavioral of memInstruct is

signal tabMem : instrArray := init_rom("/home/ponidjem/2017_2018/Projet_Systeme/Compiler/hexa_asm.hex");

begin
	instruct <= tabMem(conv_integer(ip));

end Behavioral;

