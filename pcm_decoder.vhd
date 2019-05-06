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
    --E (04/22/19) : implemented LRCLK
    --E (04/29/19) : progress on outputting shifted data to port output
    --F (05/04/19) : decoder output properly outputting shifted data
    --G (05/05/19) : found that decoder output was incorrectly timed this is
                  -- now fixed, clock enables implemented and working with testbench
------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY pcm_decoder IS
  GENERIC (
        bit_depth   : integer := 8;                                                 --Variable bit depth (8,16,24,32)
        sample_freq : integer := 44100;                                             --Variable sampling frequency (44.1k,48k,96k,192k)
        MCLK_freq   : integer := 28224000
  );

  PORT (
	rst_i_async		   : IN   std_logic;                                            -- Asynchronous reset for all DFFs
	decoder_d_i		   : IN   std_logic;                                            -- Decoder serial data input
	MCLK_i             : IN   std_logic;                                            -- Master clock input
	L_decoder_q_o      : OUT  std_logic_vector(bit_depth-1 DOWNTO 0);               -- Parallel left data output 
	R_decoder_q_o      : OUT  std_logic_vector(bit_depth-1 DOWNTO 0)                -- Parallel right data output 
  );

END pcm_decoder;

ARCHITECTURE behav OF pcm_decoder IS
    signal   decoder_d_sig         : std_logic_vector(0 TO bit_depth-1  );                    -- Internal DFF data signals  
    signal   decoder_q_sig         : std_logic_vector(0 TO bit_depth-1  );                    -- Internal extra DFF output signals      
	signal   decoder_q_o           : std_logic_vector(bit_depth-1 DOWNTO 0);                  -- Decoder parallel data output
	signal   edge_LRCK_sig         : std_logic;                                               -- Left / Right edge trigger 
	signal   dff_q_LREdge          : std_logic;                                               -- Frame clock rises on falling edge of Left / Right edge trigger 
    constant gnd_sig               : std_logic_vector(bit_depth-1 DOWNTO 0)  := "00000000";   -- Ground signal used for reset

    constant BCK_freq              : integer := sample_freq*bit_depth*2;
    constant BCK_count             : integer := MCLK_freq/(2*BCK_freq);             -- For bit depth 8, fs 44.1kHz, this is 20
    signal   clk_counter           : integer range 0 to MCLK_freq/(2*sample_freq);  -- For bit depth 8, fs 44.1kHz, this is 640
    signal   clk_diff              : integer range 0 to MCLK_freq/(2*sample_freq);  -- Keep track of difference between edges
    signal   BCK_i                 : std_logic;                                     -- Bit Clock internal signal
    signal   LRCK_i                : std_logic;                                     -- Frame Clock input internal signal
	
BEGIN

------------------------------------------------------------------------------
--  sync_clk_en derives the bit clock and frame clock from the master clock
------------------------------------------------------------------------------ 
    sync_clk_en : PROCESS(rst_i_async, MCLK_i)
    BEGIN
        IF rst_i_async = '1' THEN
            clk_counter <= 0;
            clk_diff <= 0;
            LRCK_i <= '0';
            BCK_i <= '0';
        ELSIF rising_edge(MCLK_i) THEN
            IF clk_counter = MCLK_freq/(2*sample_freq) THEN
                clk_diff <= 0;
                clk_counter <= 1;
                BCK_i <= NOT(BCK_i);
                LRCK_i <= NOT(LRCK_i);
            ELSIF clk_counter - clk_diff = BCK_count THEN
                clk_diff <= clk_counter;
                BCK_i <= NOT(BCK_i);
                clk_counter <= clk_counter + 1;
            ELSE
                clk_counter <= clk_counter + 1;
            END IF;
        END IF;
    END PROCESS sync_clk_en;
	
    L_decoder_q_o <= decoder_q_o WHEN dff_q_LREdge = '0';                                 -- Assign fully shifted bit stream to left decoder output
    R_decoder_q_o <= decoder_q_o WHEN dff_q_LREdge = '1';-- ELSE gnd_sig;                 -- Assign fully shifted bit stream to right decoder output
    
    edge_LRCK_sig <= (NOT(dff_q_LREdge) AND LRCK_i) OR (dff_q_LREdge AND NOT(LRCK_i));    -- Combinational logic to implement Left / Right edge trigger 



------------------------------------------------------------------------------
--  clk_edge_process derives the frame clock from the Left / Right edge trigger 
------------------------------------------------------------------------------ 
    clk_edge_process : PROCESS(rst_i_async, BCK_i)
    BEGIN
        IF rst_i_async = '1' THEN
            dff_q_LREdge <=  '0';
        ELSIF rising_edge(BCK_i) THEN
            dff_q_LREdge <= LRCK_i;
        END IF;
    END PROCESS clk_edge_process;	

------------------------------------------------------------------------------
--  deocder_process is responsible for shifting all of the data stored
--  in the DFFs and preparing the output data to be sent to either the
--  left or right output
------------------------------------------------------------------------------ 
	decoder_process: PROCESS(BCK_i,rst_i_async)
	BEGIN
		IF rst_i_async = '1' THEN
		    decoder_d_sig       <= gnd_sig;                                          -- Ground all internal DFFs    
		    decoder_q_sig       <= gnd_sig;                                          -- Ground all internal DFFs                                    
			decoder_q_o         <= gnd_sig;                                          -- Ground all internal DFFs    		
		ELSIF rising_edge(BCK_i) THEN                                                -- Infer DFFs and assign internal signals to ports	
				decoder_d_sig(bit_depth - 1) <= decoder_d_i;                         -- Load input bit of data into first DFF
				FOR i IN (bit_depth - 1) DOWNTO 1 LOOP                               -- Assign all DFF q outputs to following DFF d inputs
					 decoder_d_sig(i-1) <= decoder_d_sig(i);                         -- Shift all DFFs exluding first
				END LOOP;
				decoder_q_sig <= decoder_d_sig;										
        END IF;
        IF edge_LRCK_sig = '1' THEN                                          -- Data input should occur at the start of each N-bit 
             decoder_q_o <= decoder_q_sig;                                   -- Assign serially shifted frame in parallel to decoder output
        END IF;	  	        
	END PROCESS decoder_process;

END behav;
