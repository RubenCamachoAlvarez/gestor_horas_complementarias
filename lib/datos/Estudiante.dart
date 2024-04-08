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
  bool operator ==(Object other) {
    return identical(this, other) || (other is Estudiante &&

        runtimeType == other.runtimeType && numero == other.numero &&

        nombre == other.nombre && apellidoPaterno == other.apellidoPaterno &&

        apellidoMaterno == other.apellidoMaterno &&

        fechaNacimiento!.year == other.fechaNacimiento!.year &&

        fechaNacimiento!.month == other.fechaNacimiento!.month &&

        fechaNacimiento!.day == other.fechaNacimiento!.day);
  }

  @override
  int get hashCode =>
      nombre!.length ^ apellidoPaterno!.length ^ apellidoMaterno!.length ^

      fechaNacimiento!.year ^ fechaNacimiento!.month ^ fechaNacimiento!.day;

  @override
  String toString() {
    return "[$numero, $nombre, $apellidoPaterno, $apellidoMaterno : ${fechaNacimiento!
        .day}/${fechaNacimiento!.month}/${fechaNacimiento!.year}]";
  }

  Future<bool?> cargarComprobante() async {
    Map<String, dynamic>? datosComprobante = await OperacionesArchivos
        .seleccionarComprobantePDF();

    if (datosComprobante != null) {

      try {
        await BaseDeDatos.almacenamiento.ref().child(
            "Comprobantes_estudiantes/$numero/${datosComprobante["nombre"]}").
        putData(datosComprobante["bytes"],
            SettableMetadata(contentType: "application/pdf"));

        await BaseDeDatos.conexion.collection("Comprobantes").add({

          "nombre": datosComprobante["nombre"],

          "fecha_subida": datosComprobante["fecha_subida"],

          "propietario": BaseDeDatos.conexion.collection("Usuarios").doc(
              numero),

          "status_comprobante": StatusComprobante.PENDIENTE,

          "horas_validez": 0
        });

        return true;
      } catch (e) {
        return false;
      }
    }

    return null;
  }

  Future<int> calcularHorasProgreso() async {

    int horasTotales = 0;

    CollectionReference<Map<String, dynamic>> coleccionComprobante = BaseDeDatos.conexion.collection(
        "Comprobantes");

    QuerySnapshot<Map<String, dynamic>> consultaDocumentos = await coleccionComprobante.get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documentos = consultaDocumentos.docs;


    documentos.forEach((documento) {

      //Casteo opcional = (documento.get("propietario") as DocumentReference)
      if ((documento.data()["propietario"]) ==
          BaseDeDatos.conexion.collection("Usuarios").doc(numero)) {
        if (documento.data()["status_comprobante"] ==
            BaseDeDatos.conexion.collection("Status_Comprobante").doc(
                "Aceptado")) {
          horasTotales += (documento.data()["horas_validez"] as int);
        }
      }
    });

    return horasTotales;
  }

  Future<double> calcularPorcentajeAvance() async {
    DocumentSnapshot<Map<String, dynamic>> documento = await carrera!.get();

    int horasTotales = documento.data()?["horas_obligatorias"];

    int horasAvance = await calcularHorasProgreso();

    double porcentajeAvance = horasAvance * 100.0 / horasTotales;

    return porcentajeAvance;
  }

  Future<Set<Comprobante>> obtenerComprobantes() async {

    Set<Comprobante> comprobantesEstudiante = <Comprobante>{};

    CollectionReference<Map<String, dynamic>> referenciaColeccionComprobantes = BaseDeDatos.conexion.collection("Comprobantes");

    QuerySnapshot<Map<String,dynamic>> consultaDocumentos = await referenciaColeccionComprobantes.get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> listaComprobantes = consultaDocumentos.docs;

    for(QueryDocumentSnapshot<Map<String, dynamic>> comprobante in listaComprobantes) {

      try {

        Uint8List? bytes = await BaseDeDatos.almacenamiento.ref().child("Comprobantes_estudiantes/$numero/${comprobante.data()["nombre"]}").getData();

        if(bytes != null) {

          final nombre = comprobante.data()["nombre"];

          final propietario = comprobante.data()["propietario"];

          final fechaSubida = comprobante.data()["fecha_subida"];

          final statusComprobante = comprobante.data()["status_comprobante"];

          final horasValidez = comprobante.data()["horas_validez"];

          comprobantesEstudiante.add(

              Comprobante(nombre: nombre, bytes: bytes, propietario: propietario, fechaSubida: fechaSubida, statusComprobante: statusComprobante, horasValidez: horasValidez)

          );

        }

      }catch(e) {

        print("No se pudo descargar el archivo");

        print("Error $e");

        print("---------------------------------------------------------------------------");

      }

    }

    return comprobantesEstudiante;

  }

  Future<Set<Comprobante>> obtenerComprobantesPendientes()  async {

    Set<Comprobante> comprobantesPendientes = <Comprobante>{};

    Set<Comprobante> comprobantesEstudiante = await obtenerComprobantes();

    for(Comprobante comprobante in comprobantesEstudiante) {

      if(comprobante.statusComprobante == StatusComprobante.PENDIENTE) {

        comprobantesPendientes.add(comprobante);

      }

    }

    return comprobantesPendientes;

  }

  Future<Set<Comprobante>> obtenerComprobantesRevisados() async {

    Set<Comprobante> comprobantesRevisados = <Comprobante>{};

    Set<Comprobante> comprobantesEstudiante = await obtenerComprobantes();

    for(Comprobante comprobante in comprobantesEstudiante) {

      if(comprobante.statusComprobante != StatusComprobante.PENDIENTE) {

        comprobantesRevisados.add(comprobante);

      }

    }

    return comprobantesRevisados;

  }

}