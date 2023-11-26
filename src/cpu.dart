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
    print('===== Program init =====');
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
    return '===== Program end =====';
  }

  // CPU Functions

  void _add({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    final dynamic x = registers[rOne];
    final dynamic y = registers[rTwo];
    final dynamic result =
        (double.tryParse(x) ?? 0.0) + (double.tryParse(y) ?? 0.0);
    registers[rResult] = result;
    print(
      '${InstructionKey.add} ${rOne}: ${x} + ${rTwo}: ${y} = ${result} saved in ${rResult}',
    );
  }

  void _sub({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    final dynamic x = registers[rOne];
    final dynamic y = registers[rTwo];
    final dynamic result =
        (double.tryParse(x) ?? 0.0) - (double.tryParse(y) ?? 0.0);
    registers[rResult] = result;
    print(
      '${InstructionKey.sub} ${rOne}: ${x} - ${rTwo}: ${y} = ${result} saved in ${rResult}',
    );
  }

  void _mul({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    final dynamic x = registers[rOne];
    final dynamic y = registers[rTwo];
    final dynamic result =
        (double.tryParse(x) ?? 0.0) * (double.tryParse(y) ?? 0.0);
    registers[rResult] = result;
    print(
      '${InstructionKey.mul} ${rOne}: ${x} * ${rTwo}: ${y} = ${result} saved in ${rResult}',
    );
  }

  void _div({
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    final dynamic x = registers[rOne];
    final dynamic y = registers[rTwo];
    final dynamic result =
        (double.tryParse(x) ?? 0.0) / (double.tryParse(y) ?? 0.0);
    registers[rResult] = result;
    print(
      '${InstructionKey.div} ${rOne}: ${x} / ${rTwo}: ${y} = ${result} saved in ${rResult}',
    );
  }

  void _inc({required String r}) {
    final dynamic x = registers[r];
    final dynamic result = (double.tryParse(x) ?? 0.0) + 1;
    registers[r] = result;
    print(
      '${InstructionKey.inc} ${r}: ${result}',
    );
  }

  void _dec({required String r}) {
    final dynamic x = registers[r];
    final dynamic result = (double.tryParse(x) ?? 0.0) - 1;
    registers[r] = result;
    print(
      '${InstructionKey.dec} ${r}: ${result}',
    );
  }

  void _cmp({
    required String op,
    required String rOne,
    required String rTwo,
    required String rResult,
  }) {
    final dynamic x = registers[rOne];
    final dynamic y = registers[rTwo];
    dynamic result;

    switch (op) {
      case OperatorKey.lessThan:
        result = x < y;
        break;
      case OperatorKey.greaterThan:
        result = x > y;
        break;
      case OperatorKey.lessThanOrEqual:
        result = x <= y;
        break;
      case OperatorKey.greaterThanOrEqual:
        result = x >= y;
        break;
      case OperatorKey.equal:
        result = x == y;
        break;
      case OperatorKey.notEqual:
        result = x != y;
        break;
      default:
        throw UnsupportedOperatorException();
    }

    registers[rResult] = result;
    print(
      '${InstructionKey.cmp} ${rOne}: ${x} ${op} ${rTwo}: ${y} = ${result} saved in ${rResult}',
    );
  }

  void _const({
    required dynamic value,
    required String rResult,
  }) {
    registers[rResult] = value;
    print(
      '${InstructionKey.constKey} ${value} saved in ${rResult}',
    );
  }

  void _load({
    required String rSource,
    required String rDestination,
    required int offset,
  }) {
    final int? value = memory[registers[rSource]! + offset];

    registers[rDestination] = value;
    print(
      '${InstructionKey.load} ${rSource} + ${offset} = $value saved in ${rDestination}',
    );
    print(memory);
  }

  void _store({
    required String rSource,
    required String rDestination,
    required int offset,
  }) {
    memory[registers[rSource]! + offset] = registers[rDestination];
    print(
      '${InstructionKey.store} ${rSource} + ${offset} = ${registers[rDestination]} saved in ${rDestination}',
    );
  }

  void _jmp({
    required String rDestination,
    required int offset,
  }) {
    registers[RegisterKey.ip] = registers[rDestination]! + offset;
    print(
      '${InstructionKey.jmp} ${rDestination} + ${offset} = ${registers[RegisterKey.ip]}',
    );
  }

  void _halt() {
    print('${InstructionKey.halt}');
  }
}
