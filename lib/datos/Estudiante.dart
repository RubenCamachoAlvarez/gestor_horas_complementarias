import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/helpers/OperacionesArchivos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';

class Estudiante extends Usuario {

  Estudiante(String numero, String nombre, String apellidoPaterno, String apellidoMaterno, DateTime fechaNacimiento, DocumentReference<Map<String, dynamic>> carrera) : super(numero: numero, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, fechaNacimiento: fechaNacimiento, carrera: carrera) {

    rol = Roles.ESTUDIANTE;

  }

  @override
  bool operator ==(Object other) {

    return identical(this, other) || (other is Estudiante && runtimeType == other.runtimeType && numero == other.numero && nombre == other.nombre && apellidoPaterno == other.apellidoPaterno && apellidoMaterno == other.apellidoMaterno &&
        fechaNacimiento.year == other.fechaNacimiento.year && fechaNacimiento.month == other.fechaNacimiento.month && fechaNacimiento.day == other.fechaNacimiento.day);

  }

  @override
  int get hashCode => nombre.length ^ apellidoPaterno.length ^ apellidoMaterno.length ^ fechaNacimiento.year ^ fechaNacimiento.month ^ fechaNacimiento.day;

  @override
  String toString() {

    return "[$numero, $nombre, $apellidoPaterno, $apellidoMaterno : ${fechaNacimiento.day}/${fechaNacimiento.month}/${fechaNacimiento.year}]";

  }

  Future<bool?> cargarComprobante(Map<String, dynamic>? datosComprobante) async {

    if (datosComprobante != null) {

      try {

        await BaseDeDatos.almacenamiento.ref().child("Comprobantes_estudiantes/$numero/${datosComprobante["nombre"]}").putData(datosComprobante["bytes"], SettableMetadata(contentType: "application/pdf"));

        await BaseDeDatos.conexion.collection("Comprobantes").add({

          "nombre": datosComprobante["nombre"],

          "fecha_subida": datosComprobante["fecha_subida"],

          "propietario": BaseDeDatos.conexion.collection("Usuarios").doc(numero),

          "status_comprobante": StatusComprobante.PENDIENTE,

        });

        return true;

      } catch (e) {

        return false;

      }

    }

    return null;

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> obtenerComprobantesAceptados() {

    return BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: referenciaUsuario).where("status_comprobante", isEqualTo: StatusComprobante.ACEPTADO).snapshots();

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> obtenerComprobantesRechazados() {

    return BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: referenciaUsuario).where("status_comprobante", isEqualTo: StatusComprobante.RECHAZADO).snapshots();

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> obtenerComprobantesPendientes() {

    return BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: referenciaUsuario).where("status_comprobante", isEqualTo: StatusComprobante.PENDIENTE).snapshots();

  }

  Future<Comprobante?> descargarComprobante(String nombre) async{

    Comprobante? comprobante;

    QuerySnapshot<Map<String, dynamic>> conexionDocumento = await BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: referenciaUsuario).where("nombre", isEqualTo: nombre).get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> consultaDocumento = conexionDocumento.docs;

    if(consultaDocumento.elementAt(0).exists) {

      Map<String, dynamic> datos = consultaDocumento.elementAt(0).data();
      
      Uint8List? bytesDocumento = await BaseDeDatos.almacenamiento.ref().child("Comprobantes_estudiantes/$numero/$nombre").getData();

      if(bytesDocumento != null) {

        comprobante = Comprobante(nombre: datos["nombre"], bytes: bytesDocumento, estudiantePropietario: this, fechaSubida: datos["fecha_subida"], statusComprobante: datos["status_comprobante"]);

        if(comprobante.statusComprobante == StatusComprobante.ACEPTADO) {

          comprobante.horasValidez = datos["horas_validez"];

        }else if(comprobante.statusComprobante == StatusComprobante.RECHAZADO) {

          DocumentReference<Map<String, dynamic>> referenciaJustificacion = datos["justificacion_rechazo"];

          comprobante.justificacionRechazo = (await referenciaJustificacion.get()).data()!["mensaje_justificacion"];

        }

      }

    }

    return comprobante;

  }

}