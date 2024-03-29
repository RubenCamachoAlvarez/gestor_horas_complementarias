import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class Comprobante {

  Comprobante({required this.nombre, required this.bytes, required this.propietario, required this.fechaSubida,

    required this.statusComprobante});

  String nombre;

  Uint8List bytes;

  DocumentReference<Map<String, dynamic>> propietario;

  Timestamp fechaSubida;

  DocumentReference statusComprobante;

}