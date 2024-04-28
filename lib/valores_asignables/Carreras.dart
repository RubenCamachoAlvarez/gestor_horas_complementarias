
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

abstract class Carreras {

  static final INGENIERIA_EN_COMPUTACION = BaseDeDatos.conexion.collection("Carreras").doc("Ingenieria en computacion");

  static final INGENIERIA_ELECTICA_ELECTRONIA = BaseDeDatos.conexion.collection("Carreras").doc("Ingenieria electrica electronica");

  static final INGENIERIA_MECANICA = BaseDeDatos.conexion.collection("Carreras").doc("Ingenieria mecanica");

  static Future<int> obtenerNumeroHorasObligatorias(DocumentReference<Map<String, dynamic>> documentoCarrera) async {

    DocumentSnapshot<Map<String, dynamic>?>  consultaDocumento = await documentoCarrera.get();

    if(documentoCarrera.parent == BaseDeDatos.conexion.collection("Carreras")) {

      return (consultaDocumento.data()!["horas_obligatorias"] as int);

    }

    return 0;

  }

}