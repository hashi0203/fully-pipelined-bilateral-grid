-- ==============================================================
-- Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.2.1 (64-bit)
-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all;

entity bg_dif_z_rom is 
    generic(
             DWIDTH     : integer := 8; 
             AWIDTH     : integer := 8; 
             MEM_SIZE    : integer := 256
    ); 
    port (
          addr0      : in std_logic_vector(AWIDTH-1 downto 0); 
          ce0       : in std_logic; 
          q0         : out std_logic_vector(DWIDTH-1 downto 0);
          clk       : in std_logic
    ); 
end entity; 


architecture rtl of bg_dif_z_rom is 

signal addr0_tmp : std_logic_vector(AWIDTH-1 downto 0); 
type mem_array is array (0 to MEM_SIZE-1) of std_logic_vector (DWIDTH-1 downto 0); 
signal mem : mem_array := (
    0 => "00000000", 1 => "00000010", 2 => "00000101", 3 => "00000111", 
    4 => "00001010", 5 => "00001100", 6 => "00001111", 7 => "00010001", 
    8 => "00010100", 9 => "00010110", 10 => "00011000", 11 => "00011011", 
    12 => "00011101", 13 => "00100000", 14 => "00100010", 15 => "00100101", 
    16 => "00100111", 17 => "00101001", 18 => "00101100", 19 => "00101110", 
    20 => "00110001", 21 => "00110011", 22 => "00110110", 23 => "00111000", 
    24 => "00111011", 25 => "00111101", 26 => "00111111", 27 => "01000010", 
    28 => "01000100", 29 => "01000111", 30 => "01001001", 31 => "01001100", 
    32 => "01001110", 33 => "01010000", 34 => "01010011", 35 => "01010101", 
    36 => "01011000", 37 => "01011010", 38 => "01011101", 39 => "01011111", 
    40 => "01100010", 41 => "01100100", 42 => "01100110", 43 => "01101001", 
    44 => "01101011", 45 => "01101110", 46 => "01110000", 47 => "01110011", 
    48 => "01110101", 49 => "01110111", 50 => "01111010", 51 => "01111100", 
    52 => "01111111", 53 => "10000001", 54 => "10000100", 55 => "10000110", 
    56 => "10001001", 57 => "10001011", 58 => "10001101", 59 => "10010000", 
    60 => "10010010", 61 => "10010101", 62 => "10010111", 63 => "10011010", 
    64 => "10011100", 65 => "10011110", 66 => "10100001", 67 => "10100011", 
    68 => "10100110", 69 => "10101000", 70 => "10101011", 71 => "10101101", 
    72 => "10110000", 73 => "10110010", 74 => "10110100", 75 => "10110111", 
    76 => "10111001", 77 => "10111100", 78 => "10111110", 79 => "11000001", 
    80 => "11000011", 81 => "11000101", 82 => "11001000", 83 => "11001010", 
    84 => "11001101", 85 => "11001111", 86 => "11010010", 87 => "11010100", 
    88 => "11010111", 89 => "11011001", 90 => "11011011", 91 => "11011110", 
    92 => "11100000", 93 => "11100011", 94 => "11100101", 95 => "11101000", 
    96 => "11101010", 97 => "11101100", 98 => "11101111", 99 => "11110001", 
    100 => "11110100", 101 => "11110110", 102 => "11111001", 103 => "11111011", 
    104 => "11111110", 105 => "00000000", 106 => "00000010", 107 => "00000101", 
    108 => "00000111", 109 => "00001010", 110 => "00001100", 111 => "00001111", 
    112 => "00010001", 113 => "00010100", 114 => "00010110", 115 => "00011000", 
    116 => "00011011", 117 => "00011101", 118 => "00100000", 119 => "00100010", 
    120 => "00100101", 121 => "00100111", 122 => "00101001", 123 => "00101100", 
    124 => "00101110", 125 => "00110001", 126 => "00110011", 127 => "00110110", 
    128 => "00111000", 129 => "00111011", 130 => "00111101", 131 => "00111111", 
    132 => "01000010", 133 => "01000100", 134 => "01000111", 135 => "01001001", 
    136 => "01001100", 137 => "01001110", 138 => "01010000", 139 => "01010011", 
    140 => "01010101", 141 => "01011000", 142 => "01011010", 143 => "01011101", 
    144 => "01011111", 145 => "01100010", 146 => "01100100", 147 => "01100110", 
    148 => "01101001", 149 => "01101011", 150 => "01101110", 151 => "01110000", 
    152 => "01110011", 153 => "01110101", 154 => "01110111", 155 => "01111010", 
    156 => "01111100", 157 => "01111111", 158 => "10000001", 159 => "10000100", 
    160 => "10000110", 161 => "10001001", 162 => "10001011", 163 => "10001101", 
    164 => "10010000", 165 => "10010010", 166 => "10010101", 167 => "10010111", 
    168 => "10011010", 169 => "10011100", 170 => "10011110", 171 => "10100001", 
    172 => "10100011", 173 => "10100110", 174 => "10101000", 175 => "10101011", 
    176 => "10101101", 177 => "10110000", 178 => "10110010", 179 => "10110100", 
    180 => "10110111", 181 => "10111001", 182 => "10111100", 183 => "10111110", 
    184 => "11000001", 185 => "11000011", 186 => "11000101", 187 => "11001000", 
    188 => "11001010", 189 => "11001101", 190 => "11001111", 191 => "11010010", 
    192 => "11010100", 193 => "11010111", 194 => "11011001", 195 => "11011011", 
    196 => "11011110", 197 => "11100000", 198 => "11100011", 199 => "11100101", 
    200 => "11101000", 201 => "11101010", 202 => "11101100", 203 => "11101111", 
    204 => "11110001", 205 => "11110100", 206 => "11110110", 207 => "11111001", 
    208 => "11111011", 209 => "11111110", 210 => "00000000", 211 => "00000010", 
    212 => "00000101", 213 => "00000111", 214 => "00001010", 215 => "00001100", 
    216 => "00001111", 217 => "00010001", 218 => "00010100", 219 => "00010110", 
    220 => "00011000", 221 => "00011011", 222 => "00011101", 223 => "00100000", 
    224 => "00100010", 225 => "00100101", 226 => "00100111", 227 => "00101001", 
    228 => "00101100", 229 => "00101110", 230 => "00110001", 231 => "00110011", 
    232 => "00110110", 233 => "00111000", 234 => "00111011", 235 => "00111101", 
    236 => "00111111", 237 => "01000010", 238 => "01000100", 239 => "01000111", 
    240 => "01001001", 241 => "01001100", 242 => "01001110", 243 => "01010000", 
    244 => "01010011", 245 => "01010101", 246 => "01011000", 247 => "01011010", 
    248 => "01011101", 249 => "01011111", 250 => "01100010", 251 => "01100100", 
    252 => "01100110", 253 => "01101001", 254 => "01101011", 255 => "01101110" );


begin 


memory_access_guard_0: process (addr0) 
begin
      addr0_tmp <= addr0;
--synthesis translate_off
      if (CONV_INTEGER(addr0) > mem_size-1) then
           addr0_tmp <= (others => '0');
      else 
           addr0_tmp <= addr0;
      end if;
--synthesis translate_on
end process;

p_rom_access: process (clk)  
begin 
    if (clk'event and clk = '1') then
        if (ce0 = '1') then 
            q0 <= mem(CONV_INTEGER(addr0_tmp)); 
        end if;
    end if;
end process;

end rtl;

Library IEEE;
use IEEE.std_logic_1164.all;

entity bg_dif_z is
    generic (
        DataWidth : INTEGER := 8;
        AddressRange : INTEGER := 256;
        AddressWidth : INTEGER := 8);
    port (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        address0 : IN STD_LOGIC_VECTOR(AddressWidth - 1 DOWNTO 0);
        ce0 : IN STD_LOGIC;
        q0 : OUT STD_LOGIC_VECTOR(DataWidth - 1 DOWNTO 0));
end entity;

architecture arch of bg_dif_z is
    component bg_dif_z_rom is
        port (
            clk : IN STD_LOGIC;
            addr0 : IN STD_LOGIC_VECTOR;
            ce0 : IN STD_LOGIC;
            q0 : OUT STD_LOGIC_VECTOR);
    end component;



begin
    bg_dif_z_rom_U :  component bg_dif_z_rom
    port map (
        clk => clk,
        addr0 => address0,
        ce0 => ce0,
        q0 => q0);

end architecture;


