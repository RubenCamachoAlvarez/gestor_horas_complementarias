import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';
import 'dart:math';
import 'package:gestor_de_horas_complementarias/vistas/SeccionComprobantesEstudiante.dart';

class SeccionEstudiantesWidget extends StatefulWidget {

  const SeccionEstudiantesWidget({super.key});

  @override
  State<SeccionEstudiantesWidget> createState() => SeccionEstudiantesState();

}

class SeccionEstudiantesState extends State<SeccionEstudiantesWidget> {

  SeccionEstudiantesState();

  List<Color> colores = <Color>[

    Colors.red,

    Colors.purple,

    Colors.blue,

    Colors.indigo

  ];

  Color colorAnterior = Colors.white;

  TextEditingController controladorBusquedaEstudiantes = TextEditingController();

  late Widget vistaEstudiantes = StreamBuilder(

    stream: BaseDeDatos.conexion.collection("Usuarios").where("rol", isEqualTo: Roles.ESTUDIANTE).snapshots(),

    builder: (context, snapshot) {

      if(snapshot.connectionState == ConnectionState.waiting) {

        return Container(

          alignment: Alignment.center,

          child: const Column(

            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: <CircularProgressIndicator>[

              CircularProgressIndicator()

            ],

          ),

        );

      }else{

        List<QueryDocumentSnapshot<Map<String, dynamic>>> estudiantes = snapshot.data!.docs;

        return ListView(

          padding: const EdgeInsets.all(30),

          children: [

            TextField(

              controller: controladorBusquedaEstudiantes,

              onChanged: (value) {

                print("Valor: ${controladorBusquedaEstudiantes.value.text}");

              },

              style: const TextStyle(

                color: Colors.black,

                fontWeight: FontWeight.bold,

              ),

              maxLines: 1,

              decoration: InputDecoration(

                prefixIcon: const Icon(Icons.search, color: Colors.black,size:30),

                floatingLabelBehavior: FloatingLabelBehavior.never,

                label: Container(

                  alignment: Alignment.center,

                  color: Colors.transparent,

                  child: const Text("Buscar"),

                ),

                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(20),

                ),

                labelStyle: const TextStyle(

                  fontWeight: FontWeight.bold,

                  color: Colors.indigo,

                ),

                floatingLabelStyle: const TextStyle(

                  fontWeight: FontWeight.bold,

                  color: Colors.indigo,

                )

              ),

              textAlign: TextAlign.center,

            ),

            const SizedBox(

              height: 30,

            ),

            GridView.builder(

              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                crossAxisCount: 2,

                crossAxisSpacing: 10,

                mainAxisSpacing: 10,

              ),

              itemCount: estudiantes.length,

              itemBuilder: (context, index) {

                Map<String, dynamic> datosEstudiante = estudiantes.elementAt(index).data();

                Estudiante estudiante = Estudiante(

                    estudiantes.elementAt(index).id,

                    datosEstudiante["datos_personales"]["nombre"],

                    datosEstudiante["datos_personales"]["apellido_paterno"],

                    datosEstudiante["datos_personales"]["apellido_materno"],

                    (datosEstudiante["datos_personales"]["fecha_nacimiento"] as Timestamp).toDate(),

                    datosEstudiante["carrera"]

                );


                Random random = Random();

                Color colorUsuario;

                int limite = colores.length;

                while((colorUsuario = colores[random.nextInt(limite)]) == colorAnterior);

                colorAnterior = colorUsuario;

                return FloatingActionButton(

                  heroTag: index,

                  backgroundColor: colorUsuario,

                  onPressed: () {

                    setState(() {

                      vista = Scaffold(

                        appBar: AppBar(

                          leading: IconButton(

                            icon: const Icon(Icons.arrow_back_ios_new),

                            alignment: Alignment.center,

                            onPressed: (){

                              setState(() {

                                vista = vistaEstudiantes;

                              });

                            },

                          ),

                          centerTitle: true,

                          title: Text(estudiante.nombreCompleto()),

                          titleTextStyle: const TextStyle(

                            fontWeight: FontWeight.bold,

                            color: Colors.black,

                            fontSize: 18

                          ),

                        ),

                        body: SeccionComprobantesEstudianteWidget(estudiante: estudiante,),

                      );

                    });

                  },

                  child: Padding(

                      padding: const EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          const Column(

                            mainAxisAlignment: MainAxisAlignment.center,

                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              CircleAvatar(

                                radius: 30,

                                backgroundImage: AssetImage("assets/images/Profile.png"),

                                backgroundColor: Colors.white,

                              ),

                            ],

                          ),

                          const SizedBox(

                            height: 20,

                          ),

                          Text(

                            estudiante.nombreCompleto(),

                            textAlign: TextAlign.center,

                            style: const TextStyle(

                              fontWeight: FontWeight.bold,

                              color: Colors.white,

                            ),

                          )

                        ],

                      )

                  ),


                );

              },

            )


          ],


        );

      }

    },

  );

  late Widget vista = vistaEstudiantes;

  @override
  Widget build(BuildContext context) {

    return vista;

  }

}