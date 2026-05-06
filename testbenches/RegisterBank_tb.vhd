library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Reg_Bank is
end TB_Reg_Bank;

architecture Behavioral of TB_Reg_Bank is

    component Reg_Bank
        port (
            Clk       : in  STD_LOGIC;
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
        end component;
        
        
        signal q0, q1, q2, q3, q4,q5, q6, q7, inval: std_logic_vector (3 downto 0);
        signal reset, clk: std_logic := '0';
        signal regsel : std_logic_vector ( 2 downto 0);
        
        
            

begin


        UUT: Reg_Bank
            port map (
                Clk => clk,
                Reg_sel => regsel,
                Input_val => inval,
                Reset => reset,
                Q0 => q0,
                Q1 => q1,
                Q2 => q2,
                Q3 => q3,
                Q4 => q4,
                Q5 => q5,
                Q6 => q6,
                Q7 => q7);


        clock_process: process
        begin
            clk <= not clk;
            wait for 50ns;
        end process;
        
        sim_process : process
        begin
            reset <= '1';
            wait for 100ns;
            reset <= '0';
            
            inval <= "0001";
            regsel <= "000";
            wait for 100ns;
                        
            regsel <= "001";
            wait for 100ns;
                                    
                                    
            regsel <= "011";
            wait for 100ns;
            
            regsel <= "100";
            wait for 100ns;
            
            regsel <= "101";
            wait for 100ns;
            
            regsel <= "110";
            wait for 100ns;
            
            regsel <= "111";
            wait for 200ns;
            
            reset <= '1';
            wait for 100ns;
            wait;
            
            
       end process; 
        
        


end Behavioral;