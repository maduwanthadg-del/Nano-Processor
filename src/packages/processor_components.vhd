----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2025 04:38:37 AM
-- Design Name: 
-- Module Name: processor_components - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.buses.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


package processor_components is

       component MUX_3_4
            port (
                A : in data_bus;
                B : in data_bus;
                C : in data_bus;
                Sel : in std_logic_vector (1 downto 0);
                Y : out data_bus);
                
      end component;
    
       component Instruction_decoder
            port (
                Instruction: in instruction_bus;
                Jump_Register_Value: in data_bus;
                Register_enable: out register_address;
                Register_select_A : out register_address;
                Register_select_B: out register_address;
                Operation: out std_logic;
                immediate_value: out data_bus;
                Jump_flag: out std_logic;
                Jump_address: out instruction_address;
                Load_select: out std_logic_vector (1 downto 0);
                Waiting_flag : out std_logic);
                
 
      end component;
      
      component program_counter_incrementor 
        port (
            in_address: in instruction_address;
            increment_enable : in std_logic;
            out_address: out instruction_address);
      end component;
      
      
       component Load_immediate_selector 
        port (
            ALU_value : in data_bus;
            immediate_value : in data_bus;
            Load_select: in std_logic;
            Out_value: out data_bus );
            
       end component;
       
       component LUT_16_7
            port (
                address : in STD_LOGIC_VECTOR (3 downto 0);
                data : out STD_LOGIC_VECTOR (6 downto 0));
                
       end component;
       
       
       component MUX_8_4
            port (
                 S : in bus_3_bit;
                 D : in data_buses;
                 Y : out bus_4_bit);
                 
                 
       end component;
       
       component Program_ROM
            port (
                ROM_address : in instruction_address;
                I: out instruction_bus);
                
       end component;
       
       
       component jump_pc_selector
            port (
                program_counter_address: in instruction_address;
                jump_address : in instruction_address;
                jump_flag : in std_logic;
                jump_pc_selector_out: out instruction_address); 
       end component;
                
                
               
                
                
                
       component Program_counter
            port (
                Reset : in std_logic;
                Clk : in std_logic;
                PC_in: in instruction_address;
                PC_out: out instruction_address);
                
                
       end component;
       
       component Register_bank
            port (
                Reg_En     : in register_address;
                Res        : in STD_LOGIC;
                Clk        : in STD_LOGIC;
                Data       : in data_bus;
                Data_Buses : out data_buses
                );
                
       end component;
       
       
       component Adder_subtractor
            port (
                 A : in std_logic_vector(3 downto 0);
                     B : in std_logic_vector(3 downto 0);
                     CTRL : in std_logic; -- 0 = Add, 1 = Subtract
                     S : out std_logic_vector(3 downto 0);
                     Zero : out std_logic;
                     Overflow : out std_logic
                 );
                 
      end component;
      
      component Slow_Clk
            port (
                Clk_in : in std_logic;
                Clk_out : out std_logic);
      end component;
       
  end package processor_components;
       
       
       
                
       
       
                
                
