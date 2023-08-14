import 'dart:io';

class Persona {
  int estadoCivil; // 1: soltero, 2: casado
  int edad;
  int genero; // 1: hombre, 2: mujer

  Persona(this.estadoCivil, this.edad, this.genero);
}

List<Persona> ingresarPacientes() {
  List<Persona> pacientes = [];

  stdout.write("Ingrese la cantidad de pacientes: ");
  int cantidadPacientes = int.parse(stdin.readLineSync()!);

  for (int i = 0; i < cantidadPacientes; i++) {
    print("Ingrese los datos del paciente ${i + 1}:");
    stdout.write("Estado civil (1: soltero, 2: casado): ");
    int estadoCivil = int.parse(stdin.readLineSync()!);
    stdout.write("Edad: ");
    int edad = int.parse(stdin.readLineSync()!);
    stdout.write("Género (1: hombre, 2: mujer): ");
    int genero = int.parse(stdin.readLineSync()!);

    pacientes.add(Persona(estadoCivil, edad, genero));
  }

  return pacientes;
}

void calcularPorcentajes(List<Persona> pacientes) {
  int totalHombres = pacientes.where((p) => p.genero == 1).length;
  int totalHombresSolteros =
      pacientes.where((p) => p.genero == 1 && p.estadoCivil == 1).length;
  double porcentajeHombresSolteros =
      (totalHombresSolteros / totalHombres) * 100;

  int totalHombresCasados =
      pacientes.where((p) => p.genero == 1 && p.estadoCivil == 2).length;
  int sumaEdadHombresCasados = pacientes
      .where((p) => p.genero == 1 && p.estadoCivil == 2)
      .fold(0, (sum, p) => sum + p.edad);
  double edadPromedioHombresCasados = totalHombresCasados > 0
      ? sumaEdadHombresCasados / totalHombresCasados
      : 0;

  int totalSolteras =
      pacientes.where((p) => p.estadoCivil == 1 && p.genero == 2).length;
  double porcentajeMujeresSolteras = (totalSolteras / pacientes.length) * 100;

  print(
      "Porcentaje de hombres solteros que han asistido: ${porcentajeHombresSolteros.toStringAsFixed(2)}%");
  print(
      "Edad promedio de hombres casados: ${edadPromedioHombresCasados.toStringAsFixed(2)} años");
  print(
      "Porcentaje de mujeres solteras: ${porcentajeMujeresSolteras.toStringAsFixed(2)}%");
}

void main() {
  List<Persona> pacientes = ingresarPacientes();

  if (pacientes.isNotEmpty) {
    calcularPorcentajes(pacientes);
  } else {
    print("No se ingresaron pacientes.");
  }
}
