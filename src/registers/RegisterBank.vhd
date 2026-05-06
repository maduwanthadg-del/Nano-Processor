library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Reg_Bank is
    Port ( Clk       : in  STD_LOGIC;
           Reg_sel   : in  STD_LOGIC_VECTOR (2 downto 0);
           Input_val : in  STD_LOGIC_VECTOR (3 downto 0);
           Reset     : in  STD_LOGIC;
           Q0        : out STD_LOGIC_VECTOR (3 downto 0);
           Q1        : out STD_LOGIC_VECTOR (3 downto 0);
           Q2        : out STD_LOGIC_VECTOR (3 downto 0);
           Q3        : out STD_LOGIC_VECTOR (3 downto 0);
           Q4        : out STD_LOGIC_VECTOR (3 downto 0);
           Q5        : out STD_LOGIC_VECTOR (3 downto 0);
           Q6        : out STD_LOGIC_VECTOR (3 downto 0);
           Q7        : out STD_LOGIC_VECTOR (3 downto 0));
end Reg_Bank;

architecture Behavioral of Reg_Bank is

    component Decoder_3_to_8
        port (
            I  : in  std_logic_vector (2 downto 0);
            Y  : out std_logic_vector (7 downto 0)
        );
    end component;
   
    component Reg
        port (
            En    : in  std_logic;
            Clk   : in  std_logic;
            reset : in  std_logic;
            Data  : in  std_logic_vector (3 downto 0);
            Q     : out std_logic_vector (3 downto 0)
        );
    end component; 
   
    signal y : std_logic_vector (7 downto 0);

begin

    Decoder_0 : Decoder_3_to_8
        port map (
            I  => Reg_sel,
            Y  => y
        );

    Reg_0 : Reg
        port map (
            En    =>y(0),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q0,
            reset => Reset
        );

    Reg_1 : Reg
        port map (
            En    => y(1),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q1,
            reset => Reset
        );

    Reg_2 : Reg
        port map (
            En    => Y(2),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q2,
            reset => Reset
        );

    Reg_3 : Reg
        port map (
            En    => y(3),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q3,
            reset => Reset
        );

    Reg_4 : Reg
        port map (
            En    => y(4),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q4,
            reset => Reset
        );

    Reg_5 : Reg
        port map (
            En    => y(5),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q5,
            reset => Reset
        );

    Reg_6 : Reg
        port map (
            En    => y(6),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q6,
            reset => Reset
        );

    Reg_7 : Reg
        port map (
            En    => y(7),
            Clk   => Clk,
            Data  => Input_val,
            Q     => Q7,
            reset => Reset
        );

end Behavioral;