# VHDL-project
Austin, Joe, Clay VHDL Final Project - PCM Encoder/Decoder

Clocking Scheme:
    Master Clock (MCLK):
        Frequency will be the LCM of 44.1kHz, 48kHz, 96kHz, 192kHz
            -The value is 28.224MHz, which will be divided down to derive the
            -...bit clock (BCK) and frame clock (LRCK)
            -Note that for sampling frequencies of 48k,96k, and 192k, a different MCLK will need to be used of value 24.576MHz

    Frame Clock (LRCK):
        Frequency will be the chosen sampling frequency (44.1, 48, 96, 192 etc...)
            -Also known as the Left-Right clock, left-channel stereo data is
            -...clocked in after the falling edge, and right-channel data is
            -...clocked in after the rising edge

    Bit Clock (BCK):
        Frequency will be fs*bit_depth*2
