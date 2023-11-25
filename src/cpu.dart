/*

Instructions allowed

('ADD', 'Ra', 'Rb', 'Rc')
('SUB', 'Ra', 'Rb', 'Rc')
('MUL', 'Ra', 'Rb', 'Rc')
('DIV', 'Ra', 'Rb', 'Rc')
('INC', 'Ra')
('DEC', 'Ra')
('CMP', 'op', 'Ra', 'Rb', 'Rc') // op= {<, >, <=, >=, ==, !=}
('CONST', value, 'Ra')
('LOAD', 'Rs', 'Rd', offset) // Simulating RAM
('STORE', 'Rs', 'Rd', offset) // Simulating RAM
('JMP', 'Rd', offset) // Move IP to a memory direction
('HALT')

*/

import 'core/decode_instruction.dart';
import 'core/exceptions.dart';
import 'core/keys.dart';

class CPU {
  // Work registers
  Map<String, dynamic> registers = {
    RegisterKey.ra: null,
    RegisterKey.rb: null,
    RegisterKey.rc: null,
    RegisterKey.rd: null,
    RegisterKey.re: null,
    RegisterKey.rf: null,
    RegisterKey.rg: null,
    RegisterKey.rh: null,
    RegisterKey.ip: null,
    RegisterKey.sp: null,
  };
  // RAM memory
  List<int?> memory = List.filled(1024, null);

  // Last arithmetic operation flag
  int flag = 0;

  String run(List<String> program) {
    for (final String instruction in program) {
      final DecodeInstructionResult decodedInstruction =
          decodeInstruction(instruction);

      switch (decodedInstruction.instruction) {
        case InstructionKey.add:
          _add(
            rOne: decodedInstruction.args[0],
            rTwo: decodedInstruction.args[1],
            rResult: decodedInstruction.args[2],
          );
          break;
        case InstructionKey.sub:
          _sub(
            rOne: decodedInstruction.args[0],
            rTwo: decodedInstruction.args[1],
            rResult: decodedInstruction.args[2],
          );
          break;
        case InstructionKey.mul:
          _mul(
            rOne: decodedInstruction.args[0],
            rTwo: decodedInstruction.args[1],
            rResult: decodedInstruction.args[2],
          );
          break;
        case InstructionKey.div:
          _div(
            rOne: decodedInstruction.args[0],
            rTwo: decodedInstruction.args[1],
            rResult: decodedInstruction.args[2],
          );
          break;
        case InstructionKey.inc:
          _inc(r: registers[decodedInstruction.args[0]]!);
          break;
        case InstructionKey.dec:
          _dec(r: registers[decodedInstruction.args[0]]!);
          break;
        case InstructionKey.cmp:
          _cmp(
            op: decodedInstruction.args[0],
            rOne: decodedInstruction.args[1],
            rTwo: decodedInstruction.args[2],
            rResult: decodedInstruction.args[3],
          );
          break;
        case InstructionKey.constKey:
          _const(
            value: decodedInstruction.args[0],
            rResult: decodedInstruction.args[1],
          );
          break;
        case InstructionKey.load:
          _load(
            rSource: decodedInstruction.args[0],
            rDestination: decodedInstruction.args[1],
            offset: int.parse(decodedInstruction.args[2]),
          );
          break;
        case InstructionKey.store:
          _store(
            rSource: decodedInstruction.args[0],
            rDestination: decodedInstruction.args[1],
            offset: int.parse(decodedInstruction.args[2]),
          );
          break;
        case InstructionKey.jmp:
          _jmp(
            rDestination: decodedInstruction.args[0],
            offset: int.parse(decodedInstruction.args[1]),
          );
          break;
        case InstructionKey.halt:
          _halt();
          break;
        default:
          throw UnsupportedInstructionException();
      }
    }
    return '====================================================';
  }

  // CPU Functions

  void _add({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    registers[rResult] = registers[rOne]! + registers[rTwo]!;
  }

  void _sub({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    registers[rResult] = registers[rOne]! - registers[rTwo]!;
  }

  void _mul({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    registers[rResult] = registers[rOne]! * registers[rTwo]!;
  }

  void _div({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    registers[rResult] = registers[rOne]! ~/ registers[rTwo]!;
  }

  void _inc({required String r}) {
    registers[r] = registers[r]! + 1;
  }

  void _dec({required String r}) {
    registers[r] = registers[r]! - 1;
  }

  void _cmp({
    required String op,
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    switch (op) {
      case OperatorKey.lessThan:
        registers[rResult] = registers[rOne]! < registers[rTwo]!;
        break;
      case OperatorKey.greaterThan:
        registers[rResult] = registers[rOne]! > registers[rTwo]!;
        break;
      case OperatorKey.lessThanOrEqual:
        registers[rResult] = registers[rOne]! <= registers[rTwo]!;
        break;
      case OperatorKey.greaterThanOrEqual:
        registers[rResult] = registers[rOne]! >= registers[rTwo]!;
        break;
      case OperatorKey.equal:
        registers[rResult] = registers[rOne]! == registers[rTwo]!;
        break;
      case OperatorKey.notEqual:
        registers[rResult] = registers[rOne]! != registers[rTwo]!;
        break;
      default:
        throw UnsupportedOperatorException();
    }
  }

  void _const({
    required dynamic value,
    required String rResult,
  }) {
    registers[rResult] = value;
  }

  void _load({
    required String rSource,
    required String rDestination,
    required int offset,
  }) {
    registers[rDestination] = memory[registers[rSource]! + offset];
  }

  void _store({
    required String rSource,
    required String rDestination,
    required int offset,
  }) {
    memory[registers[rSource]! + offset] = registers[rDestination];
  }

  void _jmp({
    required String rDestination,
    required int offset,
  }) {
    registers[RegisterKey.ip] = registers[rDestination]! + offset;
  }

  void _halt() {
    print('Program finished');
  }
}
