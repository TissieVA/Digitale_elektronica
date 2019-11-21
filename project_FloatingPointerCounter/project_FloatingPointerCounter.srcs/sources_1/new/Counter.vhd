--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



entity Counter is
    Port(
        CLK100MHZ: in std_logic;
        A: in std_logic_vector(31 downto 0);
        B: in std_logic_vector(31 downto 0);
        Sum: out std_logic_vector(31 downto 0)
    
    );
end Counter;

architecture Behavioral of Counter is

signal Number1: std_logic_vector(31 downto 0);
signal Number2: std_logic_vector(31 downto 0);

begin

pCounter: process(A,B,CLK100MHZ)
begin

if(rising_edge(CLK100MHZ)) then
    Number1<=A;
    Number2<=B;
    if(Number1(31)='1' AND Number2(31)='0') then
        
    end if
end if;

end process;

end Behavioral;
