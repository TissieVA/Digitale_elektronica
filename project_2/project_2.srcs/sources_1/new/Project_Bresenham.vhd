--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Project_Bresenham is
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
end Project_Bresenham;

architecture Behavioral of Project_Bresenham is

signal dx,dy,y,D,x: integer;
signal Plotting: std_logic:='0';
signal started: std_logic:='0';

begin

pValues: process(clk)
begin
    if rising_edge(clk) then
    
        if (Start= '1' and started = '0') then  --check if Start has been activated
        
            started<='1';             --Tell that start has been activated
            dx<=x1-x0;                --Give values to dx,dy,D
            dy<=y1-y0;
            D<= 2*dy-dx;
            y<=y0;                    --First values for y0 and x0
            x<=x0;
            Plotting<='1';           
               
         elsif(started='1' and plotting='1') then
         
         
          
            
        end if;
    end if;

end process;

end Behavioral;
