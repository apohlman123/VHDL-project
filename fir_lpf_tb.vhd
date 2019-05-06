LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE STD.textio.ALL;
USE IEEE.std_logic_textio.ALL;
USE IEEE.math_real.ALL;

--    constant h1: signed := -0.09497759843642214;
--    constant h2: signed := -0.038914360562545804
--    constant h3: signed := 0.04958737191549309
--    constant h4: signed := -0.06666555337837443
--    constant h5: signed := 0.08574119096252337
--    constant h6: signed := -0.1028003956553136
--    constant h7: signed := 0.11457611654122428
--    constant h8: signed := 0.8815418621409236
--    constant h9: signed := 0.11457611654122428
--    constant h10: signed := -0.1028003956553136
--    constant h11: signed := 0.08574119096252337
--    constant h12: signed := -0.0666655533783744 
--    constant h13: signed := 0.04958737191549309
--    constant h14: signed := -0.038914360562545804
--    constant h15: signed := -0.09497759843642214

entity fir_lpf_tb is
end fir_lpf_tb;

architecture Behavioral of fir_lpf_tb is
        type array1 is array(0 to 6280) of integer;
        type array2 is array(0 to 628) of integer;
        signal filter_clk_s  : std_logic;
        signal filter_rst_s  : std_logic;
        signal input_dataL_s  : std_logic_vector(7 downto 0);
        signal input_dataR_s : std_logic_vector(7 downto 0);
        signal coeff1_s      : std_logic_vector(15 downto 0);
        signal coeff2_s      : std_logic_vector(15 downto 0);
        signal coeff3_s      : std_logic_vector(15 downto 0);
        signal coeff4_s      : std_logic_vector(15 downto 0);
        signal coeff5_s      : std_logic_vector(15 downto 0);
        signal coeff6_s      : std_logic_vector(15 downto 0);
        signal coeff7_s      : std_logic_vector(15 downto 0);
        signal coeff8_s      : std_logic_vector(15 downto 0);
        signal coeff9_s      : std_logic_vector(15 downto 0);
        signal coeff10_s     : std_logic_vector(15 downto 0);
        signal coeff11_s     : std_logic_vector(15 downto 0);
        signal coeff12_s     : std_logic_vector(15 downto 0);
        signal coeff13_s     : std_logic_vector(15 downto 0);
        signal coeff14_s     : std_logic_vector(15 downto 0);
        signal coeff15_s     : std_logic_vector(15 downto 0);
        signal summationL_s  : signed(7 downto 0);
        signal summationR_s  : signed(7 downto 0);
        
        constant clock_period : time := 10 ns; -- 22.675 us
        constant bit_depth : integer := 8;
        constant sin5000x_samples : array1 := (0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-59,-28,6,39,69,95,114,124,127,120,105,83,54,22,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,125,116,98,74,44,11,-22,-54,-83,-105,-120,-127,-124,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,64,33,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-59,-28,6,39,69,95,114,124,127,120,105,83,54,22,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,125,116,98,74,44,11,-22,-54,-83,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,64,33,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-59,-28,6,39,69,95,113,124,127,120,105,83,54,22,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,125,116,98,74,44,11,-22,-54,-83,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,64,33,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,39,69,95,113,124,127,120,105,83,54,22,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,126,116,98,74,44,11,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,64,33,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,39,69,95,113,124,127,120,105,83,55,23,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,126,116,98,74,44,11,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,64,34,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,39,69,94,113,124,127,120,105,83,55,23,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,126,116,98,74,44,11,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,65,34,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-49,-17,17,49,78,102,118,126,126,116,98,74,44,11,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,65,34,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-74,-98,-116,-125,-126,-118,-102,-78,-50,-17,17,49,78,102,118,126,126,116,98,74,44,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,65,34,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-78,-50,-17,16,49,78,102,118,126,126,116,98,74,44,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,87,108,122,127,123,111,91,65,34,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,102,118,126,126,116,99,74,44,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,28,59,86,108,122,127,123,111,91,65,34,0,-33,-64,-91,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,102,118,126,126,116,99,74,44,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,27,59,86,108,122,127,123,111,91,65,34,0,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,44,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-69,-39,-6,27,59,86,108,122,127,123,111,91,65,34,0,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,44,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,0,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-44,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-28,5,38,69,94,113,124,127,120,105,83,55,23,-11,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-29,5,38,69,94,113,124,127,120,105,83,55,23,-11,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-17,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-29,5,38,69,94,113,124,127,120,105,83,55,23,-11,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-29,5,38,68,94,113,124,127,120,105,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-29,5,38,68,94,113,124,127,120,105,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,49,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-39,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-111,-123,-127,-122,-108,-87,-60,-29,5,38,68,94,113,124,127,120,105,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,48,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-40,-6,27,59,86,108,122,127,123,111,91,65,34,1,-33,-64,-90,-110,-123,-127,-122,-109,-87,-60,-29,5,38,68,94,113,124,127,120,105,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,48,78,101,118,126,126,116,99,74,45,12,-22,-54,-82,-105,-120,-127,-125,-114,-95,-70,-40,-6,27,59,86,108,122,127,123,111,91,65,34,1,-32,-64,-90,-110,-123,-127,-122,-109,-87,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,48,78,101,118,126,126,116,99,74,45,12,-21,-54,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,59,86,108,122,127,123,111,91,65,34,1,-32,-64,-90,-110,-123,-127,-122,-109,-87,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-54,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,59,86,108,122,127,123,111,91,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-87,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,59,86,108,121,127,123,111,91,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-116,-125,-126,-118,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,108,121,127,124,111,92,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-116,-125,-126,-119,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,111,92,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-115,-125,-126,-119,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,111,92,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,5,38,68,94,113,124,127,120,106,83,55,23,-10,-43,-73,-98,-115,-125,-126,-119,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,111,92,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,4,38,68,94,113,124,127,120,106,83,55,24,-10,-43,-73,-98,-115,-125,-126,-119,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,111,92,65,34,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,4,38,68,94,113,124,127,120,106,83,55,24,-10,-43,-73,-98,-115,-125,-126,-119,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,112,92,65,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-60,-29,4,38,68,94,113,124,127,120,106,84,55,24,-10,-43,-73,-97,-115,-125,-126,-119,-102,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,12,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,112,92,65,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,120,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-50,-18,16,48,77,101,118,126,126,116,99,75,45,13,-21,-53,-82,-104,-120,-127,-125,-114,-95,-70,-40,-7,27,58,86,107,121,127,124,112,92,65,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,120,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-50,-18,15,48,77,101,118,126,126,116,99,75,45,13,-21,-53,-82,-104,-120,-127,-125,-114,-96,-70,-40,-7,27,58,86,107,121,127,124,112,92,65,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-50,-18,15,48,77,101,118,126,126,116,99,75,45,13,-21,-53,-82,-104,-120,-127,-125,-114,-96,-70,-40,-7,27,58,86,107,121,127,124,112,92,65,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-51,-18,15,48,77,101,118,126,126,117,99,75,45,13,-21,-53,-82,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-51,-18,15,48,77,101,118,126,126,117,99,75,45,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-51,-18,15,48,77,101,118,126,126,117,99,75,45,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,1,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-73,-97,-115,-125,-126,-119,-103,-79,-51,-18,15,48,77,101,118,126,126,117,99,75,45,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-72,-97,-115,-125,-126,-119,-103,-79,-51,-18,15,48,77,101,118,126,126,117,99,75,45,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-43,-72,-97,-115,-125,-126,-119,-103,-79,-51,-18,15,48,77,101,118,126,126,117,99,75,46,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-18,15,48,77,101,118,126,126,117,99,75,46,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-29,4,37,68,94,113,124,127,121,106,84,56,24,-10,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-18,15,48,77,101,118,126,126,117,99,75,46,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-70,-40,-7,26,58,86,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-30,4,37,68,93,113,124,127,121,106,84,56,24,-10,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-18,15,48,77,101,117,126,126,117,99,75,46,13,-21,-53,-81,-104,-120,-127,-125,-114,-96,-71,-40,-7,26,58,86,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-30,4,37,68,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,48,77,101,117,126,126,117,99,75,46,13,-21,-53,-81,-104,-119,-127,-125,-114,-96,-71,-40,-7,26,58,85,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-30,4,37,68,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,48,77,101,117,126,126,117,99,75,46,13,-21,-53,-81,-104,-119,-127,-125,-114,-96,-71,-40,-7,26,58,85,107,121,127,124,112,92,66,35,2,-32,-63,-90,-110,-123,-127,-122,-109,-88,-61,-30,4,37,68,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,48,77,101,117,126,126,117,99,75,46,13,-21,-53,-81,-104,-119,-127,-125,-114,-96,-71,-40,-7,26,58,85,107,121,127,124,112,92,66,35,2,-32,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,68,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,48,77,101,117,126,126,117,99,75,46,13,-21,-53,-81,-104,-119,-127,-125,-114,-96,-71,-40,-7,26,58,85,107,121,127,124,112,92,66,35,2,-32,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,68,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,101,117,126,126,117,99,75,46,13,-20,-53,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,101,117,126,126,117,99,75,46,13,-20,-53,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,101,117,126,126,117,100,75,46,13,-20,-53,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,101,117,126,126,117,100,75,46,13,-20,-53,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,101,117,126,126,117,100,75,46,13,-20,-53,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-63,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,100,117,126,126,117,100,75,46,13,-20,-52,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,4,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,100,117,126,126,117,100,75,46,13,-20,-52,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,58,85,107,121,127,124,112,92,66,35,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,37,67,93,113,124,127,121,106,84,56,24,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,77,100,117,126,126,117,100,75,46,13,-20,-52,-81,-104,-119,-127,-125,-114,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,35,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,37,67,93,113,124,127,121,106,84,56,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,76,100,117,126,126,117,100,76,46,13,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,35,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,37,67,93,113,124,127,121,106,84,56,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,76,100,117,126,126,117,100,76,46,13,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,35,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,37,67,93,113,124,127,121,106,84,56,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,76,100,117,126,126,117,100,76,46,13,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,36,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,37,67,93,112,124,127,121,106,84,56,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,15,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,36,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,36,67,93,112,124,127,121,106,84,56,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,36,2,-31,-62,-89,-110,-123,-127,-122,-109,-88,-61,-30,3,36,67,93,112,124,127,121,106,84,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,26,57,85,107,121,127,124,112,92,66,36,2,-31,-62,-89,-110,-123,-127,-122,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,84,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-51,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,92,66,36,2,-31,-62,-89,-110,-123,-127,-122,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,84,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,66,36,2,-31,-62,-89,-110,-123,-127,-122,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,84,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,66,36,3,-31,-62,-89,-110,-123,-127,-122,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,84,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-122,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,85,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-122,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,85,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,46,14,-20,-52,-81,-104,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-123,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,85,57,25,-9,-42,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-81,-103,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-123,-109,-89,-62,-30,3,36,67,93,112,124,127,121,106,85,57,25,-9,-41,-72,-97,-115,-125,-126,-119,-103,-80,-52,-19,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-81,-103,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-123,-109,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-9,-41,-71,-97,-115,-125,-126,-119,-103,-80,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-80,-103,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-123,-109,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-97,-115,-125,-126,-119,-103,-80,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-80,-103,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-103,-80,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-80,-103,-119,-127,-125,-115,-96,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-110,-123,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-103,-80,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-80,-103,-119,-126,-125,-115,-97,-71,-41,-8,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-109,-123,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-103,-80,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-20,-52,-80,-103,-119,-126,-125,-115,-97,-72,-41,-9,25,57,85,107,121,127,124,112,93,67,36,3,-31,-62,-89,-109,-123,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-103,-81,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,85,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-123,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-103,-81,-52,-20,14,47,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,85,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-123,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,85,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-122,-127,-123,-110,-89,-62,-31,3,36,67,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,85,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-122,-127,-123,-110,-89,-62,-31,3,36,66,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,84,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-122,-127,-123,-110,-89,-62,-31,3,36,66,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,84,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-122,-127,-123,-110,-89,-62,-31,2,36,66,93,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-52,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,84,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-122,-127,-123,-110,-89,-62,-31,2,36,66,92,112,124,127,121,107,85,57,25,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-51,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,84,106,121,127,124,112,93,67,36,3,-30,-62,-89,-109,-122,-127,-123,-110,-89,-62,-31,2,36,66,92,112,124,127,121,107,85,57,26,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-51,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,57,84,106,121,127,124,112,93,67,36,3,-30,-61,-88,-109,-122,-127,-123,-110,-89,-62,-31,2,36,66,92,112,124,127,121,107,85,57,26,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,14,-19,-51,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,56,84,106,121,127,124,112,93,67,36,3,-30,-61,-88,-109,-122,-127,-123,-110,-89,-62,-31,2,36,66,92,112,124,127,121,107,85,57,26,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,14,46,76,100,117,126,126,117,100,76,47,15,-19,-51,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,56,84,106,121,127,124,112,93,67,37,3,-30,-61,-88,-109,-122,-127,-123,-110,-89,-62,-31,2,36,66,92,112,124,127,121,107,85,57,26,-8,-41,-71,-96,-115,-125,-127,-119,-104,-81,-52,-20,13,46,76,100,117,126,126,117,100,76,47,15,-19,-51,-80,-103,-119,-126,-125,-115,-97,-72,-42,-9,25,56,84,106,121,127,124,113,93,67,37,3,-30,-61,-88,-109,-122,-127,-123,-110,-89,-62,-31,2,35,66,92,112,124,127,121,107,85,57,26,-8,-41,-71,-96,-115,-125,-127,-119,-104);
        constant sinx_samples : array2 := (0,1,3,4,5,6,8,9,10,11,13,14,15,16,18,19,20,21,23,24,25,26,28,29,30,31,33,34,35,36,38,39,40,41,42,44,45,46,47,48,49,51,52,53,54,55,56,58,59,60,61,62,63,64,65,66,67,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,87,88,89,90,91,92,93,94,95,95,96,97,98,99,99,100,101,102,103,103,104,105,105,106,107,108,108,109,110,110,111,111,112,113,113,114,114,115,115,116,116,117,117,118,118,119,119,120,120,121,121,121,122,122,122,123,123,123,124,124,124,124,125,125,125,125,126,126,126,126,126,126,126,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,127,126,126,126,126,126,126,126,125,125,125,125,124,124,124,124,123,123,123,122,122,122,121,121,121,120,120,119,119,118,118,118,117,117,116,115,115,114,114,113,113,112,112,111,110,110,109,108,108,107,106,106,105,104,103,103,102,101,100,100,99,98,97,96,96,95,94,93,92,91,90,89,89,88,87,86,85,84,83,82,81,80,79,78,77,76,75,74,73,72,71,70,69,68,67,65,64,63,62,61,60,59,58,57,55,54,53,52,51,50,48,47,46,45,44,43,41,40,39,38,37,35,34,33,32,30,29,28,27,25,24,23,22,20,19,18,17,15,14,13,12,10,9,8,7,5,4,3,1,0,-1,-2,-4,-5,-6,-7,-9,-10,-11,-12,-14,-15,-16,-18,-19,-20,-21,-23,-24,-25,-26,-28,-29,-30,-31,-32,-34,-35,-36,-37,-39,-40,-41,-42,-43,-45,-46,-47,-48,-49,-50,-52,-53,-54,-55,-56,-57,-58,-60,-61,-62,-63,-64,-65,-66,-67,-68,-69,-70,-72,-73,-74,-75,-76,-77,-78,-79,-80,-81,-82,-83,-84,-85,-85,-86,-87,-88,-89,-90,-91,-92,-93,-94,-94,-95,-96,-97,-98,-99,-99,-100,-101,-102,-102,-103,-104,-105,-105,-106,-107,-107,-108,-109,-109,-110,-111,-111,-112,-113,-113,-114,-114,-115,-115,-116,-116,-117,-117,-118,-118,-119,-119,-120,-120,-120,-121,-121,-122,-122,-122,-123,-123,-123,-124,-124,-124,-124,-125,-125,-125,-125,-126,-126,-126,-126,-126,-126,-126,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-127,-126,-126,-126,-126,-126,-126,-125,-125,-125,-125,-125,-124,-124,-124,-123,-123,-123,-122,-122,-122,-121,-121,-121,-120,-120,-119,-119,-119,-118,-118,-117,-117,-116,-116,-115,-114,-114,-113,-113,-112,-112,-111,-110,-110,-109,-108,-108,-107,-106,-106,-105,-104,-104,-103,-102,-101,-101,-100,-99,-98,-97,-97,-96,-95,-94,-93,-92,-91,-90,-90,-89,-88,-87,-86,-85,-84,-83,-82,-81,-80,-79,-78,-77,-76,-75,-74,-73,-72,-71,-70,-69,-68,-67,-66,-65,-63,-62,-61,-60,-59,-58,-57,-56,-54,-53,-52,-51,-50,-49,-47,-46,-45,-44,-43,-42,-40,-39,-38,-37,-35,-34,-33,-32,-31,-29,-28,-27,-26,-24,-23,-22,-21,-19,-18,-17,-16,-14,-13,-12,-11,-9,-8,-7,-5,-4,-3,-2,0);
        
        file sample_fileL : text;
        file sample_fileR : text;
        
        begin
            uut : entity work.fir_lpf(rtl)
            generic map (
                bit_depth => 8,                                 --Variable bit depth (8,16,24,32)
                sample_freq => 44100                            --Variable sampling frequency (44.1k,48k,96k,192k)
            )
            port map (
                filter_clk => filter_clk_s,
                filter_rst => filter_rst_s,
                input_dataL => input_dataL_s,
                input_dataR => input_dataR_s,
                coeff1 => coeff1_s,
                coeff2 => coeff2_s,
                coeff3 => coeff3_s,
                coeff4 => coeff4_s,
                coeff5 => coeff5_s,
                coeff6 => coeff6_s,
                coeff7 => coeff7_s,
                coeff8 => coeff8_s,
                coeff9 => coeff9_s,
                coeff10 => coeff10_s,
                coeff11 => coeff11_s,
                coeff12 => coeff12_s,
                coeff13 => coeff13_s,
                coeff14 => coeff14_s,
                coeff15 => coeff15_s
            );
        
--        process
--        begin   
--            if (bit_depth = 8) then
--                file_open(sample_file,"sin_wave8bit.txt",read_mode);
--            wait for 1 ns;
--            elsif (bit_depth = 16) then
--                file_open(sample_file,"sin_wave16bit.txt",read_mode);
--            wait for 1 ns;
--            elsif (bit_depth = 32) then
--                file_open(sample_file,"sin_wave32bit.txt",read_mode);
--            wait for 1 ns;
--            else
--                file_open(sample_file,"sin_wave8bit.txt",read_mode);
--            end if;
--        end process;
            
        clock_process : process
        begin
            filter_clk_s <= '0';
            wait for clock_period/2;
            filter_clk_s <= '1';
            wait for clock_period/2;
        end process;
        
        stim_process : process
--        variable line_in_Lwave : line;
--        variable line_in_Rwave : line;
--        variable conv_stdlogL  : std_logic_vector(7 downto 0);
--        variable conv_stdlogR  : std_logic_vector(7 downto 0);
--        variable new_linechar  : character;
        begin
--            if (bit_depth = 8) then
--                file_open(sample_file,"sin_wave8bit.txt",read_mode);
--            elsif (bit_depth = 16) then
--                file_open(sample_file,"sin_wave16bit.txt",read_mode);
--            elsif (bit_depth = 32) then
--                file_open(sample_file,"sin_wave32bit.txt",read_mode);
--            else
--                file_open(sample_file,"sin_wave8bit.txt",read_mode);
--            end if;
            --file_open(sample_fileL,"C:\Users\Josep\OneDrive\Documents\MATLAB\sin_waveL.txt",read_mode);
            --file_open(sample_fileR,"C:\Users\Josep\OneDrive\Documents\MATLAB\sin_waveR.txt",read_mode);
            filter_rst_s <= '1';
            wait for clock_period/100;
            filter_rst_s <= '0';
            wait for clock_period/100;
            coeff1_s <= "1000110000101000"; --signed binary -3112
            coeff2_s <= "1000010011111011"; --signed binary -1275
            coeff3_s <= "0000011001011001"; --signed binary 1625
            coeff4_s <= "1000100010001000"; --signed binary -2184
            coeff5_s <= "0000101011111001"; --signed binary 2809
            coeff6_s <= "1000110100101001"; -- signed binary -3369
            coeff7_s <= "0000111010101010"; -- signed binary 3754
            coeff8_s <= "0111000010110111"; -- signed binary 28885;
            coeff9_s <= "0000111010101010"; -- signed binary 3754
            coeff10_s <= "1000110100101001"; -- signed binary -3369
            coeff11_s <= "0000101011111001"; --signed binary 2809
            coeff12_s <= "1000100010001000"; --signed binary -2184
            coeff13_s <= "0000011001011001"; --signed binary 1625
            coeff14_s <= "1000010011111011"; --signed binary -1275
            coeff15_s <= "1000110000101000"; --signed binary -3112
            wait for clock_period;
            --SIGNAL TEST, pass samples from matlab file
            for i in 0 to 629 loop --or 6281
                input_dataL_s <= std_logic_vector(to_signed(sinx_samples(i),8));
                input_dataR_s <= std_logic_vector(to_signed(sinx_samples(i),8));
                wait for clock_period;
            end loop;
            --INITIAL TEST, pass in 8bit numbers to verify operation of the filter
--            input_dataL_s <= "10011010";
--            input_dataR_s <= "00110111";
--            wait for clock_period;
--            input_dataL_s <= "00000000";
--            input_dataR_s <= "10110110";
--            wait for clock_period;
--            input_dataL_s <= "00000001";
--            input_dataR_s <= "11011000";
--            wait for clock_period;
--            input_dataL_s <= "00000000";
--            input_dataR_s <= "11011111";
            wait;
        end process;
end Behavioral;