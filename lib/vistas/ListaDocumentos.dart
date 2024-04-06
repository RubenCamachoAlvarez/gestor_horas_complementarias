
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

  late Future<Set<Comprobante>> comprobantes;

  @override
  void initState() {

    super.initState();

    comprobantes = (Sesion.usuario as Estudiante).obtenerComprobantesPendientes();

  }


  @override
  Widget build(BuildContext contexto) {

    return FutureBuilder(

        future: comprobantes,

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasData && snapshot.data != null) {

              print(snapshot.data!.length);

              return Text("Datos capturados correctamente");

            }else if(snapshot.hasError) {

              return Text("Error esperando los datos");

            }

          }

          print("Esperando");

          return Container(

            child:

              CircularProgressIndicator()

          );

        },);

  }

}