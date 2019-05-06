------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Joseph Gorman

--Create Date:  04/7/2019
--Design Name:  pcm_decoder_tb.vhd
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
entity pcm_decoder_tb is
end entity;

architecture test of pcm_decoder_tb is
    constant bit_depth       : integer := 8;
    constant clk_multiple    : integer := 40;
    signal   MCLK_i_s        : std_logic;
    signal   decoder_d_i_s   : std_logic;
    signal   rst_i_async_s   : std_logic;
    signal   L_decoder_q_o_s : std_logic_vector(bit_depth-1 downto 0);
	signal   R_decoder_q_o_s : std_logic_vector(bit_depth-1  downto 0);
	
	constant clock_period : time := 1 ns;
	
    begin
        uut: entity work.pcm_decoder(behav)
        generic map(
             bit_depth      => 8,                                                  --Variable bit depth (8,16,24,32)
             sample_freq    => 192000,                                             --Variable sampling frequency (44.1k,48k,96k,192k)
             MCLK_freq      => 28224000
        )
        port map(
            MCLK_i => MCLK_i_s,
            decoder_d_i   => decoder_d_i_s,
            rst_i_async   => rst_i_async_s,
			L_decoder_q_o => L_decoder_q_o_s,
			R_decoder_q_o => R_decoder_q_o_s
        );
        
        bit_clock_process : process
        begin
            MCLK_i_s <= '0';
            wait for clock_period/2;
            MCLK_i_s <= '1';
            wait for clock_period/2;
        end process;
                
        stim_process : process
        begin
        
-- 40 used for 8-bit stream, should have implemented with a constant
-- replacing 40(s) with 20(s) works with 16-bit data
       
        decoder_d_i_s <= '0';
        rst_i_async_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        --wait for clock_period/2;
        --rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for ((clk_multiple/2)*clock_period+0.5*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '1';
        wait for (clk_multiple*clock_period);
        rst_i_async_s <= '0';
        decoder_d_i_s <= '0';
        wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '1';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '0';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '1';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '0';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '1';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '0';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '1';
         wait for (clk_multiple*clock_period);
         rst_i_async_s <= '0';
         decoder_d_i_s <= '0';
         wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '1';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '0';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '1';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '0';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '1';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '0';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '1';
          wait for (clk_multiple*clock_period);
          rst_i_async_s <= '0';
          decoder_d_i_s <= '0';
          wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '1';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '0';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '1';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '0';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '1';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '0';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '1';
           wait for (clk_multiple*clock_period);
           rst_i_async_s <= '0';
           decoder_d_i_s <= '0';
        wait;
        
        end process;
end test;
