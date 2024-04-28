import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

abstract class Usuario {

  /// Esta clase contiene campos/atributos estaticos que permiten al programa almacenar
  /// los datos del usuario una vez que este ha iniciado sesion satisfactoriamente.

  String numero;

  String nombre;

  String apellidoPaterno;

  String apellidoMaterno;

  DateTime fechaNacimiento;

  Uint8List? imagenPerfil;

  Uint8List? imagenFondo;

  DocumentReference<Map<String, dynamic>> carrera;

  late DocumentReference<Map<String, dynamic>> rol;

  late DocumentReference<Map<String, dynamic>> referenciaUsuario;

  Usuario({required this.numero, required this.nombre, required this.apellidoPaterno, required this.apellidoMaterno, required this.fechaNacimiento, required this.carrera}) {

    referenciaUsuario = BaseDeDatos.conexion.collection("Usuarios").doc(numero);

  }

  String nombreCompleto() {

    return "$nombre $apellidoPaterno $apellidoMaterno";

  }

  String cadenaFechaNacimiento() {

    return "${fechaNacimiento.day}/${fechaNacimiento.month}/${fechaNacimiento.year}";

  }

}