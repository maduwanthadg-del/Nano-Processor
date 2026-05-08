library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;

entity Register_Bank is
    Port ( 
        Reg_En     : in register_address;
        Res        : in STD_LOGIC;
        Clk        : in STD_LOGIC;
        Data       : in data_bus;
        Data_Buses : out data_buses
    );
end Register_Bank;

architecture Behavioral of Register_Bank is

    component Reg
        Port (
            Data  : in STD_LOGIC_VECTOR (3 downto 0);
            En    : in STD_LOGIC;
            Clk   : in STD_LOGIC;
            Reset : in STD_LOGIC;
            Q     : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

    signal Reg_Sel : STD_LOGIC_VECTOR(7 downto 0);

begin

    Decoder_3_to_8_0 : entity work.Decoder_3_to_8
        port map(
            I => Reg_En,
            Y => Reg_Sel
        );

    -- Read-Only Register (Register 0)
    reg0: Reg
        port map(
            Data  => "0000",
            Reset => Res,
            En    => '1',
            Clk   => Clk,
            Q     => Data_Buses(0)
        );

    -- Register 1
    reg1: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(1),
            Clk   => Clk,
            Q     => Data_Buses(1)
        );

    -- Register 2
    reg2: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(2),
            Clk   => Clk,
            Q     => Data_Buses(2)
        );

    -- Register 3
    reg3: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(3),
            Clk   => Clk,
            Q     => Data_Buses(3)
        );

    -- Register 4
    reg4: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(4),
            Clk   => Clk,
            Q     => Data_Buses(4)
        );

    -- Register 5
    reg5: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(5),
            Clk   => Clk,
            Q     => Data_Buses(5)
        );

    -- Register 6
    reg6: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(6),
            Clk   => Clk,
            Q     => Data_Buses(6)
        );

    -- Register 7
    reg7: Reg
        port map(
            Data  => Data,
            Reset => Res,
            En    => Reg_Sel(7),
            Clk   => Clk,
            Q     => Data_Buses(7)
        );

end Behavioral;
