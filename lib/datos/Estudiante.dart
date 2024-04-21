import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  Future<bool?> cargarComprobante() async {

    Map<String, dynamic>? datosComprobante = await OperacionesArchivos.seleccionarComprobantePDF();

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

  @override
  String nombreCompleto() {

    return "$nombre $apellidoPaterno $apellidoMaterno";

  }

}