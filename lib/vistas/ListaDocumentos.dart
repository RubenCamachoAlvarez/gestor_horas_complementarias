
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'dart:async';

class ListaDocumentosWidget extends StatefulWidget {

  const ListaDocumentosWidget({super.key});

  @override
  State<ListaDocumentosWidget> createState() => ListaDocumentosState();

}

class ListaDocumentosState extends State<ListaDocumentosWidget> {

  //late Future<String> _future;

  //Future<List<Comprobante>>? _future;

  late Future<List<int>> _future;

  /*Future<String> realizarTareaAsincrona() async {
    // Simula una tarea asincrónica esperando 3 segundos
    await Future.delayed(Duration(seconds: 5));
    // Devuelve un resultado después de que la tarea se haya completado
    return 'Resultado de la tarea';
  }*/

  Future<List<int>> realizarTareaAsincrona() async {

    await Future.delayed(Duration(seconds: 3));

    Future<List<int>> lista = (Sesion.usuario as Estudiante).cargarComprobantes();

    return lista;

  }


  @override
  void initState() {
    super.initState();
    _future = realizarTareaAsincrona();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text('Tarea completada: ${(snapshot.data as List).length}');
          } else {
            return Text('Error: No se pudo completar la tarea');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }




}