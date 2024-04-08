import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'dart:async';
//import 'dart:html' as html;

class ListaDocumentosWidget extends StatefulWidget {

  ListaDocumentosWidget({super.key, required this.funcionObtenerComprobantes});

  Future<Set<Comprobante>> Function() funcionObtenerComprobantes;

  @override
  State<ListaDocumentosWidget> createState() => ListaDocumentosState();

}

class ListaDocumentosState extends State<ListaDocumentosWidget> {

  late Future<Set<Comprobante>> comprobantes;

  @override
  void initState() {

    super.initState();

    comprobantes = widget.funcionObtenerComprobantes();

  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(

        future: comprobantes,

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.done) {

            if(snapshot.hasData && snapshot.data != null) {

              int numeroComprobantes = snapshot.data!.length;

              Set<Comprobante> comprobantes = snapshot.data!;

              /*Comprobante c = snapshot.data!.elementAt(0);

              final blob = html.Blob([c.bytes], "application/pdf");

              final url = html.Url.createObjectUrlFromBlob(blob);

              html.window.open(url, '_blank');

              html.Url.revokeObjectUrl(url);*/

              return ListView.separated(
                
                padding: const EdgeInsets.all(30),

                itemBuilder: (context, index) {

                  return ListTile(

                    title: Text(comprobantes.elementAt(index).nombre),

                    leading: const Icon(Icons.picture_as_pdf),

                    trailing: const Icon(Icons.play_arrow_sharp),

                    shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(10)

                    ),

                    titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),

                    horizontalTitleGap: 30,

                    onTap: () {

                      print("Nombre del documento: ${comprobantes.elementAt(index).nombre}");

                    },

                  );
                },

                separatorBuilder: (context, index) => const SizedBox(height: 20,),

                itemCount: numeroComprobantes,

              );

            }else if(snapshot.hasError) {

              return Text("Error esperando los datos");

            }

          }

          return Container(

            child:

              CircularProgressIndicator()

          );

        },);

  }

}