import 'dart:js_interop_unsafe';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/helpers/OperacionesArchivos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';
import 'package:http/http.dart' as http;


class Estudiante extends Usuario{

  Estudiante(String numero, String nombre, String apellidoPaterno,
      String apellidoMaterno, DateTime fechaNacimiento,
      DocumentReference<Map<String, dynamic>> carrera) {

    this.numero = numero;

    this.nombre = nombre;

    this.apellidoPaterno = apellidoPaterno;

    this.apellidoMaterno = apellidoMaterno;

    this.fechaNacimiento = fechaNacimiento;

    this.carrera = carrera;

    rol = Roles.ESTUDIANTE;

  }

  @override

  bool operator==(Object other) {

    return identical(this, other) || (other is Estudiante &&

      runtimeType == other.runtimeType && numero == other.numero &&

        nombre == other.nombre && apellidoPaterno == other.apellidoPaterno &&

          apellidoMaterno == other.apellidoMaterno &&

            fechaNacimiento!.year == other.fechaNacimiento!.year &&

              fechaNacimiento!.month == other.fechaNacimiento!.month &&

                fechaNacimiento!.day == other.fechaNacimiento!.day);
  }

  @override
  int get hashCode => nombre!.length ^ apellidoPaterno!.length ^ apellidoMaterno!.length ^

    fechaNacimiento!.year ^ fechaNacimiento!.month ^ fechaNacimiento!.day;

  @override
  String toString() {

    return "[$numero, $nombre, $apellidoPaterno, $apellidoMaterno : ${fechaNacimiento!.day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}]";

  }

  Future<bool?> cargarComprobante() async {

    Map<String, dynamic>? datosComprobante = await OperacionesArchivos.seleccionarComprobantePDF();

    if(datosComprobante != null) {

      print("INICIANDO SUBIDA DE COMPROBANTE");

      try {

        await BaseDeDatos.almacenamiento.ref().child("Comprobantes_estudiantes/$numero/${datosComprobante["nombre"]}").

          putData(datosComprobante["bytes"], SettableMetadata(contentType: "application/pdf"));

        await BaseDeDatos.conexion.collection("Comprobantes").add({

          "nombre" : datosComprobante["nombre"],

          "fecha_subida" : datosComprobante["fecha_subida"],

          "propietario" : BaseDeDatos.conexion.collection("Usuarios").doc(numero),

          "status_comprobante" : StatusComprobante.PENDIENTE,

          "horas_validez" : 0

        });

        print("TERMINADA LA SUBIDA DEL COMPROBANTE");

        return true;

      } catch(e) {

        return false;

      }

    }

    return null;

  }

  Future<int> calcularHorasProgreso() async {

    int horasTotales = 0;

    CollectionReference coleccionComprobante = BaseDeDatos.conexion.collection("Comprobantes");

    QuerySnapshot consultaDocumentos = await coleccionComprobante.get();

    List<QueryDocumentSnapshot> documentos = consultaDocumentos.docs;

    documentos.forEach((documento) {

      //Casteo opcional = (documento.get("propietario") as DocumentReference)
      if((documento.get("propietario")) == BaseDeDatos.conexion.collection("Usuarios").doc(numero)) {

        if(documento.get("status_comprobante") == BaseDeDatos.conexion.collection("Status_Comprobante").doc("Aceptado")) {

          horasTotales += (documento.get("horas_validez") as double).toInt();

        }

      }

    });

    return horasTotales;

  }

  Future<double> calcularPorcentajeAvance() async {

    DocumentSnapshot<Map<String, dynamic>> documento = await carrera!.get();

    double horasTotales = documento.get("horas_obligatorias");

    int horasAvance = await calcularHorasProgreso();

    double porcentajeAvance = horasAvance * 100.0 / horasTotales;

    return porcentajeAvance;

  }

  Future<List<int>> cargarComprobantes() async {

    List<int> comprobantes = [1,2];

    return comprobantes;

  }

}