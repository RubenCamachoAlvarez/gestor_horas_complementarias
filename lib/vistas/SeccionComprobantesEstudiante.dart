
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';
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

      length: 3,

      child: Scaffold(

        appBar: AppBar(

          toolbarHeight: 0,

          bottom: TabBar(

            dividerColor: Colors.grey[300],

            dividerHeight: 2,

            overlayColor: MaterialStateProperty.all(Colors.transparent),

            indicatorSize: TabBarIndicatorSize.tab,

            indicator: BoxDecoration(

              borderRadius: const BorderRadius.only(

                topLeft: Radius.circular(20),

                topRight: Radius.circular(20)

              ),

              color: Colors.grey[200],

            ),

            tabs: const [

              Tab(

                icon: Icon(Icons.timelapse_rounded, color: Colors.brown),

                text: "Pendientes",

              ),

              Tab(

                icon: Icon(Icons.check_circle_rounded, color: Colors.green),

                text: "Aceptados"

              ),

              Tab(

                icon: Icon(Icons.remove_circle_rounded, color: Colors.red),

                text: "Rechazados",

              )

            ],

            labelStyle: const TextStyle(

              fontWeight: FontWeight.bold,

              color: Colors.black,

            ),


          ),

        ),

        body: TabBarView(

          children: [

            ListaComprobantesWidget(estudiante: widget.estudiante , filtroStatusComprobante: StatusComprobante.PENDIENTE,),

            ListaComprobantesWidget(estudiante: widget.estudiante, filtroStatusComprobante: StatusComprobante.ACEPTADO),
            
            ListaComprobantesWidget(estudiante: widget.estudiante, filtroStatusComprobante: StatusComprobante.RECHAZADO,)

          ],

        ),

      ),

    );

  }


}