abstract class RegisterKey {
  // General purpose registers
  static const String ra = 'Ra';
  static const String rb = 'Rb';
  static const String rc = 'Rc';
  static const String rd = 'Rd';
  static const String re = 'Re';
  static const String rf = 'Rf';
  static const String rg = 'Rg';
  static const String rh = 'Rh';
  // Special purpose registers
  static const String ip = 'IP'; // Instruction pointer
  static const String sp = 'SP'; // Stack pointer
}

abstract class OperatorKey {
  static const String lessThan = '<';
  static const String greaterThan = '>';
  static const String lessThanOrEqual = '<=';
  static const String greaterThanOrEqual = '>=';
  static const String equal = '==';
  static const String notEqual = '!=';
}

abstract class InstructionKey {
  static const String add = 'ADD';
  static const String sub = 'SUB';
  static const String mul = 'MUL';
  static const String div = 'DIV';
  static const String inc = 'INC';
  static const String dec = 'DEC';
  static const String cmp = 'CMP';
  static const String constKey = 'CONST';
  static const String load = 'LOAD';
  static const String store = 'STORE';
  static const String jmp = 'JMP';
  static const String halt = 'HALT';
}
