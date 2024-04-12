
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

    renders.add(Positioned.fill(

      child: Container(

        child: vistas[indiceVista],

      ),

    ));

  }

  int indiceVista = 1;

  final vistas = <Widget>[

    /*Container(

      color: Colors.green,

    ),*/

    SeccionComprobantesEstudianteWidget(estudiante: (Sesion.usuario as Estudiante),),

    const BarraProgresoEstudianteWidget(),

    /*Container(

      color: Colors.red

    )*/

    const InformacionUsuarioWidget(),

  ];

  final List<Positioned> renders = <Positioned> [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body:

      LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {

        alto = constraints.maxHeight;

        ancho = constraints.maxWidth;

        return Container(

          height: double.infinity,

          width: double.infinity,

          alignment: Alignment.center,

          child: Stack(

            alignment: Alignment.center,

            children: renders,

          )

        );

      }),

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

        currentIndex: indiceVista,

        onTap: (index) {

          setState(() {

            indiceVista = index;

            renders[0] = Positioned.fill(child: vistas[indiceVista]);

            /*Este metodo no funciona porque desplaza los elementos de la lista hacia la derecha.
            Recordemos que un widget stack representa apiladamente los diferentes elementos que lo conforman.
            De esta manera, los elementos que se presentan más arriba en el apilado del stack son los ultimos elementos
            agregados la lista, con lo cual si al realizar una inserción se recorre el elemento previo a la derecha, entonces por
            obviedad este elemento desplazado siempre estará en la parte final de la lista con lo cual siempre será visible en los
            primeros planos de los elementos renderizados por el stack.

            renders.insert(index, element);
            */
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

            Positioned notificacion = Positioned(

              width: (ancho / 16) * 6,

              height: alto / 8,

              bottom: 10,

              right: 10,

              child: AnimatedOpacity(

                opacity: opacidadNotificacion,

                duration: const Duration(seconds: 1),

                child: Container(

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),

                    color: colorNotificacion,

                  ),

                  alignment: Alignment.center,

                  child: Text(mensajeNotificacion,

                    textAlign: TextAlign.center,

                    style: const TextStyle(

                      color: Colors.white,

                      fontWeight: FontWeight.bold,

                    ),

                  ),

                ),

              )

            );

            setState(() {

              renders.add(notificacion);

            });

            Future.delayed(const Duration(seconds: 3), () {

              setState(() {

                renders.removeLast();

              });

            });

          }

        }, //Fin de la generacion de la notificacion

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