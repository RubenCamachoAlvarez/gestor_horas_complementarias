
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class Sesion {

  static Usuario usuario = Usuario();

  static Future<bool> iniciarSesion(String numero, String password) async {

      DocumentReference<Map<String, dynamic>>? documento = BaseDeDatos.conexion.collection("Usuarios").doc(numero);

      DocumentSnapshot<Map<String, dynamic>>? datos = await documento.get();

      if(datos.exists) {

        Map<String, dynamic> datosPersonales = datos.get("datos_personales");

        usuario.numero = numero;

        usuario.nombre = datosPersonales["nombre"];

        usuario.apellidoPaterno = datosPersonales["apellido_paterno"];

        usuario.apellidoMaterno = datosPersonales["apellido_materno"];

        usuario.fechaNacimiento = (datosPersonales["fecha_nacimiento"] as Timestamp).toDate();

        usuario.carrera = datos["carrera"];

        usuario.rol = datos["rol"];

      }

      return true;

  }

  static bool cerrarSesion(){

    if(usuario.numero != null) {

      usuario.numero = null;

      usuario.nombre = null;

      usuario.apellidoPaterno = null;

      usuario.apellidoMaterno = null;

      usuario.fechaNacimiento = null;

      return true;

    }

    return false;

  }


}