import 'cpu.dart';

void main() {
  final CPU machine = CPU();
  final List<String> program = [
    'CONST 10 Ra',
    'CONST 20 Rb',
    'ADD Ra Rb Rc',
    'HALT',
  ];

  print(machine.run(program));
}
