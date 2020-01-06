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
        CLK100MHZ: in std_logic;                        --Clock from xdc file
        VGA_B : out std_logic_vector(3 downto 0);       --Blue color
        VGA_G : out std_logic_vector (3 downto 0);      --Green color  
        VGA_R : out std_logic_vector (3 downto 0);      --Red color
        VGA_HS : out std_logic;                         --Horizontal
        VGA_VS : out std_logic
    );

end project_Driehoeken;

architecture Behavioral of project_Driehoeken is

signal pixelClk: std_logic;
signal wea0,wea1 : STD_LOGIC_VECTOR(0 DOWNTO 0);
signal addra0,addra1 : STD_LOGIC_VECTOR(18 DOWNTO 0);
signal dina0, dina1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal addrb0, addrb1 : STD_LOGIC_VECTOR(18 DOWNTO 0);
signal doutb0, doutb1 : STD_LOGIC_VECTOR(2 DOWNTO 0);
signal Xpos, Ypos: integer;
signal Can_Write, wena0, wena1: std_logic;

signal WriteInVidmem0: STD_LOGIC;
signal WriteInVidmem1: STD_LOGIC;

begin

pmTrianglePrep: TrianglePrep
    port map(
    CLK100MHZ => CLK100MHZ,
    wea0 => wea0,
    wea1 => wea1,
    addra1 => addra1,
    addra0 => addra0,
    dina0 => dina0,
    dina1 => dina1,
    writeinvidmem0 => writeinvidmem0,
    writeinvidmem1 => writeinvidmem1,
    wena0 => wena0,
    wena1 => wena1
    );

pmClockingWizard : ClockingWizard
   port map ( 
        PixelClk => PixelClk,
        Clk100MHz => Clk100MHz
 );

pmVideoMem0: VideoMemory
    Port map(
    clka => clk100mhz, 
    wea =>wea0,
    addra =>addra0,
    dina =>dina0,
    douta => open,
    clkb =>pixelclk,
    web =>"0",
    addrb =>"0000000000000000000",
    dinb =>"000",
    doutb => doutb0
    );

pmVideoMem1: VideoMemory
    Port map(
    clka => clk100mhz, 
    wea =>wea1,
    addra =>addra1,
    dina =>dina1,
    douta =>open,
    clkb =>pixelclk,
    web =>"0",
    addrb =>"0000000000000000000",
    dinb =>"000",
    doutb => doutb1
    );

    
pmPixelPulserV: Pixel_Pulser_V
    port map(
            clk_pixel => pixelclk,
            Xpos   => Xpos,           
            Ypos => Ypos,
            HSync => VGA_HS,
            Vsync => VGA_VS,
            Can_Write => Can_Write
    );
    

    
p_Display: process(Can_Write,doutb1,WriteInVidmem0,WriteInVidmem1) is 
begin
        VGA_R<= "1111";
        VGA_B <= "0000";
        VGA_G <= "0000";
    if Can_Write='1' then 
        if WriteInVidmem0='0' then          --amg enkel als niet in vidmem wordt gegschreven
            if (doutb0(0 downto 0)="1") then 
                VGA_B<="1111";
            else 
                VGA_B<="0000";
            end if;
            
            if (doutb0(1 downto 1)="1") then 
                VGA_G<="1111";
            else 
                VGA_G<="0000";
            end if;
            
            if (doutb0(2 downto 2)="1") then 
                VGA_R<="1111";
            else 
                VGA_R<="0000";
            end if;
        elsif WriteInVidmem1='0' then
            if (doutb1(0 downto 0)="1") then 
                VGA_B<="1111";
            else 
                VGA_B<="0000";
            end if;
            
            if (doutb1(1 downto 1)="1") then 
                VGA_G<="1111";
            else 
                VGA_G<="0000";
            end if;
            
            if (doutb1(2 downto 2)="1") then 
                VGA_R<="1111";
            else 
                VGA_R<="0000";
            end if;
        
        end if;
   
    end if;
     
end process p_Display;


end Behavioral;