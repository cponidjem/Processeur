library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- il faut impérativement inclure ces deux bibliothèques
-- elles permettent d'importer les fonctions nécessaires 
-- à la lecture d'un fichier et à la conversion
use std.textio.all;
use ieee.std_logic_textio.all;

package common is

	constant LEN_SEL: natural := 16;
	constant LEN_INSTR: natural := 32;

	type instrArray is array(0 to 2**LEN_SEL-1) of std_logic_vector(LEN_INSTR-1 downto 0);

	-- le mot clé "impure" est important
	-- il permet de signaler que le résultat de la fonction n'est pas uniquement le produit de son entrée
	-- il peut y avoir des effets de bords lié aux opérations d'entrées-sorties 
	impure function init_rom(filename: string) return instrArray;

end package;



package body common is


	impure function init_rom(filename: string) return instrArray is
		file file_ptr: text;
		-- j'initialise tout à 1 car dans mon code, un bus de donnée remplie de 1 correspond à un NOP
		-- donc je sais que les instructions restantes ne peuvent pas changer l'état de mes mémoires
		variable rom: instrArray := (others => (others => '1'));
		variable f_line: line;
		variable slv_v : std_logic_vector(31 downto 0);
		variable lines_read: integer := 0;
	begin
		file_open(file_ptr, filename, READ_MODE);

		while (not endfile(file_ptr)) loop
			-- on lit la ligne f_line
			readline(file_ptr, f_line);
			-- on la convertie en bus de donnée
			hread(f_line, slv_v);
			-- on l'affecte dans la structure de donnée correspondant à la mémoire
			rom(lines_read) := slv_v;
			-- on incrémente le numéro de ligne courant 
			-- (utile uniquement pour mémoriser la ligne à laquelle on écrit dans notre structure de donnée) 
			lines_read := lines_read + 1;
		end loop;

		file_close(file_ptr);

		return rom;
	end function;

end common;


