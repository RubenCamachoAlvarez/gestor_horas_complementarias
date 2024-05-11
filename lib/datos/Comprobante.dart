import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';

class Comprobante {

  Comprobante({required this.nombre, required this.bytes, required this.estudiantePropietario, required this.fechaSubida,

    required this.statusComprobante});

  String nombre;

  Uint8List bytes;

  Estudiante estudiantePropietario;

  Timestamp fechaSubida;

  DocumentReference statusComprobante;

  @override
  String toString() {

    return "{$nombre, ${estudiantePropietario.referenciaUsuario.id}, $fechaSubida, ${statusComprobante.id}";

  }

  @override
  bool operator==(Object other) {

    return identical(this, other) || (other is Comprobante &&

    runtimeType == other.runtimeType && nombre == other.nombre);

  }

  @override
  int get hashCode => super.hashCode & nombre!.length & bytes.hashCode;

  String cadenaFechaSubida() {

    DateTime fecha = fechaSubida.toDate();

    return "${fecha.day}/${fecha.month}/${fecha.year}";

  }


}