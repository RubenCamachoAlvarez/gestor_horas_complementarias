
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class Roles {

  static final ENCARGADO = BaseDeDatos.conexion.collection("Roles").doc("Encargado");

  static final ESTUDIANTE = BaseDeDatos.conexion.collection("Roles").doc("Estudiante");


}