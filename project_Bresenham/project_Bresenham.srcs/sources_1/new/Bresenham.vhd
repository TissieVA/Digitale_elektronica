--Tijs Van Alphen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Bresenham is
Port(
    x0: in integer;
    y0: in integer;
    x1: in integer;
    y1: in integer;
    Start: in std_logic;
    Clk: in std_logic;
    CurrentX: out integer;
    CurrentY: out integer
        
    );
end Bresenham;

architecture Behavioral of Bresenham is

type State_type IS (S,L,H);
    signal State: State_type;


begin

pClock: process(Clk)
begin
    if rising_edge(clk)  then
        
        Case State is
            When S =>
                
                
            
        end case;
    end if;
end process;

end Behavioral;
