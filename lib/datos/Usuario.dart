
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {

  /// Esta clase contiene campos/atributos estaticos que permiten al programa almacenar
  /// los datos del usuario una vez que este ha iniciado sesion satisfactoriamente.

  static String? numero = null;

  static String? nombre = null;

  static String? apellidoPaterno = null;

  static String? apellidoMaterno = null;

  static DateTime? fechaNacimiento = null;

  static DocumentReference? carrera = null;

  static DocumentReference? rol = null;

  static Image? imagenPerfil = null;


}