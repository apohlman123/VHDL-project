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
    signal b_clk_i_s       : std_logic;
    signal L_encoder_d_i_s : std_logic_vector(7 downto 0);
    signal R_encoder_d_i_s : std_logic_vector(7 downto 0);
    signal LRCK_i_s        : std_logic;
    signal rst_i_async_s   : std_logic;
    signal encoder_q_o_s   : std_logic;
    
    constant clock_period : time := 35 ns;
    constant frame_clock_period : time := 560 ns; -- 35* 16 = 560 
    
    begin
        uut: entity work.pcm_encoder(behav)
        generic map(
            bit_depth => 8
        )
        port map(
            b_clk_i       => b_clk_i_s,
            L_encoder_d_i => L_encoder_d_i_s,
            R_encoder_d_i => R_encoder_d_i_s,
            LRCK_i        => LRCK_i_s,
            rst_i_async   => rst_i_async_s,
            encoder_q_o   => encoder_q_o_s
        );
        
        bit_clock_process : process
        begin
            b_clk_i_s <= '0';
            wait for clock_period/2;
            b_clk_i_s <= '1';
            wait for clock_period/2;
        end process;
        
        frame_clock_process : process
        begin
            LRCK_i_s <= '0';
            wait for frame_clock_period/2;
            LRCK_i_s <= '1';
            wait for frame_clock_period/2;
        end process;
        
        stim_process : process
        begin
              L_encoder_d_i_s <= "11001101";
              R_encoder_d_i_s <= "01110100";
              rst_i_async_s <= '1';
              wait for 50 ns;
              rst_i_async_s <= '0';
              wait;

              
              
              
--            rst_i_async_s <= '1';
--            mux_select_s <= '1';
--            encoder_d_i_s <= "00011100";
--            wait for 15 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '1';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "00011100";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '1';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
--            rst_i_async_s <= '0';
--            mux_select_s <= '0';
--            encoder_d_i_s <= "01110111";
--            wait for 10 ns;
        end process;
end test;
