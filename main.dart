import 'src/cpu.dart';

void main() {
  final CPU machine = CPU();
  final List<String> program = [
    'CONST Ra 10',
    'CONST Rb 20',
    'ADD Ra Rb Rc',
    'HALT',
  ];

  print(machine.run(program));
}
