# CPU Simulator

En el archivo 'cpu.dart' encontrarás el esqueleto para la clase CPU que simulará el funcionamiento de un CPU real. El funcionamiento del CPU es el siguiente:

- Recibe un programa que se ejecutará en el CPU.
- El CPU tiene 8 Registros generales: Ra, Rb, Rc, Rd, Re, Rf, Rg, Rh. (También los puedes nombrar R1..R8).
- Tenemos disponible una memoria RAM simulada, puede ser del tamaño que quieras, en el archivo cpu.dart se simula como un arreglo de 1024 posiciones.
- Las regla principal para simular CPU es que todo dato con el que trabaje debe estar en los registros. Cuando ya no podamos mantener más datos en los registros, debemos guardarlos en la memoria RAM.
- El CPU tiene dos registros especiales: IP y SP. IP es el registro de la siguiente instrucción a ejecutar y SP es el registro que apunta al tope de la pila.
- El CPU tiene un registro especial llamado IR (Instruction Register) que contiene la instrucción actual que se está ejecutando.
- El CPU tiene un registro especial llamado Flag que contiene el resultado de la última operación aritmética realizada. Si el resultado es 0, el - Flag es 0, si el resultado es negativo, el Flag es -1, si el resultado es positivo, el Flag es 1.