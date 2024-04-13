library ieee;
use ieee.std_logic_1164.all;

entity instruction_decoder is
  port (
    op_code : in std_logic_vector(3 downto 0);
    LDA     : out std_logic;
    ADD     : out std_logic;
    SUB     : out std_logic;
    OUTP    : out std_logic;
    HLT     : out std_logic
  );
end instruction_decoder;

architecture behavioral of instruction_decoder is
begin
  LDA  <= not (op_code(0) or op_code(1) or op_code(2) or op_code(3)); -- 0000
  ADD  <= not (not op_code(0) or op_code(1) or op_code(2) or op_code(3)); -- 0001
  SUB  <= not (op_code(0) or not op_code(1) or op_code(2) or op_code(3)); -- 0010
  OUTP <= (not op_code(0) and op_code(1) and op_code(2) and op_code(3)); -- 1110
  HLT  <= not (op_code(0) and op_code(1) and op_code(2) and op_code(3)); -- 1111
end behavioral;