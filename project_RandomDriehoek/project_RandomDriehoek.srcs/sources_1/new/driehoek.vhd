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

end package;