
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {

  /// Esta clase contiene campos/atributos estaticos que permiten al programa almacenar
  /// los datos del usuario una vez que este ha iniciado sesion satisfactoriamente.

  String? numero;

  String? nombre;

  String? apellidoPaterno;

  String? apellidoMaterno;

  DateTime? fechaNacimiento;

  Image? imagenPerfil;

  DocumentReference<Map<String, dynamic>>? carrera;

  DocumentReference<Map<String, dynamic>>? rol;


}