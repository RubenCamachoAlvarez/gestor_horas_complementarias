import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/helpers/OperacionesArchivos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';

class OperacionesDatos {

  static void cargarEstudiantes(Set<Estudiante> estudiantes) {

    CollectionReference<Map<String, dynamic>> coleccionUsuario = BaseDeDatos.conexion.collection("Usuarios");

    estudiantes.forEach((estudiante) async {

      DocumentReference<Map<String, dynamic>> referenciaDocumento = coleccionUsuario.doc(estudiante.numeroCuenta);

      if(referenciaDocumento != null) {

        DocumentSnapshot consulta = await referenciaDocumento.get();

        if(!consulta.exists) {

          referenciaDocumento.set({

            "carrera" : Usuario.carrera,

            "datos_personales" : {

              "nombre" : estudiante.nombre,

              "apellido_paterno" : estudiante.apellidoPaterno,

              "apellido_materno" : estudiante.apellidoMaterno,

              "fecha_nacimiento" : Timestamp.fromDate(estudiante.fechaNacimiento),

            },

            "rol" : Roles.ESTUDIANTE,

          });



        }

      }

    });

  }

  static void cargarComprobanteEstudiante() async {

    Comprobante? datosComprobante = await OperacionesArchivos.cargarComprobantePDF();

    if(datosComprobante != null) {

      print("Iniciando suhida de archivo");

      try {

        await BaseDeDatos.almacenamiento.ref().child("archivos_estudiantes/${Usuario.numero}/${datosComprobante.nombre}").

        putData(datosComprobante.bytes, SettableMetadata(contentType: "application/pdf"));

        await BaseDeDatos.conexion.collection("Comprobantes").add({

          "nombre" : datosComprobante.nombre,

          "fecha_subida" : datosComprobante.fechaSubida,

          "propietario" : datosComprobante.propietario,

          "status_comprobante" : StatusComprobante.PENDIENTE

        });

        print("Terminando subida de archivo");

      } catch(e) {}

    }


  }


}