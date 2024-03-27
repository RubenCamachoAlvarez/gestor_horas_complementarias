
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class Carreras {

  static final INGENIERIA_EN_COMPUTACION = BaseDeDatos.conexion.collection("Carreras").doc("Ingenieria en computacion");

  static final INGENIERIA_ELECTICA_ELECTRONIA = BaseDeDatos.conexion.collection("Carreras").doc("Ingenieria electrica electronica");

  static final INGENIERIA_MECANICA = BaseDeDatos.conexion.collection("Carreras").doc("Ingenieria mecanica");

}