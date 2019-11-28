--Tijs Van Alphen
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.driehoek.ALL;

entity TriaglePrep is
  Port (
    CLK100MHZ: in std_logic;
    
    wea0: out std_logic_vector(0 downto 0);
    wea1: out std_logic_vector(0 downto 0);
    addra0 : out std_logic_vector(18 downto 0);
    addra1 : out std_logic_vector(18 downto 0);
    dina0: out std_logic_vector(2 downto 0);
    dina1: out std_logic_vector(2 downto 0);
    wena0: out std_logic;
    wena1: out std_logic
    
   );
end TriaglePrep;

architecture Behavioral of TriaglePrep is

constant amount: integer :=3;

signal sequence: std_logic_vector (56 downto 0);
signal wr_en, rd_en: std_logic:='0';
signal full, empty: std_logic;
signal dout, din: std_logic_vector (58 downto 0);

signal x0,x1,CurrentX: integer;
signal y0,y1,CurrentY: integer;
signal xcor1, xcor2, xcor3: std_logic_vector(9 downto 0);
signal ycor1, ycor2, ycor3: std_logic_vector(8 downto 0);
signal color: std_logic:='1';
signal last: std_logic:='0';

signal addra0_temp: std_logic_vector(18 downto 0) :="0000000000000000000";
signal addra1_temp: std_logic_vector(18 downto 0) :="0000000000000000000";

signal Start, Plotting, startedPlotting: STD_LOGIC;
signal TriangleCounter: integer:=0;

signal backgroundVid0, backgroundVid1: std_logic:='0';
signal WriteinMem0, WriteinMem1: std_logic:='0';

type Fi_State is (s_Filling, s_full);
signal StateOfFI: Fi_State:=s_Filling;
 
type Fo_state is (s_read, s_new, s_bresenham, s_wait);
signal StateOfFO: Fo_state:=s_new;

type Bresenham_State is (s_Br2 , s_Br3 , s_BrFin);
signal StateOfBres: Bresenham_State:= s_Br2;

type VidMem_State is (s_Background0, s_Background1,s_wait);
signal StateOfVidmem: VidMem_State:=s_background0;

begin

pm_Bresenham: Bresenham
Port map(
    x0 => x0,
    x1 =>x1,
    y0 => y0,
    y1 => y1,
    Clk => CLK100MHZ,
    start_in => start,
    X_out => CurrentX,
    Y_out => CurrentY,
    Plot => Plotting
);

pm_LFSR_ext : LFSR_ext
Port map(
    sequence_out =>sequence,
    clk=> CLK100MHZ
);

pm_Fifo: TriangleFifo
Port map(
    clk => CLK100MHZ,
    srst=>'0',
    din =>din,
    dout => dout,
    wr_en => wr_en,
    rd_en => rd_en,
    full => full,
    empty => empty
   );
   

addra0 <= addra0_temp;
addra1 <= addra1_temp;

p_traigle: process(CLK100MHZ) is
begin
if(rising_edge(CLK100MHZ)) then

--xcor1 <= sequence(56 downto 47);
--xcor2 <= sequence(46 downto 37);
--xcor3 <= sequence(36 downto 27);
--ycor1 <= sequence(26 downto 18);
--ycor2 <= sequence(17 downto 9);
--ycor3 <= sequence(8 downto 0);


Case StateOfFi is
    when s_filling =>
        
        if (to_integer(unsigned(Sequence(56 downto 47)))<=640 or to_integer(unsigned(Sequence(46 downto 37)))<=640 or to_integer(unsigned(Sequence(36 downto 27)))<=640 or  
        to_integer(unsigned(sequence(26 downto 18)))<=480 or to_integer(unsigned(sequence(17 downto 9)))<=480 or to_integer(unsigned(sequence(8 downto 0)))<=480) then
            
            din <= sequence & color & last;
            wr_en <= '1';
            triangleCounter <= triangleCounter +1;
        else 
            wr_en <= '0';
        end if;
        
        if full='1' then
            StateOfFi <= s_full;
            wr_en<='0';
        end if;
        
        if(amount <= triangleCounter) then
            last<='1';
            triangleCounter<=0;
        else
            last<='0';
        end if;
        
     when s_full =>
        
        if(full ='0') then
            StateOfFi <= s_filling;
        end if;
end case;

Case StateOfFo is
    when s_new =>
        rd_en <= '1';
        StateOfFo <= s_wait;
     
    when s_wait =>
        wea0 <= "0";
        wea1 <= "0";
        rd_en <='0';
        
        if empty ='0' then
            
            if backgroundVid0='1' then
                
                WriteInMem0 <= '1';
                start<='1';
                StateOfFo <= s_read;
            elsif backgroundVid1='1' then
                WriteInMem1 <= '1';
                start<='1';
                StateOfFo <= s_read;
            end if;
         end if;
         
      when s_read =>
        rd_en <='0';
        
        if empty='1' then
            StateOfFo <= s_wait;
        else 
                    --xcor1 <= sequence(56 downto 47);
                    --xcor2 <= sequence(46 downto 37);
                    --xcor3 <= sequence(36 downto 27);
                    --ycor1 <= sequence(26 downto 18);
                    --ycor2 <= sequence(17 downto 9);
                    --ycor3 <= sequence(8 downto 0);
            x0 <= to_integer(unsigned(dout(56 downto 47)));
            x1 <= to_integer(unsigned(dout(46 downto 37)));
            y0 <= to_integer(unsigned(dout(26 downto 18)));
            y1 <= to_integer(unsigned(dout(17 downto 9)));
            
            if(WriteInMem0= '1') then
                wea0 <="1";
            elsif(WriteInMem1= '1') then
                wea1 <= "1";
            end if;
            
            StateOfFo <= s_Bresenham;
        end if;
        
     when s_bresenham =>
        
        if(WriteInMem0 ='1') then
            if( StateofBres= s_BrFin and  plotting='0' and startedPlotting ='0') then
                addra0_temp <= "0000000000000000000";
            else
                addra0_temp <= std_logic_vector(to_unsigned((CurrentX)+((CurrentY)*640),19));
            end if;
       
            if (dout(1)='1') then
                dina0 <= "001";
            else
                dina0 <= "100";
            end if;
        
        elsif(WriteInMem1 ='1') then
            if(StateofBres= s_BrFin and  plotting='0' and startedPlotting ='0') then
                addra1_temp <= "0000000000000000000";
            else
                addra1_temp <= std_logic_vector(to_unsigned((CurrentX)+((CurrentY)*640),19));
            end if;
            
            if (dout(1)='1') then
                dina1 <= "001";
            else
                dina1 <= "100";
            end if;
        end if;
        
        if plotting='1' then
            startedplotting <= '1';
        end if;
        
        if (Plotting='0' and startedPlotting='1') then
            startedPlotting <= '0';
            
            Case StateOfBres is
                when s_br2 =>
                    
                    --xcor1 <= sequence(56 downto 47);
                    --xcor2 <= sequence(46 downto 37);
                    --xcor3 <= sequence(36 downto 27);
                    --ycor1 <= sequence(26 downto 18);
                    --ycor2 <= sequence(17 downto 9);
                    --ycor3 <= sequence(8 downto 0);
                    
                    x0 <= to_integer(unsigned(dout(46 downto 37)));
                    x1 <= to_integer(unsigned(dout(36 downto 27)));
                    y0 <= to_integer(unsigned(dout(17 downto 9)));
                    y1 <= to_integer(unsigned(dout(8 downto 0)));
                    
                    start <= '1';
                    
                    StateOfBres <= s_Br2;
               
               when s_Br3 =>
                    
                    x0 <= to_integer(unsigned(dout(56 downto 47)));
                    x1 <= to_integer(unsigned(dout(36 downto 27)));
                    y0 <= to_integer(unsigned(dout(26 downto 18)));
                    y1 <= to_integer(unsigned(dout(8 downto 0)));
                    
                    Start <= '1';
                    
                    StateOfBres <= s_brFin;
               
               when s_BrFin =>
                    wea0 <= "0";
                    wea1 <= "0";
                    
                    if(dout(0)='1') then
                        

end case;
end process;

end Behavioral;
