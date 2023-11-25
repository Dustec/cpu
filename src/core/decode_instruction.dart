DecodeInstructionResult decodeInstruction(String instruction) {
  final List<String> parts = instruction.split(' ');
  final List<String> args = parts.sublist(1);
  return DecodeInstructionResult(parts[0], args);
}

class DecodeInstructionResult {
  DecodeInstructionResult(this.instruction, this.args);

  final String instruction;
  final List<String> args;
}
