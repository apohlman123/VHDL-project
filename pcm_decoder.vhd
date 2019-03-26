------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Clay Sauter

--Create Date:  03/25/2019
--Design Name:
--Module Name: 
--Project Name: PCM Communication System
--Tool Versions:
--Description:

--Dependencies:

--Revisions:

------------------------------------------------------------------------------

Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;

ENTITY pcm_encoder IS

  GENERIC (
	bit_depth : integer := 8
  );

  PORT (
	rst_i_async		   : IN   std_logic;
	decoder_d_i		   : IN   std_logic;
	clk_i      		   : IN   std_logic;
	clr_i      		   : IN   std_logic;
    decoder_q_o        : OUT  std_logic_vector( (bit_depth - 1) DOWNTO 0)
  );

END pcm_encoder;

ARCHITECTURE behav OF pcm_encoder IS

    signal D_sig    : std_logic_vector( (bit_depth - 1) DOWNTO 0);
	signal Q_sig    : std_logic_vector( (bit_depth - 1) DOWNTO 0);
	

BEGIN
	dffs : PROCESS(clk_i,clr_i)
	
	BEGIN
	
	IF clr_i = '1' THEN
	
	ELSIF	rising_edge(clk_i) THEN
	    
        decoder_d_i    <= D_sig( (bit_depth - 1) )  
		FOR i IN (bit_depth - 1) DOWNTO 1 LOOP
		    D_sig(i-1) <= Q_sig(i);
		END LOOP;
		Q_sig(0)       <= decoder_q_o(0);
		decoder_q_o    <= Q_sig
		
		
    
	END IF;
	
	END PROCESS dffs;

END pcm_encoder


