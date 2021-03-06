library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package driehoek is

Component LFSR 
    Port(
    sequence_out: out std_logic_vector(15 downto 0);
    clk: in std_logic
    );
    end component;

Component Bresenham
    Port(
        x0: in integer;
        y0: in integer;
        x1: in integer;
        y1: in integer;
        start_in: in std_logic;
        Clk: in std_logic;
        X_out: out integer;
        Y_out: out integer;
        Plot: out std_logic
        );
end component;

component Pixel_Pulser_V
    port(
        clk_pixel: in std_logic;
        Xpos: out integer;
        Ypos: out integer;
        HSync: out std_logic;
        Can_Write: out std_logic
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

COMPONENT TriangleFifo
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(58 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(58 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END COMPONENT;

COMPONENT VideoMemory
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
END COMPONENT;

end package;