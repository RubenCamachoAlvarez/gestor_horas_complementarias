
import 'package:flutter/material.dart';

class SeccionEstudiantesWidget extends StatefulWidget {

  const SeccionEstudiantesWidget({super.key});

  @override
  State<SeccionEstudiantesWidget> createState() => SeccionEstudiantesState();

}

class SeccionEstudiantesState extends State<SeccionEstudiantesWidget> {

  SeccionEstudiantesState();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

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

    );

  }

}