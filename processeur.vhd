----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:04 05/30/2018 
-- Design Name: 
-- Module Name:    processeur - Behavioral 
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

entity processeur is
	Port (rst : IN  std_logic;
         sens : IN  std_logic;
         Din : IN  std_logic_vector(15 downto 0);
			clk : IN std_logic;
			ins_di : IN std_logic_vector(31 downto 0);
			
			data_do : OUT std_logic_vector(15 downto 0);
			data_a : OUT std_logic_vector(15 downto 0);
			data_we: OUT std_logic;
			data_di : IN std_logic_vector(15 downto 0);
			ins_a : OUT std_logic_vector(15 downto 0)
			);			
			
end processeur;

architecture Structural of processeur is

    COMPONENT pipeline
    Port ( EN : in STD_LOGIC;
			  NOP : in  STD_LOGIC;
			  CK : in  STD_LOGIC;
         OP_IN : IN  std_logic_vector(7 downto 0);
         ARG1_IN : IN  std_logic_vector(15 downto 0);
         ARG2_IN : IN  std_logic_vector(15 downto 0);
         ARG3_IN : IN  std_logic_vector(15 downto 0);
         FLAG_IN : IN  std_logic_vector(3 downto 0);
         OP_OUT : OUT  std_logic_vector(7 downto 0);
         ARG1_OUT : OUT  std_logic_vector(15 downto 0);
         ARG2_OUT : OUT  std_logic_vector(15 downto 0);
         ARG3_OUT : OUT  std_logic_vector(15 downto 0);
         FLAG_OUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
	 
	 COMPONENT instructPointeur
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         load : IN  std_logic;
         sens : IN  std_logic;
         en : IN  std_logic;
         Din : IN  std_logic_vector(15 downto 0);
         Dout : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT decodeurInstruct
    PORT(
         instruct32 : IN  std_logic_vector(31 downto 0);
         op : OUT  std_logic_vector(7 downto 0);
         arga : OUT  std_logic_vector(15 downto 0);
         argb : OUT  std_logic_vector(15 downto 0);
         argc : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT ALU
    PORT(
         OP_IN : IN  std_logic_vector(7 downto 0);
         ARG2_IN : IN  std_logic_vector(15 downto 0);
         ARG3_IN : IN  std_logic_vector(15 downto 0);
         FLAG_OUT : OUT  std_logic_vector(3 downto 0);
         S_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
    COMPONENT registre
    PORT(
         adra : IN  std_logic_vector(3 downto 0);
         adrb : IN  std_logic_vector(3 downto 0);
         adrw : IN  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         w : IN  std_logic;
         data : IN  std_logic_vector(15 downto 0);
         qa : OUT  std_logic_vector(15 downto 0);
         qb : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
	 
	COMPONENT mux
	PORT(
		input : IN  std_logic;
		arg0 : IN  std_logic_vector(15 downto 0);
		arg1 : IN  std_logic_vector(15 downto 0);
		argout : OUT  std_logic_vector(15 downto 0)
	  );
	END COMPONENT;
	
	 COMPONENT gestionAleas
    PORT(
         op_lidi : IN  std_logic_vector(7 downto 0);
         b_lidi : IN  std_logic_vector(15 downto 0);
         c_lidi : IN  std_logic_vector(15 downto 0);
         op_diex : IN  std_logic_vector(7 downto 0);
         a_diex : IN  std_logic_vector(15 downto 0);
         op_exmem : IN  std_logic_vector(7 downto 0);
         a_exmem : IN  std_logic_vector(15 downto 0);
         conflict : OUT  std_logic
        );
    END COMPONENT;
	
	signal instruct32 : std_logic_vector(31 downto 0);
	signal w, conflict, freeze, sortieMuxJump : std_logic;
	signal flag4, flag6, flag7 : std_logic_vector(3 downto 0);
	signal op, op2, op3, op4, op5  : std_logic_vector(7 downto 0);
	signal 	arga, argb, argc,
				arga2, argb2, argc2,
				qa, qb,
				arga4, argb4, argc4,
				argb5,
				arga6, argb6,
				adrw, data,
				sortieMux, sortieMux2, sortieMux3, sortieMux4,
				Dout: std_logic_vector(15 downto 0);
begin
	ip : instructPointeur PORT MAP(clk,rst,sortieMuxJump,sens,freeze,arga4,ins_a);
	--instmem : memInstruct PORT MAP(Dout, instruct32);
   dec : decodeurInstruct PORT MAP (ins_di, op, arga, argb, argc);
	lidi : pipeline PORT MAP (freeze, '0', clk, op, arga, argb, argc, "0000", op2, arga2, argb2, argc2, open);
	bancReg : registre PORT MAP(argb2(3 downto 0), argc2(3 downto 0), adrw(3 downto 0), clk, w, sortieMux4, qa, qb);
	diex : pipeline PORT MAP ('0', freeze, clk, op2, arga2, sortieMux, qb, "0000", op3, arga4, argb4, argc4, open);
	--ual : ALU PORT MAP(op3, x"0000",argb4, argc4, flag4, argb5);
	ual : ALU PORT MAP(op3,argb4, argc4, flag4, argb5);	
	exmem : pipeline PORT MAP('0', '0', clk, op3, arga4, sortieMux2, x"0000", flag4, op4, arga6, argb6, open, flag6);
	data_do <= argb6;
	data_a <= sortieMux3;
	data_we <= '1' when op4 = x"08" else '0';	
	memre : pipeline PORT MAP('0', '0', clk, op4, arga6, argb6, x"0000", flag6, op5 , adrw, data, open, flag7);
	sortieMux <= argb2 when op2 = x"06" or op2 = x"07" or op2 = x"0E" else qa;
	sortieMuxJump <= '1' when op3 = x"0E" or (op3 = x"0F" and argc4 = x"0000")
							else '0';
	sortieMux2 <= 	argb5 when op3 = x"01" or op3 = x"02" or op3 = x"03" or op3 = x"09" or op3 = x"0A" or op3 = x"0B" or op3 = x"0C" or op3 = x"0D"
						else argc4 when op3 = x"08" or op3 = x"0F"
						else argb4;
						---------------------------------
	sortieMux3 <= arga6 when op4 = x"08" else argb6;
	sortieMux4 <= data_di when op5 = x"07" else data;
	--w <= '0' when op5 = x"08" or op5 = x"0E" or op5 = x"0F" else '1';
	w <= '1' when op5 = x"01" or op5 = x"02" or op5 = x"03"
				or op5 = x"04" or op5 = x"05" or op5 = x"06"
				or op5 = x"07" or op5 = x"09" or op5 = x"0A"
				or op5 = x"0B" or op5 = x"0C" or op5 = x"0D"
			else '0';
	gestaleas :gestionAleas PORT MAP(op2,argb2,argc2, op3, arga4, op4, arga6, conflict);
	freeze <= conflict or sortieMuxJump;
	
end Structural;
