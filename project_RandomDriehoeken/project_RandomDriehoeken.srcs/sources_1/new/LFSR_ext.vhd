--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity LFSR_ext is
Generic(
        seed: std_logic_vector(56 downto 0) :=(13=>'1',14=>'1',23=>'1',24=>'1',others => '0')
        );
Port(
        sequence_out: out std_logic_vector(56 downto 0);
        clk: in std_logic
        );


end LFSR_ext;

architecture Behavioral of LFSR_ext is

signal sequence: std_logic_vector(0 to 56):=seed;

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
