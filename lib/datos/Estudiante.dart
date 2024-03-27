
import 'dart:ui';

class Estudiante {

  Estudiante({required this.numeroCuenta, required this.nombre, required this.apellidoPaterno, required this.apellidoMaterno, required this.fechaNacimiento, this.fotoPerfil});

  String numeroCuenta;

  String nombre;

  String apellidoPaterno;

  String apellidoMaterno;

  DateTime fechaNacimiento;

  Image? fotoPerfil;

  @override

  bool operator==(Object other) {

    return identical(this, other) || (other is Estudiante &&

      runtimeType == other.runtimeType && numeroCuenta == other.numeroCuenta &&

        nombre == other.nombre && apellidoPaterno == other.apellidoPaterno &&

          apellidoMaterno == other.apellidoMaterno &&

            fechaNacimiento.year == other.fechaNacimiento.year &&

              fechaNacimiento.month == other.fechaNacimiento.month &&

                fechaNacimiento.day == other.fechaNacimiento.day);
  }

  @override
  int get hashCode => nombre.length ^ apellidoPaterno.length ^ apellidoMaterno.length ^

    fechaNacimiento.year ^ fechaNacimiento.month ^ fechaNacimiento.day;

  @override
  String toString() {

    return "[$numeroCuenta, $nombre, $apellidoPaterno, $apellidoMaterno : ${fechaNacimiento.day}/${fechaNacimiento.month}/${fechaNacimiento.year}]";

  }

}