--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:03:06 06/04/2018
-- Design Name:   
-- Module Name:   /home/ponidjem/2017_2018/Projet_Systeme/Microprocesseur/systemTest.vhd
-- Project Name:  Microprocesseur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: system
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY systemTest IS
END systemTest;
 
ARCHITECTURE behavior OF systemTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT system
    PORT(
         rst : IN  std_logic;
         rstRam : IN  std_logic;
         sens : IN  std_logic;
         Din : IN  std_logic_vector(15 downto 0);
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal rstRam : std_logic := '0';	
	signal rst : std_logic := '0';
   signal sens : std_logic := '1';
   signal Din : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '1';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: system PORT MAP (
          rst => rst,
          rstRam => rstRam,
          sens => sens,
          Din => Din,
          clk => clk
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here
		rst <= '1' after clk_period;

      wait;
   end process;

END;

