LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fir_lpf IS

    GENERIC (
        bit_depth : integer := 8;                                 --Variable bit depth (8,16,24,32)
        sample_freq : integer := 44100                            --Variable sampling frequency (44.1k,48k,96k,192k)
    );
    
    PORT (
        filter_clk  : IN std_logic;
        filter_rst  : IN std_logic;
        input_dataL  : IN std_logic_vector(bit_depth-1 downto 0);
        input_dataR : IN std_logic_vector(bit_depth-1 downto 0);
        coeff1      : IN std_logic_vector(15 downto 0);
        coeff2      : IN std_logic_vector(15 downto 0);
        coeff3      : IN std_logic_vector(15 downto 0);
        coeff4      : IN std_logic_vector(15 downto 0);
        coeff5      : IN std_logic_vector(15 downto 0);
        coeff6      : IN std_logic_vector(15 downto 0);
        coeff7      : IN std_logic_vector(15 downto 0);
        coeff8      : IN std_logic_vector(15 downto 0);
        coeff9      : IN std_logic_vector(15 downto 0);
        coeff10     : IN std_logic_vector(15 downto 0);
        coeff11     : IN std_logic_vector(15 downto 0);
        coeff12     : IN std_logic_vector(15 downto 0);
        coeff13     : IN std_logic_vector(15 downto 0);
        coeff14     : IN std_logic_vector(15 downto 0);
        coeff15     : IN std_logic_vector(15 downto 0);
        summationL : OUT signed((bit_depth + 15) downto 0);
        summationR : OUT signed((bit_depth + 15) downto 0)
    );

END ENTITY;

ARCHITECTURE rtl OF fir_lpf IS
    
    constant mult_gnd : signed(bit_depth + 15 downto 0):= (others => '0');
    constant reg_gnd : std_logic_vector(bit_depth - 1 downto 0) := (others => '0');
    signal mult1L : signed((bit_depth + 15) downto 0);
    signal mult2L : signed((bit_depth + 15) downto 0);
    signal mult3L : signed((bit_depth + 15) downto 0);
    signal mult4L : signed((bit_depth + 15) downto 0);
    signal mult5L : signed((bit_depth + 15) downto 0);
    signal mult6L : signed((bit_depth + 15) downto 0);
    signal mult7L : signed((bit_depth + 15) downto 0);
    signal mult8L : signed((bit_depth + 15) downto 0);  
    signal mult9L : signed((bit_depth + 15) downto 0);
    signal mult10L : signed((bit_depth + 15) downto 0);    
    signal mult11L : signed((bit_depth + 15) downto 0);
    signal mult12L : signed((bit_depth + 15) downto 0);
    signal mult13L : signed((bit_depth + 15) downto 0);
    signal mult14L : signed((bit_depth + 15) downto 0);  
    signal mult15L : signed((bit_depth + 15) downto 0);
    signal mult1R : signed((bit_depth + 15) downto 0);
    signal mult2R : signed((bit_depth + 15) downto 0);
    signal mult3R : signed((bit_depth + 15) downto 0);
    signal mult4R : signed((bit_depth + 15) downto 0);
    signal mult5R : signed((bit_depth + 15) downto 0);
    signal mult6R : signed((bit_depth + 15) downto 0);
    signal mult7R : signed((bit_depth + 15) downto 0);
    signal mult8R : signed((bit_depth + 15) downto 0);  
    signal mult9R : signed((bit_depth + 15) downto 0);
    signal mult10R : signed((bit_depth + 15) downto 0);    
    signal mult11R : signed((bit_depth + 15) downto 0);
    signal mult12R : signed((bit_depth + 15) downto 0);
    signal mult13R : signed((bit_depth + 15) downto 0);
    signal mult14R : signed((bit_depth + 15) downto 0);  
    signal mult15R : signed((bit_depth + 15) downto 0);
    signal z_reg1L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg2L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg3L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg4L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg5L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg6L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg7L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg8L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg9L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg10L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg11L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg12L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg13L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg14L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg15L : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg1R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg2R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg3R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg4R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg5R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg6R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg7R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg8R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg9R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg10R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg11R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg12R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg13R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg14R : std_logic_vector(bit_depth-1 downto 0);
    signal z_reg15R : std_logic_vector(bit_depth-1 downto 0);
          
BEGIN

    mult_processL : process(filter_clk,filter_rst)
    begin
         if filter_rst = '1' then
            mult1L <= mult_gnd;
            mult2L <= mult_gnd;
            mult3L <= mult_gnd;
            mult4L <= mult_gnd;
            mult5L <= mult_gnd;
            mult6L <= mult_gnd;
            mult7L <= mult_gnd;
            mult8L <= mult_gnd;
            mult9L <= mult_gnd;
            mult10L <= mult_gnd;
            mult11L <= mult_gnd;
            mult12L <= mult_gnd;
            mult13L <= mult_gnd;
            mult14L <= mult_gnd;
            mult15L <= mult_gnd;
            z_reg1L <= reg_gnd;
            z_reg2L <= reg_gnd;
            z_reg3L <= reg_gnd;
            z_reg4L <= reg_gnd;
            z_reg5L <= reg_gnd;
            z_reg6L <= reg_gnd;
            z_reg7L <= reg_gnd;
            z_reg8L <= reg_gnd;
            z_reg9L <= reg_gnd;
            z_reg10L <= reg_gnd;
            z_reg11L <= reg_gnd;
            z_reg12L <= reg_gnd;
            z_reg13L <= reg_gnd;
            z_reg14L <= reg_gnd;
            z_reg15L <= reg_gnd;
          elsif rising_edge(filter_clk) then
            z_reg1L <= input_dataL;
            mult1L <= signed(z_reg1L) * signed(coeff1);
            z_reg2L <= z_reg1L;
            mult2L <= signed(z_reg2L) * signed(coeff2);
            z_reg3L <= z_reg2L;
            mult3L <= signed(z_reg3L) * signed(coeff3);
            z_reg4L <= z_reg3L;
            mult4L <= signed(z_reg4L) * signed(coeff4);
            z_reg5L <= z_reg4L;
            mult5L <= signed(z_reg5L) * signed(coeff5);
            z_reg6L <= z_reg5L;
            mult6L <= signed(z_reg6L) * signed(coeff6);
            z_reg7L <= z_reg6L;
            mult7L <= signed(z_reg7L) * signed(coeff7);
            z_reg8L <= z_reg7L;
            mult8L <= signed(z_reg8L) * signed(coeff8);
            z_reg9L <= z_reg8L;
            mult9L <= signed(z_reg9L) * signed(coeff9);
            z_reg10L <= z_reg9L;
            mult10L <= signed(z_reg10L) * signed(coeff10);
            z_reg11L <= z_reg10L;
            mult11L <= signed(z_reg11L) * signed(coeff11);
            z_reg12L <= z_reg11L;
            mult12L <= signed(z_reg12L) * signed(coeff12);
            z_reg13L <= z_reg12L;
            mult13L <= signed(z_reg13L) * signed(coeff13);
            z_reg14L <= z_reg13L;
            mult14L <= signed(z_reg14L) * signed(coeff14);
            z_reg15L <= z_reg14L;   
            mult15L <= signed(z_reg15L) * signed(coeff15);
          end if;
    end process;
    
    mult_processR: process(filter_clk,filter_rst)
    begin
        if (filter_rst = '1') then
            mult1R <= mult_gnd;
            mult2R <= mult_gnd;
            mult3R <= mult_gnd;
            mult4R <= mult_gnd;
            mult5R <= mult_gnd;
            mult6R <= mult_gnd;
            mult7R <= mult_gnd;
            mult8R <= mult_gnd;
            mult9R <= mult_gnd;
            mult10R <= mult_gnd;
            mult11R <= mult_gnd;
            mult12R <= mult_gnd;
            mult13R <= mult_gnd;
            mult14R <= mult_gnd;
            mult15R <= mult_gnd;
            z_reg1R <= reg_gnd;
            z_reg2R <= reg_gnd;
            z_reg3R <= reg_gnd;
            z_reg4R <= reg_gnd;
            z_reg5R <= reg_gnd;
            z_reg6R <= reg_gnd;
            z_reg7R <= reg_gnd;
            z_reg8R <= reg_gnd;
            z_reg9R <= reg_gnd;
            z_reg10R <= reg_gnd;
            z_reg11R <= reg_gnd;
            z_reg12R <= reg_gnd;
            z_reg13R <= reg_gnd;
            z_reg14R <= reg_gnd;
            z_reg15R <= reg_gnd;
        elsif rising_edge(filter_clk) then
            z_reg1R <= input_dataR;
            mult1R <= signed(z_reg1R) * signed(coeff1);
            z_reg2R <= z_reg1R;
            mult2R <= signed(z_reg2R) * signed(coeff2);
            z_reg3R <= z_reg2R;
            mult3R <= signed(z_reg3R) * signed(coeff3);
            z_reg4R <= z_reg3R;
            mult4R <= signed(z_reg4R) * signed(coeff4);
            z_reg5R <= z_reg4R;
            mult5R <= signed(z_reg5R) * signed(coeff5);
            z_reg6R <= z_reg5R;
            mult6R <= signed(z_reg6R) * signed(coeff6);
            z_reg7R <= z_reg6R;
            mult7R <= signed(z_reg7R) * signed(coeff7);
            z_reg8R <= z_reg7R;
            mult8R <= signed(z_reg8R) * signed(coeff8);
            z_reg9R <= z_reg8R;
            mult9R <= signed(z_reg9R) * signed(coeff9);
            z_reg10R <= z_reg9R;
            mult10R <= signed(z_reg10R) * signed(coeff10);
            z_reg11R <= z_reg10R;
            mult11R <= signed(z_reg11R) * signed(coeff11);
            z_reg12R <= z_reg11R;
            mult12R <= signed(z_reg12R) * signed(coeff12);
            z_reg13R <= z_reg12R;
            mult13R <= signed(z_reg13R) * signed(coeff13);
            z_reg14R <= z_reg13R;
            mult14R <= signed(z_reg14R) * signed(coeff14);
            z_reg15R <= z_reg14R;   
            mult15R <= signed(z_reg15R) * signed(coeff15);
        end if;
    end process;
    
    addL_process : process(filter_clk)
    begin
        if rising_edge(filter_clk) then
            summationL <= mult1L + mult2L + mult3L + mult4L + mult5L + mult6L + mult7L + mult8L
            + mult9L + mult10L + mult11L + mult12L + mult13L + mult14L + mult15L;
        end if;
    end process;
    
    addR_process : process(filter_clk)
    begin
        if rising_edge(filter_clk) then
            summationR <= mult1R + mult2R + mult3R + mult4R + mult5R + mult6R + mult7R + mult8R
            + mult9R + mult10R + mult11R + mult12R + mult13R + mult14R + mult15R;
        end if;
    end process;
END rtl;
