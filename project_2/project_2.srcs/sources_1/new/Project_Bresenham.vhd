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

signal dx,dy: integer:=0;
signal y,x,yi: integer:=0;
signal D :integer:=0;
signal Plotting: std_logic:='0';
signal started,low,high: std_logic:='0';

begin

pValues: process(clk)
begin
    if rising_edge(clk) then
    
        if (Start= '1' and started = '0') then  --check if Start has been activated
        
            started<='1';             --Tell that start has been activated
           
           if( abs(y1-y0)<abs(x1-x0) )then
                low<='1';
                
                if( x0 > x1) then
                
                    
                   if((y0-y1) <0) then          --if dy<0
                   
                        dx<=x0-x1;               
                        dy<=y1-y0;               --dy=-dy
                        
                        yi<=-1;
                        D<=2*(y1-y0)-(x0-x1);   --D=2*dy -dx but with dy=-dy
                   else
                        dx<=x0-x1;              --same as in previous if
                        dy<=y0-y1;
                        yi<=1;
                        
                   end if;
                   
                    D<=2*dy-dx;
                    y<=y0;
                    
                elsif(low='1') then
                    
                    if((y0-y1<0 and )then     --(y0-y1)<0 so we know what 
                        
                    
                     end if;
           
         
         
                end if;
            end if;
        end if;
    end if;

end process;

end Behavioral;
