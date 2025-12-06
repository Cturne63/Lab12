----------------------------------------------------------------------------------
-- models what the AD9467 would do with a 125MHz clock
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ad_9467_model is
  Port (dco_p : out std_logic;
        dco_n : out std_logic;
        -- data out.  dout(7) corresponds to the line D15/14, 6 is 13/12...etc
        dout_p : out std_logic_vector(7 downto 0);
        dout_n : out std_logic_vector(7 downto 0)
         );
end ad_9467_model;

architecture Behavioral of ad_9467_model is
signal data_to_send : std_logic_Vector(15 downto 0);
signal ctr : unsigned(2 downto 0) := "000";
signal data_from_lut : std_logic_vector(15 downto 0);
type luttype is array(0 to 7) of integer;
-- this is the signed data that you want to see at your receiver.
-- the ADC will send an offset-binary version of this
signal lut : luttype := (0,7070,10000,7070,0,-7070,-10000,-7070);
--signal lut:luttype := (100,100,100,100,100,100,100,100);
begin

--data_to_send <= x"DEAD";
-- line below takes our signed data and sends it as offset binary like the ADC will do.
data_from_lut <= std_logic_Vector(to_unsigned(lut(to_integer(ctr))+32768,16));

process
-- whole process loops in 1 complete data cycle. 
begin
   
   data_to_send <= data_from_lut(15 downto 0);
   dco_p <= '1';
   dco_n <= '0';
   wait for 1 ns;
   dout_p <= data_to_send(15) & data_to_send(13) & data_to_send(11) & data_to_send(9) & data_to_send(7) & data_to_send(5) & data_to_send(3) & data_to_send(1);
   dout_n <= not (data_to_send(15) & data_to_send(13) & data_to_send(11) & data_to_send(9) & data_to_send(7) & data_to_send(5) & data_to_send(3) & data_to_send(1)); 
   wait for 2 ns;
   dout_p <= (others=>'X');
   dout_n <= (others=>'X');
   wait for 1 ns;
   dco_p <= '0';
   dco_n <= '1';
   wait for 1 ns;
   dout_p <= data_to_send(14) & data_to_send(12) & data_to_send(10) & data_to_send(8) & data_to_send(6) & data_to_send(4) & data_to_send(2) & data_to_send(0);
   dout_n <= not (data_to_send(14) & data_to_send(12) & data_to_send(10) & data_to_send(8) & data_to_send(6) & data_to_send(4) & data_to_send(2) & data_to_send(0));
   wait for 2 ns;
   dout_p <= (others=>'X');
   dout_n <= (others=>'X');
   ctr <= ctr+1;
   wait for 1 ns; 
 

end process;
    



end Behavioral;
