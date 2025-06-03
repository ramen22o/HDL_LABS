library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SEVEN_SEGMENT_DISPLAY_INTERFACE	is
Port (
    clk     : in  STD_LOGIC;   -- 4MHz clock (PIN_23)
    rst     : in  STD_LOGIC;   -- Active-high reset (PIN_25)
    seg     : out STD_LOGIC_VECTOR(6 downto 0);  -- Active-low segments a-g
    dig     : out STD_LOGIC_VECTOR(3 downto 0)   -- Active-low digit enables
);
end SEVEN_SEGMENT_DISPLAY_INTERFACE;

architecture Behavioral of SEVEN_SEGMENT_DISPLAY_INTERFACE is
    -- Clock divider signals
    signal counter     : unsigned(23 downto 0) := (others => '0');
    signal clk_1hz     : STD_LOGIC := '0';
    
    -- Hex counter
    signal hex_value   : unsigned(3 downto 0) := "0000";
    
    -- Display signals
    signal dig_sel     : unsigned(1 downto 0) := "00";
begin


    process(clk, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            hex_value <= "0000";
        elsif rising_edge(clk) then
            if counter = x"F42400" then -- 0.25Hz (4 seconds per count)
                counter <= (others => '0');
                hex_value <= hex_value + 1;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    -- Digit scanner (244Hz refresh)
    dig_sel <= counter(15 downto 14);  -- 4MHz/2^16 = ~244Hz
    
    -- Single-digit display (all digits show same value)
    dig <= "1110" when dig_sel = "00" else  -- DIG1
           "1101" when dig_sel = "01" else  -- DIG2
           "1011" when dig_sel = "10" else  -- DIG3
           "0111";                          -- DIG4

    -- Active-low hex decoder (common cathode)
    with hex_value select
        seg <= "0000001" when x"0",  -- 0
               "1001111" when x"1",  -- 1
               "0010010" when x"2",  -- 2
               "0000110" when x"3",  -- 3
               "1001100" when x"4",  -- 4
               "0100100" when x"5",  -- 5
               "0100000" when x"6",  -- 6
               "0001111" when x"7",  -- 7
               "0000000" when x"8",  -- 8
               "0000100" when x"9",  -- 9
               "0001000" when x"A",  -- A
               "1100000" when x"B",  -- B
               "0110001" when x"C",  -- C
               "1000010" when x"D",  -- D
               "0110000" when x"E",  -- E
               "0111000" when others; -- F
end Behavioral;

