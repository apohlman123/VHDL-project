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
------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY pcm_encoder IS
    GENERIC (
        bit_depth : integer := 8                                 --Variable bit depth
    );

    PORT (
        b_clk_i     : IN std_logic;                              --Bit Clock input to shift data
        encoder_d_i : IN std_logic_vector(bit_depth-1 downto 0); --Parallel data input
        mux_select  : IN std_logic;                              --Select for inferred muxes
        rst_i_async : IN std_logic;                              --Asynchronous reset for ALL DFFs
        encoder_q_o : OUT std_logic                              --Serial data output
    );
END pcm_encoder;

ARCHITECTURE behav OF pcm_encoder IS
    signal   q_sig   : std_logic_vector(bit_depth-1 downto 1);   --Internal DFF outputs
    constant gnd_sig : std_logic_vector(bit_depth-1 downto 0);   --Used for GND in reset
BEGIN
    encoder_process : PROCESS(rst_i_async, b_clk_i)
    BEGIN
        IF rst_i_async = '1' THEN
            q_sig <= gnd_sig;
            encoder_q_o <= '0';
        ELSIF rising_edge(b_clk_i) THEN                          --Infer DFFs and Muxes
            IF mux_select = '1' THEN                             --Data input should occur at the start of each N-bit frame
                                                                 --Need to add Frame Clock to determine when data is transferred in
                                                                 --Change to IF rising_edge(mux_select) ... or make MUX the frame clk
                FOR i in bit_depth-1 downto 1 LOOP
                    q_sig(i) <= encoder_d_i(i);                  --Assign DFF outputs w/ parallel data
                END LOOP;
                encoder_q_o <= encoder_d_i(0);                   --Assign encoder output w/ LSB of parallel data
            ELSIF                                                --Conditional to shift serial data out
                FOR i in bit_depth-2 downto 1 LOOP
                    q_sig(i) <= q_sig(i+1);                      --Connect inferred DFFs MSB-to-LSB
                END LOOP;
                q_sig(bit_depth-1) <= '1';                       --MSB DFF gets a '1' input
                encoder_q_o <= q_sig(1);                         --Assign encoder output w/ LSB DFF output
                                                                 --Note that DATA is LSB first
                                                                 --Also, first serial data bit is valid as soon as mux_select is
                                                                 --asserted, not after it goes low since encoder_q_o gets encoder_d_i(0)
            END IF;
        END IF;
    END encoder_process;
END behav;
