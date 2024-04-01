
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Encargado.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';

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
  Widget build(BuildContext context) {

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

          (Sesion.usuario as Encargado).cargarEstudiantes();

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