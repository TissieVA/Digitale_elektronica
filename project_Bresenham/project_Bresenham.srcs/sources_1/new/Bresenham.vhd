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
    Start_in: in std_logic;
    Clk: in std_logic;
    X_out: out integer;
    Y_out: out integer;
    Plot: out std_logic
    );
end Bresenham;

architecture Behavioral of Bresenham is

type State_type IS (START,START_CON,BUSY);
    signal State: State_type:=START;

signal dx,dy,sx,sy: integer;
signal err,e2: integer;
signal TempX0, TempX1, TempY0, TempY1: integer;
signal CurrentX,CurrentY: integer:=0;

begin

pClock: process(Clk)
begin
    if rising_edge(clk)  then
        
        Case State is           
            When START =>           
            
                Plot <= '0';        
                
                if(Start_in='1') then           --input start is 1
                
                TempX0 <= x0;
                TempX1 <= x1;
                TempY0 <= y0;
                TempY1 <= y1;
                state <= START_CON;            --case state to start conditions
                
                end if;
             
            When START_CON =>                   --Start conditions
            
                Plot <='0';
                dx <= abs(TempX1-TempX0);
                
                if(TempX0>TempX1) then
                    sx <= 1;
                else 
                    sx <= -1;
                end if;
                
                dy <= -abs(TempY1-TempY0);
                
                if(TempY0<TempY1) then
                    sy <= 1;
                else
                    sy <= -1;
                end if;
                
                err <= dx+dy;
                
                CurrentX<=TempX0;
                CurrentY<= TempY0;
                    
                State <= BUSY;                  --case state to busy
                
            When BUSY =>                        --Busy, calculates X and Y value for output
                
                if(CurrentX /= x1 AND CurrentY /=y0) then       --If x and y hasn't got to their end values
                
                    Plot<='1';
                    
                    e2<= 2*err;
                    
                    if(e2 > dy) then
                        err <= err+dy;
                        CurrentX <= CurrentX+sx;
                        
                        if(e2 < dx) then
                            err <= err + dx +dy;
                            CurrentY <= CurrentY + sy;
                        end if;
                        
                    elsif (e2 < dx) then
                     
                     err <= err + dx +dy;
                            CurrentY <= CurrentY + sy;
                        end if;
                    
                    X_out <= CurrentX;
                    Y_out <= CurrentY;
                
                else                                        --When we reached the end
                    X_out <= CurrentX;
                    Y_out <= CurrentY;
                    plot <= '1';
                    State <= START;                         --Get out of BUSY state
                    
                end if;
        end case;
    end if;
end process;

end Behavioral;
