----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:24:59 06/04/2018 
-- Design Name: 
-- Module Name:    system - Behavioral 
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

entity system is
	Port (rst : IN  std_logic;
			rstRam : IN std_logic;
         load : IN  std_logic;
         sens : IN  std_logic;
         Din : IN  std_logic_vector(15 downto 0);
			clk : IN std_logic);
end system;

architecture Structural of system is
	COMPONENT processeur
    PORT(
         rst : IN  std_logic;
         load : IN  std_logic;
         sens : IN  std_logic;
         Din : IN  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         ins_di : IN  std_logic_vector(31 downto 0);
         data_do : OUT  std_logic_vector(15 downto 0);
         data_a : OUT  std_logic_vector(15 downto 0);
         data_we : OUT  std_logic;
         data_di : IN  std_logic_vector(15 downto 0);
         ins_a : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	
	COMPONENT memInstruct
    Port ( 
			ip : in  STD_LOGIC_VECTOR (15 downto 0);
			instruct : out  STD_LOGIC_VECTOR (31 downto 0)
		);
    END COMPONENT;
    
	component bram16
		generic (
			init_file : String := "none";
			adr_width : Integer := 11);
		port (
			-- System
			sys_clk : in std_logic;
			sys_rst : in std_logic;
			-- Master
			di : out std_logic_vector(15 downto 0);
			we : in std_logic;
			a : in std_logic_vector(15 downto 0);
			do : in std_logic_vector(15 downto 0));
	end component;
		
		signal do,a,di, ins_a : std_logic_vector(15 downto 0);
		signal ins_di : std_logic_vector(31 downto 0);
		signal we : std_logic;
begin
	proc : processeur PORT MAP(rst,load,sens,Din,clk,ins_di,do,a,we,di,ins_a);
	ram : bram16 PORT MAP(clk,rstRam,di,we,a,do);
	memoireInstruct : memInstruct PORT MAP(ins_a,ins_di);

end Structural;

