------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Austin Pohlman

--Create Date:  03/25/2019
--Design Name:
--Module Name:
--Project Name: PCM Encoding/Decoding
--Tool Versions:
--Description:
    --Encoder stage, parallel-to-serial converter

--Dependencies:


--Revisions:
    --A : created file, wrote encoder_process
    --B : reversed operation to Big Endian (MSB first)
------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY pcm_encoder IS
    GENERIC (
        bit_depth : integer := 8;                                 --Variable bit depth (8,16,24,32)
        sample_freq : integer := 44100                           --Variable sampling frequency (44.1k,48k,96k,192k)
    );

    PORT (
        b_clk_i     : IN std_logic;                              --Bit Clock input to shift data
        left_encoder_d_i : IN std_logic_vector(bit_depth-1 downto 0); --Parallel data input
        right_encoder_d_i : IN std_logic_vector(bit_depth-1 downto 0);
        LRCK_i      : IN std_logic;                              --Frame clock input
        rst_i_async : IN std_logic;                              --Asynchronous reset for ALL DFFs
        encoder_q_o : OUT std_logic                              --Serial data output
    );
END pcm_encoder;

ARCHITECTURE behav OF pcm_encoder IS
    signal   q_sig   : std_logic_vector(bit_depth-1 downto 1);   --Internal DFF outputs
    constant gnd_sig : std_logic_vector(bit_depth-1 downto 1) := "0000000";  --Used for GND in reset
BEGIN
    encoder_process : PROCESS(rst_i_async, b_clk_i)
    BEGIN
        IF rst_i_async = '1' THEN
            q_sig <= gnd_sig;
            encoder_q_o <= '0';
        ELSIF rising_edge(b_clk_i) THEN                          --Infer DFFs and Muxes
            IF falling_edge(LRCK_i) THEN
                FOR i in bit_depth-1 downto 1 LOOP
                    q_sig(i) <= left_encoder_d_i(bit_depth-1-i);      --Assign DFF outputs w/ parallel data LSB->MSB
                END LOOP;
                encoder_q_o <= left_encoder_d_i(bit_depth-1);         --Assign encoder output w/ MSB of parallel data
            ELSIF rising_edge(LRCK_i) THEN                      --Data input should occur at the start of each N-bit frame
                                                                 --mux is tied to LRCK to shift parallel data in
                FOR i in bit_depth-1 downto 1 LOOP
                    q_sig(i) <= right_encoder_d_i(bit_depth-1-i);      --Assign DFF outputs w/ parallel data LSB->MSB
                END LOOP;
                encoder_q_o <= right_encoder_d_i(bit_depth-1);         --Assign encoder output w/ MSB of parallel data
            ELSE                                                --Conditional to shift serial data out
                FOR i in bit_depth-2 downto 1 LOOP
                    q_sig(i) <= q_sig(i+1);                      --Connect inferred DFFs LSB-to-MSB
                END LOOP;
                q_sig(bit_depth-1) <= '1';                       --LSB DFF gets a '1' input
                encoder_q_o <= q_sig(1);                         --Assign encoder output w/ LSB DFF output
                                                                 --Note that DATA is MSB first
                                                                 --Also, first serial data bit is valid as soon as mux_select is
                                                                 --asserted, not after it goes low since encoder_q_o gets encoder_d_i(bit_depth-1)
            END IF;
        END IF;
    END process encoder_process;
END behav;
