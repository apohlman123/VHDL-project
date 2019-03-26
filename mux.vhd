------------------------------------------------------------------------------
--Company:      Loyola Marymount University
--Engineer:     Austin Pohlman

--Create Date:  03/24/2019
--Design Name:
--Module Name:
--Project Name: PCM Encoding/Decoding
--Tool Versions:
--Description:
    --Simple 2-input MUX to be used for PCM Encoder

--Dependencies:

--Revisions:
    --A : created file, coded MUX
------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux IS
    GENERIC(
        tprop : delay := 10 ns
    );

    PORT (
        mux_in     : in std_logic_vector(1 downto 0);
        mux_select : in std_logic;
        mux_out    : out std_logic
    );
END mux;

ARCHITECTURE mux_behav OF mux IS
BEGIN
    mux_out <= mux_in(1) AFTER tprop WHEN mux_select='1' ELSE mux_in(0);
END mux_behav;
