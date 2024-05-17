
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/datos/Encargado.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class Sesion {

  static Usuario? usuario;

  static Future<bool> iniciarSesion(String numero, String password) async {

      DocumentReference<Map<String, dynamic>>? documento = BaseDeDatos.conexion.collection("Usuarios").doc(numero);

      DocumentSnapshot<Map<String, dynamic>>? datos = await documento.get();

      if(datos.exists) {

        Map<String, dynamic> datosPersonales = datos.data()!["datos_personales"];

        DateTime fechaNacimiento = (datosPersonales["fecha_nacimiento"] as Timestamp).toDate();

        String cadenaFechaNacimiento = "${fechaNacimiento.day}${fechaNacimiento.month}${fechaNacimiento.year}";

        print(cadenaFechaNacimiento);

        if(password == cadenaFechaNacimiento){

          if((datos["rol"] as DocumentReference<Map<String, dynamic>>).id == "Encargado"){

            print("Logueado como Encargado");

            usuario = Encargado(numero, datosPersonales["nombre"], datosPersonales["apellido_paterno"], datosPersonales["apellido_materno"],
                (datosPersonales["fecha_nacimiento"] as Timestamp).toDate(), datos["carrera"]);

          }else{

            print("Logueado como estudiante");

            usuario = Estudiante(numero, datosPersonales["nombre"], datosPersonales["apellido_paterno"], datosPersonales["apellido_materno"],
                (datosPersonales["fecha_nacimiento"] as Timestamp).toDate(), datos["carrera"]);

          }

          usuario!.rol = datos["rol"];

          return true;

        }

      }

      return false;

  }

  static bool cerrarSesion(){

    if(usuario != null) {

      usuario = null;

      return true;

    }

    return false;

  }

}