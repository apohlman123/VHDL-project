------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Joseph Gorman

--Create Date:  04/7/2019
--Design Name:  pcm_encoder_tb.vhd
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
entity pcm_encoder_tb is
end entity;

architecture test of pcm_encoder_tb is
    signal b_clk_i_s     : std_logic;
    signal encoder_d_i_s : std_logic_vector(7 downto 0);
    signal mux_select_s  : std_logic;
    signal rst_i_async_s : std_logic;
    
    constant clock_period : time := 100 ms;
    
    begin
        uut: entity work.pcm_encoder(behav)
        generic map(
            bit_depth => 8
        )
        port map(
            b_clk_i => b_clk_i_s,
            encoder_d_i => encoder_d_i_s,
            mux_select => mux_select_s,
            rst_i_async => rst_i_async_s
        );
        
        clock_process : process
        begin
            b_clk_i_s <= '0';
            wait for clock_period/2;
            b_clk_i_s <= '1';
            wait for clock_period/2;
        end process;
        
        stim_process : process
        begin
            rst_i_async_s <= '1';
            mux_select_s <= '0';
            encoder_d_i_s <= "00000000";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait for 100 ms;
            rst_i_async_s <= '0';
            mux_select_s <= '1';
            encoder_d_i_s <= "00010101";
            wait;
        end process;
end test;
