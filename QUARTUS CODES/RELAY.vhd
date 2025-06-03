Library ieee; 
Use ieee.std_logic_1164.all; 
Use ieee.std_logic_unsigned.all; 
Use ieee.std_logic_arith.all; 
Entity RELAY is 
Port (sw : in std_logic; 
Rl1,led : out std_logic); 
End RELAY; 
Architecture behavioral of RELAY is 
Begin 
Rl1 <= ws; 
Led <= sw; 
End behavioral;  