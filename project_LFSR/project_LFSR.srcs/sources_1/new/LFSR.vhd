--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LFSR is
Generic(
        seed: std_logic_vector(15 downto 0) :="1000000000000000"   --seed (8000)_16
        );
Port(
        sequence_out: out std_logic_vector(15 downto 0);
        clk: in std_logic
        );


end LFSR;

architecture Behavioral of LFSR is

signal sequence: std_logic_vector(0 to 15):=seed;

begin

pLSFR : process(clk)
begin

    if(rising_edge(clk)) then
    
        sequence(0) <= sequence(10) xor (sequence(12) xor (sequence(13) xor sequence(15))); 
        
        for i in 0 to 14
        loop
            sequence(i+1) <= sequence(i);  --sequence(1) becomes sequence(0), etc. last one: sequence(15) becomes sequence(14) 
            
        end loop;
        
    end if;
end process;

 sequence_out <= sequence;

end Behavioral;
