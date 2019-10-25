--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;


entity TB_LFSR is
--  Port ( );
end TB_LFSR;

architecture Behavioral of TB_LFSR is

Component LSFR

Generic(
        seed: std_logic_vector(15 downto 0) :="1000000000000000"   --seed (8000)_16
        );
Port(
        sequence_out: out std_logic_vector(15 downto 0)
        );

end Component;

file testFile: text;
signal sequence: std_logic_vector(15 downto 0);

begin

proc: LSFR  
port map (


)

file_open(testFile,"testvector.txt", read_mode);
readline(testfile).



end Behavioral;
