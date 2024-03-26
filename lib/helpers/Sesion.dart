
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class Sesion {

  static Future<bool> iniciarSesion(String numero, String password) async {

      DocumentReference<Map<String, dynamic>>? documento = BaseDeDatos.conexion.collection("Usuarios").doc(numero);

      DocumentSnapshot<Map<String, dynamic>>? datos = await documento.get();

      if(datos != null && datos.exists) {

        Map<String, dynamic> datosPersonales = datos.get("datos_personales");

        Usuario.numero = numero;

        Usuario.nombre = datosPersonales["nombre"];

        Usuario.apellidoPaterno = datosPersonales["apellido_paterno"];

        Usuario.apellidoMaterno = datosPersonales["apellido_materno"];

        Usuario.fechaNacimiento = (datosPersonales["fecha_nacimiento"] as Timestamp).toDate();

        Usuario.carrera = datos["carrera"];

        Usuario.rol = datos["rol"];

      }

      return true;

  }

  static bool cerrarSesion(){

    if(Usuario.numero != null) {

      Usuario.numero = null;

      Usuario.nombre = null;

      Usuario.apellidoPaterno = null;

      Usuario.apellidoMaterno = null;

      Usuario.fechaNacimiento = null;

      return true;

    }

    return false;

  }


}