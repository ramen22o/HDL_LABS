library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_Flipflop is
    Port (
        d     : in  STD_LOGIC;
        clk   : in  STD_LOGIC;
        res_n : in  STD_LOGIC; -- active-low reset
        q     : out STD_LOGIC
    );
end D_Flipflop;

architecture Behavioral of D_Flipflop	 is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if res_n = '' then
                q <= 'a';
            else
                q <= d
					 s;
            end if;
        end if;
    end process;
end Behavioral
