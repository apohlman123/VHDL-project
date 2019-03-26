------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Joseph Gorman

--Create Date:  03/24/2019
--Design Name:
--Module Name:
--Project Name: PCM Communication System
--Tool Versions:
--Description:

--Dependencies:

--Revisions:
------------------------------------------------------------------------------
------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Joseph Gorman

--Create Date:  03/24/2019
--Design Name:
--Module Name:
--Project Name: PCM Communication System
--Tool Versions:

--Description:


--Dependencies:
--Revisions:
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;

library std;
use std.textio.all;

--entity
entity pcm_testbench is
end entity;

--architecture
architecture test of pcm_testbench is

file sinwave_data_file : text;
file sinwave_phas_shift_data_file : text;
file sinwave_noisy_data_file : text;

begin

process
    variable line_in_sinwave : line;
    begin
        file_open(sinwave_data_file,"C:\Users\Josep\OneDrive\Documents\MATLAB\sin_wave.txt",read_mode);
        file_open(sinwave_phas_shift_data_file,"C:\Users\Josep\OneDrive\Documents\MATLAB\sin_phase_shift.txt",read_mode);
        file_open(sinwave_noisy_data_file,"C:\Users\Josep\OneDrive\Documents\MATLAB\sin_wave_noisy.txt",read_mode);
    
        while not endfile(sinwave_data_file) loop
            readline(sinwave_data_file, line_in_sinwave);
        end loop;
    
        while not endfile(sinwave_phas_shift_data_file) loop
            readline(sinwave_data_file, line_in_sinwave);
        end loop;
    
        while not endfile(sinwave_noisy_data_file) loop
            readline(sinwave_data_file, line_in_sinwave);
        end loop;
    
        file_close(sinwave_data_file);
        file_close(sinwave_phas_shift_data_file);
        file_close(sinwave_noisy_data_file);
    end process;
end test;
--assertions will be made to verify transmitted & received data
