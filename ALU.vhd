----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:20:37 05/14/2018 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
    Port ( OP_IN : in  STD_LOGIC_VECTOR (7 downto 0);
           ARG2_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           ARG3_IN : in  STD_LOGIC_VECTOR (15 downto 0);
           FLAG_OUT : out  STD_LOGIC_VECTOR (3 downto 0);
           S_OUT : out  STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Behavioral of ALU is
signal R_ADD : STD_LOGIC_VECTOR (16 downto 0);
signal R_MUL : STD_LOGIC_VECTOR (31 downto 0);
signal R : STD_LOGIC_VECTOR (15 downto 0);
signal R_EQU, R_INF, R_INFE, R_SUP, R_SUPE : STD_LOGIC;
begin
	R_EQU <= '1' when ARG2_IN = ARG3_IN else '0';
	R_INF <= '1' when ARG2_IN < ARG3_IN else '0';
	R_INFE <= '1' when ARG2_IN <= ARG3_IN else '0';
	R_SUP <= '1' when ARG2_IN > ARG3_IN else '0';
	R_SUPE <= '1' when ARG2_IN >= ARG3_IN else '0';
	
	R_ADD <= ('0' & ARG2_IN)+('0' & ARG3_IN);
	R_MUL <= ARG2_IN*ARG3_IN;
	
	R <= 	R_ADD (15 downto 0) when OP_IN = x"01" else
			R_MUL (15 downto 0) when OP_IN = x"02" else
			ARG2_IN-ARG3_IN when OP_IN = x"03" else
			x"000"&"000"&R_EQU when OP_IN = x"09" else
			x"000"&"000"&R_INF when OP_IN = x"0A" else
			x"000"&"000"&R_INFE when OP_IN = x"0B" else
			x"000"&"000"&R_SUP when OP_IN = x"0C" else
			x"000"&"000"&R_SUPE when OP_IN = x"0D";
			
	FLAG_OUT(0) <= R_ADD(16); -- carry
	FLAG_OUT(1) <= R(15); -- negative
	FLAG_OUT(2) <= (ARG2_IN(15) and ARG3_IN(15) and not R(15)) or (not ARG2_IN(15) and not ARG3_IN(15) and R(15)) when OP_IN = x"01" else
						(not (ARG2_IN(15) xor ARG3_IN(15)) and not R_MUL(15)) or ((ARG2_IN(15) xor ARG3_IN(15)) and R_MUL(15)) when OP_IN = x"02";	
	FLAG_OUT(3) <= '1' when R=x"0000" else '0'; -- = zero
	
	S_OUT <= R;
end Behavioral;

