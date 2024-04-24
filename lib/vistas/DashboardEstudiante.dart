import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'package:gestor_de_horas_complementarias/vistas/BarraProgresoEstudiante.dart';
import 'package:gestor_de_horas_complementarias/vistas/SeccionComprobantesEstudiante.dart';
import 'package:gestor_de_horas_complementarias/vistas/InformacionUsuario.dart';

class DashboardEstudianteWidget extends StatefulWidget {

  const DashboardEstudianteWidget({super.key});

  @override
  State<DashboardEstudianteWidget> createState() => DashboardEstudianteState();

}

class DashboardEstudianteState extends State<DashboardEstudianteWidget> {

  DashboardEstudianteState();

  double ancho = 0;

  double alto = 0;

  @override
  void initState(){

    super.initState();

  }

  int indiceVista = 1;

  final vistas = <Widget>[

    SeccionComprobantesEstudianteWidget(estudiante: (Sesion.usuario as Estudiante),),

    const BarraProgresoEstudianteWidget(),

    const InformacionUsuarioWidget(),

  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: vistas[indiceVista],

      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          
          BottomNavigationBarItem(

            icon: Icon(Icons.document_scanner_outlined,

            ),
          
            label: "Mis comprobantes"
          
          ),
          
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart),

            label: "Mi progreso"

          ),

          BottomNavigationBarItem(icon: Icon(Icons.account_circle),

            label: "Mi perfil"

          )

        ],

        currentIndex: indiceVista,

        onTap: (index) {

          setState(() {

            indiceVista = index;

          });

        },

        iconSize: 30,

        type: BottomNavigationBarType.fixed,

      ),

      floatingActionButton: FloatingActionButton(

        onPressed: () async {

          bool? operacionRealizada = await (Sesion.usuario as Estudiante).cargarComprobante();

          if(operacionRealizada != null) {

            String mensajeNotificacion = "";

            Color colorNotificacion = Colors.green;

            double opacidadNotificacion = 1.0;

            if (operacionRealizada) {

              mensajeNotificacion = "Los archivos han sido cargados correctamente";

            } else {

              mensajeNotificacion = "Ha ocurrido un error al cargar los archivos";

              colorNotificacion = Colors.red;

            }

            ScaffoldMessenger.of(context).showSnackBar(

              SnackBar(

                content: Text(mensajeNotificacion),

                duration: const Duration(seconds: 3),

                padding: const EdgeInsets.all(20),

                behavior: SnackBarBehavior.floating,

                shape: RoundedRectangleBorder(
                  
                  borderRadius: BorderRadius.circular(10)
                  
                )

              )

            );

          }

        }, //Fin de la generacion de la notificacion

        tooltip: "Subir comprobante",

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(30)

        ),

        backgroundColor: const Color.fromARGB(255, 175, 0, 0),

        child: const Icon(

          Icons.picture_as_pdf,

          color: Colors.white,

        ),

      ),

      floatingActionButtonLocation:

        FloatingActionButtonLocation.centerFloat,

    );

  }

}