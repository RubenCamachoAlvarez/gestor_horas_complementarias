
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/helpers/OperacionesArchivos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';

class Encargado extends Usuario {

  Encargado(String numero, String nombre, String apellidoPaterno,
      String apellidoMaterno, DateTime fechaNacimiento,
      DocumentReference<Map<String, dynamic>> carrera) {

    this.numero = numero;

    this.nombre = nombre;

    this.apellidoPaterno = apellidoPaterno;

    this.apellidoMaterno = apellidoMaterno;

    this.fechaNacimiento = fechaNacimiento;

    this.carrera = carrera;

    rol = Roles.ENCARGADO;

  }

  void cargarEstudiantes() async {

    List<String>? datosEstudiantes = await OperacionesArchivos.leerArchivoCSV();

    if(datosEstudiantes != null) {

      CollectionReference<Map<String, dynamic>> coleccionUsuario = BaseDeDatos.conexion.collection("Usuarios");

      for(String informacionEstudiantes in datosEstudiantes) {

        List<String> camposEstudiante = informacionEstudiantes.split(",");

        DocumentReference<Map<String, dynamic>> referenciaDocumento = coleccionUsuario.doc(camposEstudiante[0]);

        DocumentSnapshot consultaDocumento = await referenciaDocumento.get();

        if(!consultaDocumento.exists) {

          List<String> camposFechaNacimiento = camposEstudiante[4].split("/");

          referenciaDocumento.set({

            "carrera" : carrera,

            "datos_personales" : {

              "nombre" : camposEstudiante[1],

              "apellido_paterno" : camposEstudiante[2],

              "apellido_materno" : camposEstudiante[3],

              "fecha_nacimiento" : Timestamp.fromDate(DateTime(int.parse(camposFechaNacimiento[2]), int.parse(camposFechaNacimiento[1]), int.parse(camposFechaNacimiento[0]))),

            },

            "rol" : Roles.ESTUDIANTE,

          });

        }

      }

    }

  }

}