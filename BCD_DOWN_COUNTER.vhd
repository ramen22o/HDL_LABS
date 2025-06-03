library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_DOWN_COUNTER is
Port (
    clk     : in  STD_LOGIC;   -- Clock (PIN_23)
    reset_n : in  STD_LOGIC;   -- Active-low reset (PIN_25)
    bcd_out : out STD_LOGIC_VECTOR(3 downto 0) -- QD,QC,QB,QA (MSB to LSB)
);
end BCD_DOWN_COUNTER;

architecture Behavioral of BCD_DOWN_COUNTER is
    signal counter : STD_LOGIC_VECTOR(3 downto 0) := "1001"; -- Start at 9
    signal slow_clk : STD_LOGIC := '0';
    signal clk_divider : integer range 0 to 12500000 := 0; -- 2Hz @ 50MHz
begin

    -- Clock divider for visible counting
    process(clk)
    begin
        if rising_edge(clk) then
            if clk_divider = 12500000 then 
                slow_clk <= not slow_clk;
                clk_divider <= 0;
            else
                clk_divider <= clk_divider + 1;
            end if;
        end if;
    end process;

    -- BCD Down Counter Logic
    process(reset_n, slow_clk)
    begin
        if reset_n = '0' then
            counter <= "1001"; -- Reset to 9
        elsif rising_edge(slow_clk) then
            if counter = "0000" then -- 0 in decimal
                counter <= "1001";   -- Reset to 9
            else
                counter <= counter - 1; -- Decrement
            end if;
        end if;
    end process;

    -- Active-low LED output (0=LED ON, 1=LED OFF)
    bcd_out <= not counter;
    
end Behavioral;
