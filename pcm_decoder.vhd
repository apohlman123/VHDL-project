------------------------------------------------------------------------------

--Company:      Loyola Marymount University

--Engineer:     Clay Sauter



--Create Date:  03/25/2019

--Design Name:

--Module Name: 

--Project Name: PCM Communication System

--Tool Versions:

--Description:

    --Decoder stage, serial-to-parallel converter

	

--Dependencies:



--Revisions:

    --A (03/25/19) : began .vhd file, wrote intoductory decoder process

    --B (04/01/19) : finished first revision of decoder process

	--C (04/07/19) : implemented into testbench, fixed errors that arose on testbench's end
	
	--D (04/15/19) : added output buffers to decoder output, still need to implement LRCLK

------------------------------------------------------------------------------



LIBRARY IEEE;

USE IEEE.STD_LOGIC_1164.ALL;



ENTITY pcm_decoder IS



  GENERIC (

	bit_depth : integer := 8                                              --Variable bit depth

  );



  PORT (

	rst_i_async		   : IN   std_logic;                                  -- Asynchronous reset for all DFFs

	decoder_d_i		   : IN   std_logic;                                  -- Decoder serial data input

	clk_i      		   : IN   std_logic;                                  -- Input clock

    decoder_q_o        : OUT  std_logic_vector(bit_depth-1 DOWNTO 0)      -- Decoder parallel data output

  );

END pcm_decoder;

ARCHITECTURE behav OF pcm_decoder IS

    signal   d_sig    : std_logic_vector(bit_depth-1  DOWNTO 0);          -- Internal DFF data signals        

	signal   q_sig    : std_logic_vector(bit_depth-1  DOWNTO 0);          -- Internal DFF q signals

	constant gnd_sig  : std_logic_vector(7 downto 0)  := "00000000";          -- Ground signal used for reset

BEGIN

	decoder_process: PROCESS(clk_i,rst_i_async)

	BEGIN

		IF rst_i_async = '1' THEN
		
		    d_sig      <= gnd_sig;                                      -- Ground all DFF outputs                                       -- Ground all decoder outputs

		ELSIF rising_edge(clk_i) THEN                                     -- Infer DFFs and assign internal signals to ports
			
		    d_sig(bit_depth - 1) <= decoder_d_i;

			FOR i IN (bit_depth - 1) DOWNTO 1 LOOP                        -- Assign all DFF q outputs to following DFF d inputs

			     d_sig(i-1) <= d_sig(i);

			END LOOP;
			
			q_sig <= d_sig;
			
		END IF;

	    decoder_q_o <= q_sig;

	END PROCESS decoder_process;

END behav;
