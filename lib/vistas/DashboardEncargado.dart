
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Encargado.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'package:gestor_de_horas_complementarias/vistas/InformacionUsuario.dart';

class DashboardEncargadoWidget extends StatefulWidget {

  const DashboardEncargadoWidget({super.key});

  @override
  State<StatefulWidget> createState() {

    return DashboardEncargadoState();

  }

}

class DashboardEncargadoState extends State<DashboardEncargadoWidget> {

  final List<Widget> vistas = <Widget>[

    Container(),

    const InformacionUsuarioWidget(),

  ];

  int indiceVista = 0;

  DashboardEncargadoState();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: vistas[indiceVista],

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[

          BottomNavigationBarItem(

            icon: Icon(Icons.groups),

            label: "Estudiantes"

          ),

          BottomNavigationBarItem(

              icon: Icon(Icons.account_circle),

              label: "Usuario"

          ),

        ],

        currentIndex: indiceVista,

        onTap: (index) {

          print("Se selecciono el indice $index");

          setState(() {

            indiceVista = index;

          });

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