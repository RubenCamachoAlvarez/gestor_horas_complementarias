import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/Roles.dart';
import 'dart:math';

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

  @override
  Widget build(BuildContext context) {

    /*return Scaffold(

      body:

        ListView(

          padding: EdgeInsets.only(

            bottom: 30,

            top: 30,

            left: 30,

            right: 30,

          ),

          children: [

            TextField(

              decoration: InputDecoration(

                border: OutlineInputBorder(

                  borderRadius: BorderRadius.circular(10)

                ),

                labelText: "Buscar",

              ),

            ),

            SizedBox(

              height: 20,

            ),

            GridView.count(

              crossAxisCount: 2,

              physics: NeverScrollableScrollPhysics(),

              shrinkWrap: true,

              primary: false,

              crossAxisSpacing: 10,

              mainAxisSpacing: 10,

              children: <Widget>[

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

                FloatingActionButton(

                    onPressed: (){

                      print("Boton");

                    },

                    backgroundColor: Colors.red,

                    child: Padding(

                      padding: EdgeInsets.all(10),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          CircleAvatar(

                            radius: 30,

                            backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                            backgroundColor: Colors.white70.withOpacity(0.1),

                          ),

                          SizedBox(

                            height: 20,

                          ),

                          Text("Jose Luis Estrada Montes",

                            style: TextStyle(

                              fontWeight: FontWeight.bold,

                            ),

                            textAlign: TextAlign.center,

                          ),

                        ],

                      ),

                    )

                ),

              ],

            )

          ],

        )

    );*/

    return Scaffold(

      body:

        StreamBuilder(

          stream: BaseDeDatos.conexion.collection("Usuarios").where("rol", isEqualTo: Roles.ESTUDIANTE).snapshots(),

          builder: (context, snapshot) {

            if(snapshot.connectionState == ConnectionState.waiting) {

              return Container();

            }else{

              print("Datos cargados correctamente");

              List<QueryDocumentSnapshot<Map<String, dynamic>>> estudiantes =

                  snapshot.data!.docs;

              return ListView(

                padding: const EdgeInsets.all(30),

                children: [

                  TextField(

                    decoration: InputDecoration(

                      labelText: "Buscar",

                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(20),

                      )

                    ),

                    textAlign: TextAlign.center,

                  ),

                  SizedBox(

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

                      Map<String, dynamic> datosPersonalesEstudiante = estudiantes.elementAt(index).data()["datos_personales"];

                      Random random = Random();

                      int limite = colores.length;

                      return FloatingActionButton(

                        backgroundColor: colores[random.nextInt(limite)],

                        onPressed: () {},

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

                                    backgroundImage: const AssetImage("assets/images/Profile.png"),

                                    backgroundColor: Colors.white,

                                  ),

                                ],

                              ),

                              const SizedBox(

                                height: 20,

                              ),

                              Text(

                                "${datosPersonalesEstudiante["nombre"]} ${datosPersonalesEstudiante["apellido_paterno"]} ${datosPersonalesEstudiante["apellido_materno"]}",

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

        )

    );

  }

}