import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";
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

  TextEditingController controladorCampoBusqueda = TextEditingController();

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
  Widget build(BuildContext context) {

    Random random = Random(DateTime.now().microsecondsSinceEpoch);

    return DefaultTabController(length: 2, child: Scaffold(

      body: TabBarView(

        children: [

          LayoutBuilder(

            builder: (context, constraints) {

              double altoDispositivo = constraints.maxHeight;

              double anchoDispositivo = constraints.maxWidth;

              double altoAppBar = altoDispositivo * 0.15;

              double altoBody = altoDispositivo * 0.85;

              double paddingGridView = anchoDispositivo * 0.05;

              double espaciadoEntreElementos = anchoDispositivo * 0.02;

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

                              controller: controladorCampoBusqueda,

                              onChanged: (patron){

                                setState((){

                                  controladorCampoBusqueda.text;

                                });

                              },

                              inputFormatters: [

                                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))

                              ],

                              style: TextStyle(

                                color: Colors.grey[700],

                                overflow: TextOverflow.fade,

                                fontWeight: FontWeight.bold,

                              ),

                              textAlign: TextAlign.center,

                              textAlignVertical: TextAlignVertical.center,

                              decoration: InputDecoration(

                                  contentPadding: const EdgeInsets.all(0),

                                  suffixIcon: const Icon(Icons.search_rounded),

                                  suffixIconColor: DatosApp.colorApp,

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

                                padding: EdgeInsets.all(paddingGridView),

                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: espaciadoEntreElementos, crossAxisSpacing: espaciadoEntreElementos),

                                itemCount: consultaEstudiantes.length,

                                itemBuilder: (context, index) => LayoutBuilder(

                                  builder: (context, constraints) {

                                    double medidaLadoBoton = constraints.maxWidth;

                                    double medidaPaddingBoton = medidaLadoBoton * 0.05;

                                    double medidaUtilLadoBoton = medidaLadoBoton - (medidaPaddingBoton * 2);

                                    double altoContenedorImagenEstudiante = medidaUtilLadoBoton * 0.65;

                                    double altoContenedorNombreEstudiante = medidaUtilLadoBoton * 0.25;

                                    if(coloresAsignados.length == listaColores.length) {

                                      coloresAsignados.clear();

                                    }

                                    while(!coloresAsignados.add(listaColores[random.nextInt(listaColores.length)]));

                                    return FloatingActionButton(

                                      heroTag: index,

                                      shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(40),

                                          side: BorderSide.none

                                      ),

                                      //backgroundColor: coloresAsignados.elementAt(coloresAsignados.length - 1),

                                      backgroundColor: Colors.grey[200],

                                      onPressed: () {

                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SeccionEstudianteWidget(estudiante: estudiantes[index],),));

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

                                                  ):ClipOval(

                                                    clipBehavior: Clip.antiAliasWithSaveLayer,

                                                    child: Image.memory(imagenPerfilEstudiantes[index]!, fit: BoxFit.fill),

                                                  ),

                                                ),

                                              ),

                                              Container(

                                                alignment: Alignment.center,

                                                height: altoContenedorNombreEstudiante,

                                                width: medidaUtilLadoBoton,

                                                child: Text(

                                                  estudiantes[index].nombreCompleto(),

                                                  textAlign: TextAlign.center,

                                                  overflow: TextOverflow.fade,

                                                  maxLines: 2,

                                                  style: TextStyle(

                                                      color: Colors.grey[700],

                                                      fontWeight: FontWeight.bold

                                                  ),

                                                ),

                                              )

                                            ],

                                          )

                                      ),

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

          ),

          PerfilUsuarioWidget(usuario: widget.encargado)

        ],

      ),

      bottomNavigationBar: PreferredSize(

        preferredSize: const Size.fromHeight(kToolbarHeight),

        child: Container(

            color: Colors.white,

            child: TabBar(

              indicatorColor: Colors.grey[200],

              indicatorSize: TabBarIndicatorSize.tab,

              dividerColor: Colors.grey[200],

              automaticIndicatorColorAdjustment: true,

              tabAlignment: TabAlignment.fill,

              indicator: BoxDecoration(

                  color: Colors.grey[200],

                  borderRadius: const BorderRadius.only(

                      topRight: Radius.circular(20),

                      topLeft: Radius.circular(20)

                  )

              ),

              tabs: [

                Tab(

                    icon: SvgPicture.asset("./assets/images/IconoAceptado.svg", clipBehavior: Clip.antiAliasWithSaveLayer,)

                ),

                Tab(

                    icon: SvgPicture.asset("./assets/images/IconoPendiente.svg", clipBehavior: Clip.antiAliasWithSaveLayer,)

                ),

              ],

            )

        ),

      ),

    ));


  }



}