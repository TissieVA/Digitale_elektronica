--Tijs Van Alphen


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
signal FifoInCounter: integer:=0;

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


pFifo: process(pixelClk,FifoInCounter)
begin

if(rising_edge(pixelClk)) then
    
    if(FifoInCounter=0) then
    
        din(58 downto 43) <= sequence(15 downto 0);
     
     elsif (FifoInCounter = 1) then
        din(42 downto 27) <= sequence;
        
    elsif (FifoInCounter=2) then
        din(26 downto 11) <= sequence;
        
    elsif (FifoInCounter=3) then
        din(10 downto 2) <= sequence(16 downto 9);
    
    end if;
    
end if;

end process;

end Behavioral;