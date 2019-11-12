--Tijs Van Alphen

-- 58 downto 49 is x cor 1
-- 48 downto 39 is x cor 2
-- 38 downto 29 is x cor 3
-- 28 downto 20 is y cor 1
-- 19 downto 11 is y cor 2
-- 10 downto 2 is y cor 3
-- 1 is color
-- 0 i last

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.driehoek.ALL;


entity project_Driehoeken is
    Port(
        CLK100MHZ: in std_logic
    );

end project_Driehoeken;

architecture Behavioral of project_Driehoeken is

signal color: std_logic:='0';
signal full, wr_en, rd_en: std_logic:='0';
signal empty: std_logic:='1';
signal sequence: std_logic_vector(15 downto 0);
signal din, dout: std_logic_vector(58 downto 0);
signal pixelClk: std_logic;
signal FifoInCounter, BresenhamCounter: integer:=0;
signal x0, x1, y0, y1, x_out, y_out: integer;
signal Start_in, Plot: std_logic;


begin

Clock: ClockingWizard
    port map(
        Clk100Mhz => CLK100MHZ,
        PixelClk => Pixelclk
        );
        

Fifo : TriangleFifo

    Port map (
    clk => pixelclk,
    srst => '0',
    din => din,
    wr_en => wr_en,
    rd_en => rd_en,
    dout => dout,
    full => full,
    empty => empty
    );
    
pmLFSR : LFSR
    port map(
        sequence_out => sequence,
        clk => pixelclk
    );

pmBresenham : Bresenham
    Port Map (
        x0 => x0,
        x1 => x1,
        y0 => y0,
        y1 => y1,
        start_in => start_in,
        Clk => pixelclk,
        X_out =>x_out,
        Y_out => y_out,
        Plot => Plot
    
    );


pFifo: process(pixelClk,FifoInCounter)
begin


if(rising_edge(pixelClk)) then
    
    if(FifoInCounter=0) then
    
        din(58 downto 43) <= sequence;
     
     elsif (FifoInCounter = 1) then
        din(42 downto 27) <= sequence;
        
    elsif (FifoInCounter=2) then
        din(26 downto 11) <= sequence;
        
    elsif (FifoInCounter=3) then
        din(10 downto 2) <= sequence(16 downto 9);
        FifoInCounter <=0;
        rd_en <= '1';
    
    end if;
   end if;

end process;

pPrepareFrame: process(dout)
 begin
 
    if(rd_en ='1') then
        rd_en <='0';
        Start_in <= '1';
        
        if(BresenhamCounter =0 ) then
        x0<= to_integer(signed(dout(58 downto 49)));   
        x1<= to_integer(signed(dout(48 downto 39)));
        y0<= to_integer(signed(dout(28 downto 20)));
        y1<= to_integer(signed(dout(19 downto 10)));
        
        BresenhamCounter <= BresenhamCounter+1; 
        
        elsif(BresenhamCounter = 1) then
        x0<= to_integer(signed(48 downto 39));
        x1 <= to_integer(signed(38 downto 29));
        y0 <= to_integer()
        
    
    end if;
 
 end process;



end Behavioral;