/*
Instructions

('ADD', 'Ra', 'Rb', 'Rc')
('SUB', 'Ra', 'Rb', 'Rc')
('MUL', 'Ra', 'Rb', 'Rc')
('DIV', 'Ra', 'Rb', 'Rc')
('INC', 'Ra')
('DEC', 'Ra')
('CMP', 'op', 'Ra', 'Rb', 'Rc') // op= {<, >, <=, >=, ==, !=}
('CONST', value, 'Ra')
// Rs es el Stack Pointer
('LOAD', 'Rs', 'Rd', offset) // Simulating RAM
('STORE', 'Rs', 'Rd', offset) // Simulating RAM
('JMP', 'Rd', offset) // Move IP to a memory direction
('HALT')
*/

class CPU {
  // Work registers
  Map<String, dynamic> registers = {
    'IP': 0,
    'SP': 0,
    'Ra': 0,
    'Rb': 0,
    'Rc': 0,
    'Rd': 0,
  };
  // RAM memory
  List<int?> ram = List.filled(1024, null);

  String run(List<String> program) {
    return 'Program executed';
  }

  // CPU Functions
}
