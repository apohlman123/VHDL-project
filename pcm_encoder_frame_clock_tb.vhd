------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Austin Pohlman

--Create Date:  04/07/2019
--Design Name:  pcm_encoder_tb.vhd
--Module Name:
--Project Name: PCM Communication System
--Tool Versions:

--Description:
    --Test bench for pcm_encoder stage

--Dependencies:
    --pcm_encoder.vhd
--Revisions:
    --A (04/07/2019) : created file, instantiated pcm_encoder(behav)
    --See github for full revision history
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
    constant bit_depth_tb  : integer := 8; --Needed for variable input data vectors
    signal L_encoder_d_i_s : std_logic_vector(bit_depth_tb-1 downto 0);
    signal R_encoder_d_i_s : std_logic_vector(bit_depth_tb-1 downto 0);
    signal rst_i_async_s   : std_logic;
    signal MCLK_i_s        : std_logic;
    signal encoder_q_o_s   : std_logic;

    constant clock_period : time := 1 ns; --shortened from 35ns for simulation

    begin
        uut: entity work.pcm_encoder(behav) --Change these generics to use variable bitdepth/samplefreq
        generic map(
            bit_depth => 8,
            sample_freq => 44100,
            MCLK_freq => 28224000 --24576000 used for 48k, 96k, 192k sampling rates
        )
        port map(
            L_encoder_d_i => L_encoder_d_i_s,
            R_encoder_d_i => R_encoder_d_i_s,
            rst_i_async   => rst_i_async_s,
            MCLK_i        => MCLK_i_s,
            encoder_q_o   => encoder_q_o_s
        );

        bit_clock_process : process --Create MCLK_i
        begin
            MCLK_i_s <= '0';
            wait for clock_period/2;
            MCLK_i_s <= '1';
            wait for clock_period/2;
        end process;

        stim_process : process
        begin
              L_encoder_d_i_s <= "11001101"; --"1100110101100110" for 16-bit
              R_encoder_d_i_s <= "01110100"; --"0111010011110101"
              rst_i_async_s <= '1';
              wait for 50 ns; --This is arbitrary
              rst_i_async_s <= '0';
              wait for 950 ns; --950ns to 2000ns depending on bit depth and sample freq
              L_encoder_d_i_s <= "11110000"; --"1111000011110000"
              R_encoder_d_i_s <= "10101010"; --"1010101010101010"
              wait for 1000 ns;
              rst_i_async_s <= '1';
              wait;
        end process;
end test;
