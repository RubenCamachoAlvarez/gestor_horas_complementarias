
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/vistas/ListaComprobantes.dart';

class SeccionComprobantesEstudianteWidget extends StatefulWidget {

  Estudiante estudiante;

  SeccionComprobantesEstudianteWidget({super.key, required this.estudiante});

  @override

  State<SeccionComprobantesEstudianteWidget> createState() => SeccionComprobantesEstudianteState();


}

class SeccionComprobantesEstudianteState extends State<SeccionComprobantesEstudianteWidget> {

  SeccionComprobantesEstudianteState();

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

            ListaComprobantesWidget(funcionObtenerComprobantes: widget.estudiante.obtenerComprobantesPendientes,),

            ListaComprobantesWidget(funcionObtenerComprobantes: widget.estudiante.obtenerComprobantesRevisados),

          ],

        ),

      ),

    );

  }


}