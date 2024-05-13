import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/Encargado.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/vistas/PerfilUsuario.dart";
import "dart:math";

import "package:gestor_de_horas_complementarias/vistas/SeccionEstudiante.dart";

class SeccionEncargadoWidget extends StatefulWidget {

  SeccionEncargadoWidget({super.key, required this.encargado});

  Encargado encargado;

  @override

  State<SeccionEncargadoWidget> createState() => SeccionEncargadoState();

}

class SeccionEncargadoState extends State<SeccionEncargadoWidget> {

  int indiceVista = 0;

  Set<Color> coloresAsignados = <Color>{};

  List<Color> listaColores = <Color>[

    Colors.redAccent,

    Colors.amber,

    Colors.orange,

    Colors.teal,

    Colors.purple,

    Colors.pinkAccent,

  ];

  List<Widget> vistas = [];

  Future<List<Uint8List?>> cargarImagenPerfilEstudiantes(List<Estudiante> estudiantes) async {

    List<Uint8List?> imagenesUsuario = <Uint8List?>[];

    for(Estudiante estudiante in estudiantes) {

      try {

        Uint8List? imagenUsuarioEstudiante = await estudiante.cargarImagenUsuario();

        imagenesUsuario.add(imagenUsuarioEstudiante);

      }catch(error){

        imagenesUsuario.add(null);

      }

    }

    return imagenesUsuario;

  }
  
  @override
  void initState(){
    
    super.initState();

    Random random = Random(DateTime.now().microsecondsSinceEpoch);

    vistas.add(

      LayoutBuilder(

        builder: (context, constraints) {

          double altoDispositivo = constraints.maxHeight;

          double anchoDispositivo = constraints.maxWidth;

          double altoAppBar = altoDispositivo * 0.2;

          double altoBody = altoDispositivo * 0.6;

          Size dimensionSeccionBusqueda = const Size.fromHeight(kToolbarHeight);

          return Scaffold(

              backgroundColor: Colors.grey[100],

              appBar: AppBar(

                toolbarHeight: altoAppBar,

                flexibleSpace: Container(

                  width: anchoDispositivo,

                  height: altoAppBar,

                  decoration: const BoxDecoration(

                    gradient:  LinearGradient(

                        colors: [

                          Color.fromARGB(255, 27, 76, 222),

                          Colors.indigo,

                        ],

                        begin: Alignment.topCenter,

                        end: Alignment.bottomCenter

                    ),

                  ),

                ),

                bottom: PreferredSize(

                  preferredSize: dimensionSeccionBusqueda,

                  child: Container(

                    padding: EdgeInsets.all(dimensionSeccionBusqueda.height * 0.15),

                    alignment: Alignment.center,

                    color: Colors.grey[100],

                    height: dimensionSeccionBusqueda.height,

                    width: anchoDispositivo,

                    child: Container(

                      alignment: Alignment.center,

                      color: Colors.grey[100],

                      child: TextField(

                        style: TextStyle(

                          color: Colors.grey[700],

                          overflow: TextOverflow.fade,

                          fontWeight: FontWeight.bold,

                        ),

                        textAlign: TextAlign.center,

                        textAlignVertical: TextAlignVertical.center,

                        decoration: InputDecoration(

                          contentPadding: const EdgeInsets.all(0),

                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(15),

                            gapPadding: 0,

                            borderSide: BorderSide.none

                          ),

                          filled: true,

                          fillColor: Colors.grey[300],

                          hintText: "Búsqueda de estudiantes",

                          hintStyle: TextStyle(

                            fontWeight: FontWeight.bold,

                            overflow: TextOverflow.ellipsis,

                            color: Colors.grey[700]

                          ),

                          hintFadeDuration: const Duration(milliseconds: 200),

                          hintMaxLines: 1

                        ),

                      ),

                    )

                  ),

                ),

              ),

              body: StreamBuilder(

                stream: (Sesion.usuario as Encargado).obtenerEstudiantes(),

                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.active) {

                    List<QueryDocumentSnapshot<Map<String, dynamic>>> consultaEstudiantes = snapshot.data!.docs;

                    List<Estudiante> estudiantes = <Estudiante>[];

                    consultaEstudiantes.forEach((documentoEstudiante) {

                      Map<String, dynamic> datosEstudiante = documentoEstudiante.data();

                      Map<String, dynamic> datosPersonalesEstudiante = datosEstudiante["datos_personales"];

                      String numeroCuenta = documentoEstudiante.id;

                      estudiantes.add(Estudiante(numeroCuenta, datosPersonalesEstudiante["nombre"], datosPersonalesEstudiante["apellido_paterno"], datosPersonalesEstudiante["apellido_materno"], (datosPersonalesEstudiante["fecha_nacimiento"] as Timestamp).toDate(), datosEstudiante["carrera"]));

                    });

                    return FutureBuilder(

                      future: cargarImagenPerfilEstudiantes(estudiantes),

                      builder: (context, snapshot) {

                        if(snapshot.connectionState == ConnectionState.done) {

                          List<Uint8List?> imagenPerfilEstudiantes = snapshot.data!;

                          return GridView.builder(

                            padding: const EdgeInsets.all(25),

                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),

                            itemCount: consultaEstudiantes.length,

                            itemBuilder: (context, index) => LayoutBuilder(

                              builder: (context, constraints) {

                                if(coloresAsignados.length == listaColores.length) {

                                  coloresAsignados.clear();

                                }

                                while(!coloresAsignados.add(listaColores[random.nextInt(listaColores.length)]));

                                return LayoutBuilder(

                                  builder: (context, constraints) {

                                    double medidaLadoBoton = constraints.maxWidth;

                                    double medidaPaddingBoton = medidaLadoBoton * 0.1;

                                    double medidaUtilLadoBoton = medidaLadoBoton - (medidaPaddingBoton * 2);

                                    double altoContenedorImagenEstudiante = medidaUtilLadoBoton * 0.7;

                                    double altoContenedorNombreEstudiante = medidaUtilLadoBoton * 0.3;

                                    return FloatingActionButton(

                                      heroTag: index,

                                      backgroundColor: coloresAsignados.elementAt(coloresAsignados.length - 1),

                                      onPressed: (){


                                        Navigator.of(context).push(MaterialPageRoute(builder:  (context) => SeccionEstudianteWidget(estudiante: estudiantes[index],)));


                                      },

                                      child: Padding(

                                          padding: EdgeInsets.all(medidaPaddingBoton),

                                          child: Column(

                                            mainAxisAlignment: MainAxisAlignment.center,

                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [

                                              Container(

                                                alignment: Alignment.center,

                                                height: altoContenedorImagenEstudiante,

                                                width: medidaUtilLadoBoton,

                                                child: CircleAvatar(

                                                  backgroundColor: Colors.transparent,

                                                  radius: altoContenedorImagenEstudiante * 0.5,

                                                  child: (imagenPerfilEstudiantes[index] == null) ? ClipOval(

                                                    clipBehavior: Clip.antiAliasWithSaveLayer,

                                                    child: SvgPicture.asset("./assets/images/PerfilUsuarioSeccionEncargado.svg", fit: BoxFit.fill,),

                                                  )

                                                      :ClipOval(

                                                    clipBehavior: Clip.antiAliasWithSaveLayer,

                                                    child: Image.memory(imagenPerfilEstudiantes[index]!, fit: BoxFit.fill),

                                                  ),

                                                ),

                                              ),

                                              Container(

                                                alignment: Alignment.center,

                                                height: altoContenedorNombreEstudiante,

                                                width: medidaUtilLadoBoton,

                                                child: const Text(

                                                  "Nombre del estudiante",

                                                  textAlign: TextAlign.center,

                                                  overflow: TextOverflow.fade,

                                                  maxLines: 2,

                                                  style: TextStyle(

                                                      color: Colors.white,

                                                      fontWeight: FontWeight.bold

                                                  ),

                                                ),

                                              )

                                            ],

                                          )

                                      ),

                                    );

                                  },

                                );

                              },

                            ),


                          );

                        }

                        return Container(

                            alignment: Alignment.center,

                            child: const CircularProgressIndicator()

                        );

                      },

                    );

                  }

                  return Container(

                      alignment: Alignment.center,

                      child: const CircularProgressIndicator()

                  );

                },

              )

          );

        },

      )

    );
    
    vistas.add(PerfilUsuarioWidget(usuario: widget.encargado));
    
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: vistas[indiceVista],

      bottomNavigationBar: BottomNavigationBar(

        currentIndex: indiceVista,

        items: const [

          BottomNavigationBarItem(

            icon: Icon(Icons.groups),

            label: "Estudiantes"

          ),

          BottomNavigationBarItem(

            icon: Icon(Icons.account_circle),

            label: "Mi perfil"

          )

        ],

        onTap: (value) {

          setState(() {

            indiceVista = value;

          });

        },

      ),

    );


  }



}