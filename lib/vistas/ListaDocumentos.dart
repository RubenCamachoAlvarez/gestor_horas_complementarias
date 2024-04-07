
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'dart:async';
import 'dart:html' as html;

class ListaDocumentosWidget extends StatefulWidget {

  ListaDocumentosWidget({super.key});

  Function? obtenerDatos;

  @override
  State<ListaDocumentosWidget> createState() => ListaDocumentosState();

}

class ListaDocumentosState extends State<ListaDocumentosWidget> {

  late Future<Set<Comprobante>> comprobantes;

  @override
  void initState() {

    super.initState();

    comprobantes = (Sesion.usuario as Estudiante).obtenerComprobantes();

  }


  @override
  Widget build(BuildContext contexto) {

    return FutureBuilder(

        future: comprobantes,

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasData && snapshot.data != null) {

              int numeroComprobantes = snapshot.data!.length;

              print(snapshot.data!.length);

              /*Comprobante c = snapshot.data!.elementAt(0);

              final blob = html.Blob([c.bytes], "application/pdf");

              final url = html.Url.createObjectUrlFromBlob(blob);

              html.window.open(url, '_blank');

              html.Url.revokeObjectUrl(url);*/

              return ListView.separated(
                
                padding: EdgeInsets.all(30),

                itemBuilder: (context, index) {

                  return ListTile(

                    title: Text("Hello there"),

                    tileColor: Colors.blue,

                  );

                },

                separatorBuilder: (context, index) => SizedBox(height: 20,),

                itemCount: numeroComprobantes,

              );

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