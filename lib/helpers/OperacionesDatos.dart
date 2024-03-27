import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';

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


}