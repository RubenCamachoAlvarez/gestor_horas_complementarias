
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'package:gestor_de_horas_complementarias/vistas/ListaDocumentos.dart';

class DocumentosEstudianteWidget extends StatefulWidget {


  const DocumentosEstudianteWidget({super.key});

  @override

  State<DocumentosEstudianteWidget> createState() => DocumentosEstudianteState();


}

class DocumentosEstudianteState extends State<DocumentosEstudianteWidget> {

  DocumentosEstudianteState();

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 2,

      child: Scaffold(

        appBar: AppBar(

          toolbarHeight: 0,

          bottom: const TabBar(

            tabs: [

              Tab(

                icon: Icon(Icons.cloud_download_rounded),

                text: "Pendientes",

              ),

              Tab(

                icon: Icon(Icons.account_circle),

                text: "Revisados"

              )

            ]

          ),

        ),

        body: TabBarView(

          children: [

            /*Container(

              color: Colors.red,

              child: Icon(Icons.add),

            ),*/

            ListaDocumentosWidget(funcionObtenerComprobantes: (Sesion.usuario as Estudiante).obtenerComprobantesPendientes,),

            ListaDocumentosWidget(funcionObtenerComprobantes: (Sesion.usuario as Estudiante).obtenerComprobantesRevisados),

          ],

        ),

      ),

    );

  }


}