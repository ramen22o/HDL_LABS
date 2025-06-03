library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SYNCHRONOUS_BINARY_UP_COUNTER is
Port (
    clk     : in  STD_LOGIC;   -- 50MHz clock (PIN_23)
    reset_n : in  STD_LOGIC;   -- Active-low reset (PIN_25)
    leds    : out STD_LOGIC_VECTOR(2 downto 0) -- LEDs (PIN_87,86,85)
);
end SYNCHRONOUS_BINARY_UP_COUNTER;

architecture Behavioral of SYNCHRONOUS_BINARY_UP_COUNTER is
    signal counter     : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal slow_clk    : STD_LOGIC := '0';
    signal clk_divider : integer range 0 to 12500000 := 0; -- 2Hz @ 50MHz
begin
    -- Clock divider (for visible counting)
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

    -- Synchronous counter process
    process(reset_n, slow_clk)
    begin
        if reset_n = '0' then  -- Active-low reset
            counter <= "000";
        elsif rising_edge(slow_clk) then
            counter <= counter + 1; -- All bits update simultaneously
        end if;
    end process;

    -- LED outputs (active-high configuration)
    leds <= counter;
    
end Behavioral;
