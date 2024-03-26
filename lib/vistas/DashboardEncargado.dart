
import 'package:flutter/material.dart';

class DashboardEncargadoWidget extends StatefulWidget {

  const DashboardEncargadoWidget({super.key});

  @override
  State<StatefulWidget> createState() {

    return DashboardEncargadoState();

  }

}

class DashboardEncargadoState extends State<DashboardEncargadoWidget> {

  DashboardEncargadoState();

  @override
  Widget build(BuildContext contexto) {

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(

            icon: Icon(Icons.home),

            label: "Primero"

          ),

          BottomNavigationBarItem(

              icon: Icon(Icons.abc),

              label: "Segunda"

          ),

        ],

        currentIndex: 0,

        onTap: (index) {

          print("Se selecciono el indice $index");

        },

        type: BottomNavigationBarType.fixed,

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () {

          print("Boton de cargar datos");

        },

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(30),

        ),

        child: const Icon(Icons.upload)

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }

}