
import 'package:flutter/material.dart';

class DashboardEstudianteWidget extends StatefulWidget {

  const DashboardEstudianteWidget({super.key});

  @override
  State<DashboardEstudianteWidget> createState() => DashboardEstudianteState();

}

class DashboardEstudianteState extends State<DashboardEstudianteWidget> {

  DashboardEstudianteState();

  int indiceSeccion = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner_outlined),
          
            label: "Mis documentos"
          
          ),
          
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart),

            label: "Mi progreso"

          ),

          BottomNavigationBarItem(icon: Icon(Icons.account_circle),

            label: "Mi perfil"

          )

        ],

        currentIndex: indiceSeccion,

        onTap: (index) {

          setState(() {

            indiceSeccion = index;

          });

        },

        iconSize: 30,

        type: BottomNavigationBarType.fixed,

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {



        },

        tooltip: "Subir comprobante",

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(30)

        ),

        child: const Icon(Icons.picture_as_pdf),

      ),

      floatingActionButtonLocation:

        FloatingActionButtonLocation.centerFloat,

    );

  }

}