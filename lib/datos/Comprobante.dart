import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comprobante {

  Comprobante({required this.nombre, required this.bytes, required this.propietario, required this.fechaSubida,

    required this.statusComprobante, required this.horasValidez});

  String nombre;

  Uint8List bytes;

  DocumentReference<Map<String, dynamic>> propietario;

  Timestamp fechaSubida;

  DocumentReference statusComprobante;

  double horasValidez;

  @override
  String toString() {

    return "{$nombre, ${propietario.id}, $fechaSubida, ${statusComprobante.id}, $horasValidez";

  }

  @override
  bool operator==(Object other) {

    return identical(this, other) || (other is Comprobante &&

    runtimeType == other.runtimeType && nombre == other.nombre);

  }

  @override
  int get hashCode => super.hashCode & nombre!.length & bytes.hashCode;


}