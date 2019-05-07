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
    --A (03/25/19) : created file, wrote encoder_process
    --B (04/01/19) : reversed operation to Big Endian (MSB first)
    --See github for full revision history
------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY pcm_encoder IS
    GENERIC (
        bit_depth   : integer := 8;                                --Variable bit depth (8,16,24,32)
        sample_freq : integer := 44100;                            --Variable sampling frequency (44.1k,48k,96k,192k)
        MCLK_freq   : integer := 28224000                          --Note that for 48k,96k,192k, MCLK must equal 24576000
    );                                                             --This is because 28224000 is not evenly divisible for
                                                                   --all varying sample freqs
    PORT (
        L_encoder_d_i : IN std_logic_vector(bit_depth-1 downto 0); --Parallel data input left
        R_encoder_d_i : IN std_logic_vector(bit_depth-1 downto 0); --Parallel data input right
        MCLK_i        : IN std_logic;                              --Master clock input
        rst_i_async   : IN std_logic;                              --Asynchronous reset for ALL DFFs
        encoder_q_o   : OUT std_logic                              --Serial data output
    );
END pcm_encoder;

ARCHITECTURE behav OF pcm_encoder IS
    signal q_sig          : std_logic_vector(bit_depth-1 downto 1);   --Internal DFF outputs
    signal encoder_d_sig  : std_logic_vector(bit_depth-1 downto 0);   --LR Mux Output
    signal edge_LRCK_sig  : std_logic;                                --LRCK edge indicator
    signal dff_q_LREdge   : std_logic;                                --Internal DFF for edge indication
    constant gnd_sig      : std_logic_vector(bit_depth-1 downto 1) := (others => '0');  --Used for GND in reset

    constant BCK_freq     : integer := sample_freq*bit_depth*2;       --Calculate frequency of bit clock
    constant BCK_count    : integer := MCLK_freq/(2*BCK_freq);        --For bit depth 8, fs 44.1kHz, this is 20
    signal clk_counter    : integer range 0 to MCLK_freq/(2*sample_freq); --For bit depth 8, fs 44.1kHz, this is 320
    signal clk_diff       : integer range 0 to MCLK_freq/(2*sample_freq); --Keep track of difference between edges
    signal BCK_i   : std_logic; --Bit Clock
    signal LRCK_i  : std_logic; --Frame Clock
BEGIN
    sync_clk_en : PROCESS(rst_i_async, MCLK_i) --Synchronous Clock Enable for LRCK_i and BCK_i
    BEGIN
        IF rst_i_async = '1' THEN
            clk_counter <= 0;
            clk_diff <= 0;
            LRCK_i <= '0';
            BCK_i <= '0';
        ELSIF rising_edge(MCLK_i) THEN
            IF clk_counter = MCLK_freq/(2*sample_freq) THEN --LRCK_i enable at max clk_counter
                clk_diff <= 0;
                clk_counter <= 1;     -- =1 to avoid overcounting on transitions
                BCK_i <= NOT(BCK_i);  --Flip state instead of set to 1 for 50% duty cycle
                LRCK_i <= NOT(LRCK_i);
            ELSIF clk_counter - clk_diff = BCK_count THEN --intermediate BCK_i enable every BCK_count
                clk_diff <= clk_counter; --Keep track of clock counts since last BCK_i enable
                BCK_i <= NOT(BCK_i);
                clk_counter <= clk_counter + 1;
            ELSE
                clk_counter <= clk_counter + 1;
            END IF;
        END IF;
    END PROCESS sync_clk_en;

    encoder_d_sig <= R_encoder_d_i WHEN LRCK_i = '1' ELSE L_encoder_d_i;               --Input mux chooses L or R data
    edge_LRCK_sig <= (NOT(dff_q_LREdge) AND LRCK_i) OR (dff_q_LREdge AND NOT(LRCK_i)); --Edge detection for LRCK_i

    clk_edge_process : PROCESS(rst_i_async, BCK_i) --RTL for edge detection circuit
    BEGIN
        IF rst_i_async = '1' THEN
            dff_q_LREdge <= '0';
        ELSIF rising_edge(BCK_i) THEN
            dff_q_LREdge <= LRCK_i;
        END IF;
    END PROCESS clk_edge_process;

    encoder_process : PROCESS(rst_i_async, BCK_i) --Main encoder process
    BEGIN
        IF rst_i_async = '1' THEN
            q_sig <= gnd_sig;
            encoder_q_o <= '0';
        ELSIF rising_edge(BCK_i) THEN                         --Infer DFFs and Muxes
            IF edge_LRCK_sig = '1' THEN                       --Data input should occur at the start of each N-bit frame
                                                              --mux is tied to edge of LRCK to shift parallel data in
                FOR i in bit_depth-1 downto 1 LOOP
                    q_sig(i) <= encoder_d_sig(bit_depth-1-i); --Assign DFF outputs w/ parallel data LSB->MSB
                END LOOP;
                encoder_q_o <= encoder_d_sig(bit_depth-1);    --Assign encoder output w/ MSB of parallel data
            ELSE                                              --Shift serial out when not edge of LRCK
                FOR i in bit_depth-2 downto 1 LOOP
                    q_sig(i) <= q_sig(i+1);            --Connect inferred DFFs LSB-to-MSB
                END LOOP;
                q_sig(bit_depth-1) <= '0';             --LSB DFF gets a '0' input for steady-state operation
                encoder_q_o <= q_sig(1);               --Assign encoder output w/ MSB DFF output
                                                       --Note that DATA is MSB first
                                                       --Also, first serial data bit is valid first BCK_i rising edge after
                                                       --edge_LRCK_sig is asserted
            END IF;
        END IF;
    END process encoder_process;
END behav;
