
import 'dart:ui';

class Estudiante {

  Estudiante({required this.nombre, required this.apellidoPaterno, required this.apellidoMaterno, required this.fechaNacimiento, required this.fotoPerfil});

  String nombre;

  String apellidoPaterno;

  String apellidoMaterno;

  DateTime fechaNacimiento;

  Image? fotoPerfil;

}