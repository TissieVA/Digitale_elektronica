--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LFSR is
Generic(
        seed: std_logic_vector(15 downto 0) :="1000000000000000"   --seed (8000)_16
        );
Port(
        sequence_out: out std_logic_vector(15 downto 0)
        );


end LFSR;

architecture Behavioral of LFSR is

signal sequence: std_logic_vector(15 downto 0):=seed;
signal newBit: std_logic;

begin

pLSFR : process(sequence)
begin

    newBit <= sequence(11) xor (sequence(13) xor (sequence(14) xor sequence(16))); 
    
    for i in 0 to 14
    loop
        sequence(i+1) <= sequence(i);  --sequence(1) becomes sequence(0), etc. last one: sequence(15) becomes sequence(14) 
        
    end loop;
    
    sequence(0) <= newBit;

end process;

end Behavioral;
