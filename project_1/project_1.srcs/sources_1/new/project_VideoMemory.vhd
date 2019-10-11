--Tijs Van Alphen

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity project_VideoMemory is
Port(
    Clk100MHZ: in std_logic;                        --Clock from xdc file
    VGA_B : out std_logic_vector(3 downto 0);       --Blue color
    VGA_G : out std_logic_vector (3 downto 0);      --Green color  
    VGA_R : out std_logic_vector (3 downto 0);      --Red color
    VGA_HS : out std_logic;                         --Horizontal
    VGA_VS : out std_logic
    
    );
end project_VideoMemory;


architecture Behavioral of project_VideoMemory is

signal PixelClk: std_logic;
signal addrb: std_logic_vector(18 downto 0);
signal doutb: std_logic_vector(2 downto 0);        
signal Xpos, Ypos : integer;
signal Can_Write: std_logic;

component VideoMemory
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    clkb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
end component;

component ClockingWizard
port
 (-- Clock in ports
  -- Clock out ports
  PixelClk          : out    std_logic;
  Clk100MHz           : in     std_logic
 );
end component;

component Pixel_Pulser_V
port (
            clk_pixel: in std_logic;
            Xpos : out integer;             --Counts VisibleArea from H
            Ypos : out integer;             --Counts VisibleArea from V
            HSync: out std_logic; 
            Vsync: out std_logic;
            Can_Write: out std_logic);

end component;

begin

Clock : ClockingWizard
   port map ( 
  -- Clock out ports  
   PixelClk => PixelClk,
   -- Clock in ports
   Clk100MHz => Clk100MHz
 );

VideoMem : VideoMemory
  PORT MAP (
    clka => '0',
    wea => "0",
    addra => "0000000000000000000",
    dina => "000",
    clkb => PixelClk,
    web => "0",
    addrb => addrb,
    dinb => "000",
    doutb => doutb
  );
  
 Pulser_V : Pixel_Pulser_V
    port map (
        clk_pixel => PixelClk,
        Xpos => Xpos,
        Ypos => Ypos,
        HSync => VGA_HS,                    --Whe get Horizontal and veritcal signal back from Pixel_Pulser_V
        VSync => VGA_VS,                    --We give the values of these signals to the outputs with the same name as the xdc file
        Can_Write => Can_Write
);



pGetAddr: process(Xpos,Ypos)
begin

        addrb <= std_logic_vector(to_unsigned(Xpos+640*Ypos,19));


end process;

pOutput: process(Can_Write,doutb)
begin
    VGA_R <="0000";
    VGA_G <="0000";
    VGA_B <="0000";
    
    if(Can_Write = '1')
    then
        if(doutb(0)='1')
        then
            VGA_B <= "1111";
            end if;
        if(doutb(1)='1')
        then
            VGA_G <= "1111";
            end if;
        if(doutb(2)='1')
        then
            VGA_R <="1111";
            end if;
    
    end if;

end process;

end Behavioral;


