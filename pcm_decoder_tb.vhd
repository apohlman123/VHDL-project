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
    signal clk_i_s     : std_logic;
    signal decoder_d_i_s : std_logic;
    signal rst_i_async_s : std_logic;
    signal decoder_q_o_s : std_logic_vector(7 downto 0);
    
    constant clock_period : time := 10 ns;
    
    begin
        uut: entity work.pcm_decoder(behav)
        generic map(
            bit_depth => 8
        )
        port map(
            clk_i => clk_i_s,
            decoder_d_i => decoder_d_i_s,
            decoder_q_o => decoder_q_o_s,
            rst_i_async => rst_i_async_s
        );
        
        clock_process : process
        begin
            clk_i_s <= '0';
            wait for clock_period/2;
            clk_i_s <= '1';
            wait for clock_period/2;
        end process;
        
        stim_process : process
        begin
            rst_i_async_s <= '1';
            decoder_d_i_s <= '0';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '0';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '1';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '0';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '1';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '1';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '1';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '0';
            wait for 10 ns;
            rst_i_async_s <= '0';
            decoder_d_i_s <= '0';
            wait;
        end process;
end test;
