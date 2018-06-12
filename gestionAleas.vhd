----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:01:19 06/06/2018 
-- Design Name: 
-- Module Name:    gestionAleas - Behavioral 
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

entity gestionAleas is
    Port ( op_lidi : in  STD_LOGIC_VECTOR (7 downto 0);
           b_lidi : in  STD_LOGIC_VECTOR (15 downto 0);
           c_lidi : in  STD_LOGIC_VECTOR (15 downto 0);
           op_diex : in  STD_LOGIC_VECTOR (7 downto 0);
           a_diex : in  STD_LOGIC_VECTOR (15 downto 0);
           op_exmem : in  STD_LOGIC_VECTOR (7 downto 0);
           a_exmem : in  STD_LOGIC_VECTOR (15 downto 0);
			  conflict : out STD_LOGIC);
end gestionAleas;

architecture Behavioral of gestionAleas is
	signal lidi_read : std_logic;
	signal diex_write : std_logic;
	signal exmem_write : std_logic;
	
begin

	lidi_read <= 	'0' when op_lidi = x"06" or op_lidi = x"07" or op_lidi = x"0E" or op_lidi = x"FF" else '1';
	diex_write <= 	'0' when op_diex = x"08" or op_diex = x"0E" or op_diex = x"0F" or op_diex = x"FF" else '1';
	exmem_write <= '0' when op_exmem = x"08" or op_exmem = x"0E" or op_exmem = x"0F" or op_exmem = x"FF" else '1';
	
	conflict <= '1' when	(lidi_read = '1' and diex_write = '1' and (b_lidi = a_diex or c_lidi = a_diex))
							or	(lidi_read = '1' and exmem_write = '1' and (b_lidi = a_exmem or c_lidi = a_exmem))
					else '0';
end Behavioral;

