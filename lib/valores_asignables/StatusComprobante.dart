
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class StatusComprobante {

  static final ACEPTADO = BaseDeDatos.conexion.collection("Status_Comprobante").doc("Aceptado");

  static final PENDIENTE = BaseDeDatos.conexion.collection("Status_Comprobante").doc("Pendiente");

  static final RECHAZADO = BaseDeDatos.conexion.collection("Status_Comprobante").doc("Rechazado");

}