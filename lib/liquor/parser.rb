#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.8
# from Racc grammer file "".
#

require 'racc/parser.rb'
module Liquor
  class Parser < Racc::Parser

module_eval(<<'...end parser.racc/module_eval...', 'parser.racc', 109)
  def parse(stream)
    @stream = stream
    do_parse
  end

  def next_token
    tok = @stream.shift
    [ tok[0], tok ] if tok
  end

  TOKEN_NAME_MAP = {
    :comma    => ',',
    :dot      => '.',
    :lblock   => '{%',
    :rblock   => '%}',
    :linterp  => '{{',
    :rinterp  => '}}',
    :lbracket => '[',
    :rbracket => ']',
    :lparen   => '(',
    :rparen   => ')',
    :pipe     => '|',
    :op_not   => '!',
    :op_mul   => '*',
    :op_div   => '/',
    :op_mod   => '%',
    :op_plus  => '+',
    :op_minus => '-',
    :op_eq    => '==',
    :op_neq   => '!=',
    :op_lt    => '<',
    :op_leq   => '<=',
    :op_gt    => '>',
    :op_geq   => '>=',
  }

  def on_error(error_token_id, error_token, value_stack)
    type, (pos, value) = error_token
    type = TOKEN_NAME_MAP[type] || type
    raise Liquor::SyntaxError.new("unexpected token `#{type}'", pos)
  end

  def retag(pos_list)
    first, *, last = pos_list
    {
      line:  first[1][:line],
      start: first[1][:start],
      end:    last[1][:end],
    }
  end

...end parser.racc/module_eval...
##### State transition tables begin ###

racc_action_table = [
    61,    63,    62,    36,    60,     4,    33,     4,     4,    35,
    21,    25,    29,    30,    27,    28,    24,    22,    20,    26,
     2,    23,     2,     2,     5,    18,   nil,   nil,   nil,    57,
   nil,   nil,    31,    32,    21,    25,    29,    30,    27,    28,
    24,    22,    20,    26,    21,    23,   nil,   nil,   nil,   nil,
    24,    22,    20,    57,   nil,    23,    31,    32,    21,    25,
    29,    30,    27,    28,    24,    22,    20,    26,   nil,    23,
     9,    11,   nil,   nil,    17,   nil,    10,   nil,   nil,   nil,
    31,    32,   nil,    15,     9,    11,    21,    16,    17,   nil,
    10,   nil,   nil,    22,    20,    12,   nil,    15,     9,    11,
    21,    16,    17,   nil,    10,   nil,   nil,    22,    20,    12,
   nil,    15,     9,    11,   nil,    16,    17,   nil,    10,   nil,
   nil,   nil,   nil,    12,   nil,    15,     9,    11,    57,    16,
    17,   nil,    10,   nil,   nil,   nil,   nil,    12,   nil,    15,
     9,    11,   nil,    16,    17,   nil,    10,   nil,   nil,   nil,
   nil,    12,   nil,    15,     9,    11,   nil,    16,    17,   nil,
    10,   nil,   nil,   nil,   nil,    12,   nil,    15,     9,    11,
   nil,    16,    17,   nil,    10,   nil,   nil,   nil,   nil,    12,
   nil,    15,     9,    11,   nil,    16,    17,   nil,    10,   nil,
   nil,   nil,   nil,    12,   nil,    15,     9,    11,   nil,    16,
    17,   nil,    10,   nil,   nil,   nil,   nil,    12,   nil,    15,
     9,    11,   nil,    16,    17,   nil,    10,   nil,   nil,   nil,
   nil,    12,   nil,    15,     9,    11,   nil,    16,    17,   nil,
    10,   nil,   nil,   nil,   nil,    12,   nil,    15,     9,    11,
   nil,    16,    17,   nil,    10,   nil,   nil,   nil,   nil,    12,
   nil,    15,     9,    11,   nil,    16,    17,   nil,    10,   nil,
   nil,   nil,   nil,    12,   nil,    15,     9,    11,   nil,    16,
    17,   nil,    10,   nil,   nil,   nil,   nil,    12,   nil,    15,
     9,    11,   nil,    16,    17,   nil,    10,   nil,   nil,   nil,
   nil,    12,   nil,    15,     9,    11,   nil,    16,    17,   nil,
    10,   nil,   nil,   nil,   nil,    12,   nil,    15,     9,    11,
   nil,    16,    17,   nil,    10,   nil,   nil,   nil,   nil,    12,
   nil,    15,     9,    11,   nil,    16,    17,   nil,    10,   nil,
   nil,   nil,   nil,    12,   nil,    15,     9,    11,   nil,    16,
    17,   nil,    10,   nil,   nil,   nil,   nil,    12,   nil,    15,
     9,    11,   nil,    16,    17,   nil,    10,   nil,   nil,   nil,
   nil,    12,   nil,    15,     9,    11,   nil,    16,    17,   nil,
    10,   nil,    21,   nil,   nil,    12,   nil,    15,    24,    22,
    20,    16,   nil,    23,   nil,   nil,   nil,   nil,   nil,    12,
    21,    25,    29,    30,    27,    28,    24,    22,    20,    26,
    21,    23,   nil,   nil,   nil,   nil,    24,    22,    20,   nil,
   nil,    23,    31,    32,    21,    25,    29,    30,    27,    28,
    24,    22,    20,    26,    21,    23,   nil,   nil,   nil,    66,
    24,    22,    20,   nil,   nil,    23,    31,    32,    21,    25,
    29,    30,    27,    28,    24,    22,    20,    26,   nil,    23,
   nil,   nil,   nil,   nil,    19,   nil,   nil,   nil,   nil,   nil,
    31,    32,    21,    25,    29,    30,    27,    28,    24,    22,
    20,    26,   nil,    23,   nil,   nil,   nil,   nil,   nil,    58,
   nil,   nil,   nil,   nil,    31,    32,    21,    25,    29,    30,
    27,    28,    24,    22,    20,    26,   nil,    23,    21,    25,
    29,    30,    27,    28,    24,    22,    20,    26,    31,    23,
    21,   nil,   nil,   nil,   nil,   nil,    24,    22,    20,    21,
   nil,    23,   nil,   nil,   nil,    24,    22,    20,   nil,   nil,
    23 ]

racc_action_check = [
    39,    54,    40,    14,    36,     0,     9,     3,     2,    14,
    39,    39,    39,    39,    39,    39,    39,    39,    39,    39,
     0,    39,     3,     2,     1,     5,   nil,   nil,   nil,    65,
   nil,   nil,    39,    39,    65,    65,    65,    65,    65,    65,
    65,    65,    65,    65,    46,    65,   nil,   nil,   nil,   nil,
    46,    46,    46,    55,   nil,    46,    65,    65,    55,    55,
    55,    55,    55,    55,    55,    55,    55,    55,   nil,    55,
    17,    17,   nil,   nil,    17,   nil,    17,   nil,   nil,   nil,
    55,    55,   nil,    17,     4,     4,    45,    17,     4,   nil,
     4,   nil,   nil,    45,    45,    17,   nil,     4,    61,    61,
    44,     4,    61,   nil,    61,   nil,   nil,    44,    44,     4,
   nil,    61,    35,    35,   nil,    61,    35,   nil,    35,   nil,
   nil,   nil,   nil,    61,   nil,    35,    33,    33,    33,    35,
    33,   nil,    33,   nil,   nil,   nil,   nil,    35,   nil,    33,
    10,    10,   nil,    33,    10,   nil,    10,   nil,   nil,   nil,
   nil,    33,   nil,    10,    32,    32,   nil,    10,    32,   nil,
    32,   nil,   nil,   nil,   nil,    10,   nil,    32,    15,    15,
   nil,    32,    15,   nil,    15,   nil,   nil,   nil,   nil,    32,
   nil,    15,    16,    16,   nil,    15,    16,   nil,    16,   nil,
   nil,   nil,   nil,    15,   nil,    16,    57,    57,   nil,    16,
    57,   nil,    57,   nil,   nil,   nil,   nil,    16,   nil,    57,
    20,    20,   nil,    57,    20,   nil,    20,   nil,   nil,   nil,
   nil,    57,   nil,    20,    21,    21,   nil,    20,    21,   nil,
    21,   nil,   nil,   nil,   nil,    20,   nil,    21,    22,    22,
   nil,    21,    22,   nil,    22,   nil,   nil,   nil,   nil,    21,
   nil,    22,    23,    23,   nil,    22,    23,   nil,    23,   nil,
   nil,   nil,   nil,    22,   nil,    23,    24,    24,   nil,    23,
    24,   nil,    24,   nil,   nil,   nil,   nil,    23,   nil,    24,
    25,    25,   nil,    24,    25,   nil,    25,   nil,   nil,   nil,
   nil,    24,   nil,    25,    26,    26,   nil,    25,    26,   nil,
    26,   nil,   nil,   nil,   nil,    25,   nil,    26,    27,    27,
   nil,    26,    27,   nil,    27,   nil,   nil,   nil,   nil,    26,
   nil,    27,    28,    28,   nil,    27,    28,   nil,    28,   nil,
   nil,   nil,   nil,    27,   nil,    28,    29,    29,   nil,    28,
    29,   nil,    29,   nil,   nil,   nil,   nil,    28,   nil,    29,
    30,    30,   nil,    29,    30,   nil,    30,   nil,   nil,   nil,
   nil,    29,   nil,    30,    31,    31,   nil,    30,    31,   nil,
    31,   nil,    51,   nil,   nil,    30,   nil,    31,    51,    51,
    51,    31,   nil,    51,   nil,   nil,   nil,   nil,   nil,    31,
    38,    38,    38,    38,    38,    38,    38,    38,    38,    38,
    47,    38,   nil,   nil,   nil,   nil,    47,    47,    47,   nil,
   nil,    47,    38,    38,    59,    59,    59,    59,    59,    59,
    59,    59,    59,    59,    50,    59,   nil,   nil,   nil,    59,
    50,    50,    50,   nil,   nil,    50,    59,    59,     8,     8,
     8,     8,     8,     8,     8,     8,     8,     8,   nil,     8,
   nil,   nil,   nil,   nil,     8,   nil,   nil,   nil,   nil,   nil,
     8,     8,    34,    34,    34,    34,    34,    34,    34,    34,
    34,    34,   nil,    34,   nil,   nil,   nil,   nil,   nil,    34,
   nil,   nil,   nil,   nil,    34,    34,    53,    53,    53,    53,
    53,    53,    53,    53,    53,    53,   nil,    53,    52,    52,
    52,    52,    52,    52,    52,    52,    52,    52,    53,    52,
    49,   nil,   nil,   nil,   nil,   nil,    49,    49,    49,    48,
   nil,    49,   nil,   nil,   nil,    48,    48,    48,   nil,   nil,
    48 ]

racc_action_pointer = [
    -5,    24,    -2,    -3,    79,    25,   nil,   nil,   426,    -5,
   135,   nil,   nil,   nil,     0,   163,   177,    65,   nil,   nil,
   205,   219,   233,   247,   261,   275,   289,   303,   317,   331,
   345,   359,   149,   121,   450,   107,    -1,   nil,   378,    -2,
   -25,   nil,   nil,   nil,    88,    74,    32,   388,   507,   498,
   412,   360,   486,   474,   -28,    46,   nil,   191,   nil,   402,
   nil,    93,   nil,   nil,   nil,    22,   nil,   nil,   nil ]

racc_action_default = [
    -1,   -37,    -1,    -1,   -37,   -37,    -2,    -3,   -37,    -5,
   -37,    -7,    -8,    -9,   -28,   -37,   -37,   -32,    69,    -4,
   -37,   -37,   -37,   -37,   -37,   -37,   -37,   -37,   -37,   -37,
   -37,   -37,   -37,   -36,   -37,   -37,   -37,   -13,   -14,   -31,
   -37,   -15,   -16,   -17,   -18,   -19,   -20,   -21,   -22,   -23,
   -24,   -25,   -26,   -27,   -37,   -36,   -34,   -37,    -6,   -37,
   -12,   -32,   -29,   -10,   -33,   -36,   -11,   -30,   -35 ]

racc_goto_table = [
     8,    40,     1,    54,     6,     7,    34,   nil,    56,   nil,
   nil,    37,    38,   nil,   nil,   nil,    41,    42,    43,    44,
    45,    46,    47,    48,    49,    50,    51,    52,    53,    55,
    64,    59,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
    68,   nil,   nil,   nil,   nil,    67,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    65 ]

racc_goto_check = [
     3,     7,     1,     6,     1,     1,     3,   nil,     8,   nil,
   nil,     3,     3,   nil,   nil,   nil,     3,     3,     3,     3,
     3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
     8,     3,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
     8,   nil,   nil,   nil,   nil,     7,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     3 ]

racc_goto_pointer = [
   nil,     2,   nil,    -4,   nil,   nil,   -30,   -16,   -25 ]

racc_goto_default = [
   nil,   nil,     3,    39,    14,    13,   nil,   nil,   nil ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 37, :_reduce_none,
  2, 37, :_reduce_2,
  2, 37, :_reduce_3,
  3, 38, :_reduce_4,
  1, 40, :_reduce_none,
  3, 40, :_reduce_6,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  1, 39, :_reduce_none,
  4, 39, :_reduce_10,
  4, 39, :_reduce_11,
  3, 39, :_reduce_12,
  2, 39, :_reduce_13,
  2, 39, :_reduce_14,
  3, 39, :_reduce_15,
  3, 39, :_reduce_16,
  3, 39, :_reduce_17,
  3, 39, :_reduce_18,
  3, 39, :_reduce_19,
  3, 39, :_reduce_20,
  3, 39, :_reduce_21,
  3, 39, :_reduce_22,
  3, 39, :_reduce_23,
  3, 39, :_reduce_24,
  3, 39, :_reduce_25,
  3, 39, :_reduce_26,
  3, 39, :_reduce_27,
  1, 39, :_reduce_none,
  3, 41, :_reduce_29,
  3, 43, :_reduce_30,
  1, 43, :_reduce_31,
  0, 43, :_reduce_32,
  2, 42, :_reduce_33,
  1, 42, :_reduce_34,
  3, 44, :_reduce_35,
  0, 44, :_reduce_36 ]

racc_reduce_n = 37

racc_shift_n = 69

racc_token_table = {
  false => 0,
  :error => 1,
  :comma => 2,
  :dot => 3,
  :endtag => 4,
  :ident => 5,
  :integer => 6,
  :kwarg => 7,
  :lblock => 8,
  :lbracket => 9,
  :linterp => 10,
  :lparen => 11,
  :op_div => 12,
  :op_eq => 13,
  :op_gt => 14,
  :op_geq => 15,
  :op_lt => 16,
  :op_leq => 17,
  :op_minus => 18,
  :op_mod => 19,
  :op_mul => 20,
  :op_neq => 21,
  :op_not => 22,
  :op_plus => 23,
  :pipe => 24,
  :plaintext => 25,
  :rblock => 26,
  :rbracket => 27,
  :rinterp => 28,
  :rparen => 29,
  :string => 30,
  :tag => 31,
  :op_uminus => 32,
  :op_neg => 33,
  :op_and => 34,
  :op_or => 35 }

racc_nt_base = 36

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "comma",
  "dot",
  "endtag",
  "ident",
  "integer",
  "kwarg",
  "lblock",
  "lbracket",
  "linterp",
  "lparen",
  "op_div",
  "op_eq",
  "op_gt",
  "op_geq",
  "op_lt",
  "op_leq",
  "op_minus",
  "op_mod",
  "op_mul",
  "op_neq",
  "op_not",
  "op_plus",
  "pipe",
  "plaintext",
  "rblock",
  "rbracket",
  "rinterp",
  "rparen",
  "string",
  "tag",
  "op_uminus",
  "op_neg",
  "op_and",
  "op_or",
  "$start",
  "block",
  "interp",
  "expr",
  "primary_expr",
  "tuple",
  "function_args",
  "tuple_content",
  "function_kwargs" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

# reduce 1 omitted

module_eval(<<'.,.,', 'parser.racc', 20)
  def _reduce_2(val, _values, result)
     result = [ val[0], *val[1] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 22)
  def _reduce_3(val, _values, result)
     result = [ val[0], *val[1] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 26)
  def _reduce_4(val, _values, result)
     result = [ :interp, retag(val), val[1] ] 
    result
  end
.,.,

# reduce 5 omitted

module_eval(<<'.,.,', 'parser.racc', 31)
  def _reduce_6(val, _values, result)
     result = [ val[1][0], retag(val), val[1][2..-1] ] 
    result
  end
.,.,

# reduce 7 omitted

# reduce 8 omitted

# reduce 9 omitted

module_eval(<<'.,.,', 'parser.racc', 38)
  def _reduce_10(val, _values, result)
     result = [ :call,   retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 40)
  def _reduce_11(val, _values, result)
     result = [ :index,  retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 42)
  def _reduce_12(val, _values, result)
     result = [ :access, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 44)
  def _reduce_13(val, _values, result)
     result = [ :uminus, retag(val), val[1] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 46)
  def _reduce_14(val, _values, result)
     result = [ :not, retag(val), val[1] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 48)
  def _reduce_15(val, _values, result)
     result = [ :mul, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 50)
  def _reduce_16(val, _values, result)
     result = [ :div, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 52)
  def _reduce_17(val, _values, result)
     result = [ :mod, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 54)
  def _reduce_18(val, _values, result)
     result = [ :plus, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 56)
  def _reduce_19(val, _values, result)
     result = [ :minus, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 58)
  def _reduce_20(val, _values, result)
     result = [ :eq, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 60)
  def _reduce_21(val, _values, result)
     result = [ :neq, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 62)
  def _reduce_22(val, _values, result)
     result = [ :lt, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 64)
  def _reduce_23(val, _values, result)
     result = [ :leq, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 66)
  def _reduce_24(val, _values, result)
     result = [ :gt, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 68)
  def _reduce_25(val, _values, result)
     result = [ :geq, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 70)
  def _reduce_26(val, _values, result)
     result = [ :and, retag(val), val[0], val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 72)
  def _reduce_27(val, _values, result)
     result = [ :or, retag(val), val[0], val[2] ] 
    result
  end
.,.,

# reduce 28 omitted

module_eval(<<'.,.,', 'parser.racc', 77)
  def _reduce_29(val, _values, result)
     result = [ :tuple, retag(val), val[1].compact ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 81)
  def _reduce_30(val, _values, result)
     result = [ val[0], *val[2] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 83)
  def _reduce_31(val, _values, result)
     result = [ val[0] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 85)
  def _reduce_32(val, _values, result)
     result = [ ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 89)
  def _reduce_33(val, _values, result)
     result = [ val[0], val[1] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 91)
  def _reduce_34(val, _values, result)
     result = [ nil, val[0] ] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 95)
  def _reduce_35(val, _values, result)
     # voodoo. well, it could be worse with (cdadr val) and stuff.
        if val[2].include? val[0][2]
          raise SyntaxError.new("duplicate keyword argument `#{val[0][2]}'",
              val[2][val[0][2]][1])
        end
        result = {
          val[0][2] => [ val[1][0], retag([ val[0], val[1] ]), val[1][2..-1] ]
        }.merge(val[2])
      
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.racc', 105)
  def _reduce_36(val, _values, result)
     result = {} 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Liquor

  pr = Liquor::Parser.new
  require 'pp'
  src = '{{f.e}}'
  begin
    pp pr.parse(Liquor::Lexer.lex(src))
  rescue Liquor::SyntaxError => e
    puts "Syntax error: #{e.message}"
    puts e.decorate(src)
  end