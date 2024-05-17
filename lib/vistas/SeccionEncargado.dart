import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";
import "package:gestor_de_horas_complementarias/datos/Encargado.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/OperacionesArchivos.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/vistas/PerfilUsuario.dart";

import "package:gestor_de_horas_complementarias/vistas/SeccionEstudiante.dart";

class SeccionEncargadoWidget extends StatefulWidget {

  SeccionEncargadoWidget({super.key, required this.encargado});

  Encargado encargado;

  @override

  State<SeccionEncargadoWidget> createState() => SeccionEncargadoState();

}

class SeccionEncargadoState extends State<SeccionEncargadoWidget> {

  TextEditingController controladorCampoBusqueda = TextEditingController();

  late void Function(void Function()) repintarSeccionListaEstudiantes;

  int indiceVista = 0;

  List<Widget> vistas = [];

  Map<Estudiante, Uint8List?> datosEstudiantes = <Estudiante, Uint8List?>{};

  Map<Estudiante, Uint8List?> estudiantesFiltrados = <Estudiante, Uint8List?>{};

  void eventoCampoBusqueda(){

    String contenido = controladorCampoBusqueda.text.trim().toLowerCase();

    if(contenido.isNotEmpty) {

      repintarSeccionListaEstudiantes((){

        filtrarEstudiantes(contenido);

      });

    }else{

      repintarSeccionListaEstudiantes((){

        estudiantesFiltrados = Map.from(datosEstudiantes);

      });

    }

  }

  void filtrarEstudiantes(String patron) {

    estudiantesFiltrados.clear();

    RegExp patronBusqueda = RegExp(patron);

    for(Estudiante estudiante in datosEstudiantes.keys) {

      if(patronBusqueda.hasMatch(estudiante.nombreCompleto().toLowerCase())) {

        estudiantesFiltrados[estudiante] = datosEstudiantes[estudiante];

      }

    }

  }

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

    return DefaultTabController(length: 2, child: Scaffold(

      body: TabBarView(

        children: [

          LayoutBuilder(

            builder: (context, constraints) {

              double altoDispositivo = constraints.maxHeight;

              double anchoDispositivo = constraints.maxWidth;

              double altoAppBar = altoDispositivo * 0.08;

              double altoBody = altoDispositivo * 0.92;

              double paddingGridView = anchoDispositivo * 0.05;

              double espaciadoEntreElementos = anchoDispositivo * 0.02;

              Size dimensionSeccionBusqueda = const Size.fromHeight(kToolbarHeight);

              return Scaffold(

                  backgroundColor: Colors.grey[50],

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

                              onChanged: (value) {

                                eventoCampoBusqueda();

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

                        datosEstudiantes.clear();

                        List<Estudiante> estudiantesCargados = <Estudiante>[];

                        consultaEstudiantes.forEach((documentoEstudiante) {

                          Map<String, dynamic> datosEstudiante = documentoEstudiante.data();

                          Map<String, dynamic> datosPersonalesEstudiante = datosEstudiante["datos_personales"];

                          String numeroCuenta = documentoEstudiante.id;

                          estudiantesCargados.add(Estudiante(numeroCuenta, datosPersonalesEstudiante["nombre"], datosPersonalesEstudiante["apellido_paterno"], datosPersonalesEstudiante["apellido_materno"], (datosPersonalesEstudiante["fecha_nacimiento"] as Timestamp).toDate(), datosEstudiante["carrera"]));

                        });

                        return FutureBuilder(

                          future: cargarImagenPerfilEstudiantes(estudiantesCargados),

                          builder: (context, snapshot) {

                            if(snapshot.connectionState == ConnectionState.done) {

                               List<Uint8List?> imagenPerfilEstudiantes = snapshot.data!;

                               datosEstudiantes = Map.fromIterables(estudiantesCargados, imagenPerfilEstudiantes);

                               return StatefulBuilder(

                                builder: (context, setStateGV) {

                                  repintarSeccionListaEstudiantes = setStateGV;

                                  eventoCampoBusqueda();

                                  return GridView.builder(

                                    padding: EdgeInsets.all(paddingGridView),

                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: espaciadoEntreElementos, crossAxisSpacing: espaciadoEntreElementos),

                                    itemCount: estudiantesFiltrados.length,

                                    itemBuilder: (context, index) => LayoutBuilder(

                                      builder: (context, constraints) {

                                        double medidaLadoBoton = constraints.maxWidth;

                                        double medidaPaddingBoton = medidaLadoBoton * 0.05;

                                        double medidaUtilLadoBoton = medidaLadoBoton - (medidaPaddingBoton * 2);

                                        double altoContenedorImagenEstudiante = medidaUtilLadoBoton * 0.65;

                                        double altoContenedorNombreEstudiante = medidaUtilLadoBoton * 0.25;

                                        return FloatingActionButton(

                                          heroTag: index,

                                          shape: RoundedRectangleBorder(

                                              borderRadius: BorderRadius.circular(30),

                                              side: BorderSide.none

                                          ),

                                          backgroundColor: Colors.grey[200],

                                          onPressed: () {

                                            DatosApp.navegador.agregarVista(SeccionEstudianteWidget(estudiante: estudiantesFiltrados.keys.toList()[index],));

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

                                                      child: (estudiantesFiltrados.values.toList()[index] == null) ? ClipOval(

                                                        clipBehavior: Clip.antiAliasWithSaveLayer,

                                                        child: SvgPicture.asset("./assets/images/PerfilUsuarioSeccionEncargado.svg", fit: BoxFit.fill,),

                                                      ):ClipOval(

                                                        clipBehavior: Clip.antiAliasWithSaveLayer,

                                                        child: Image.memory(estudiantesFiltrados.values.toList()[index]!, fit: BoxFit.fill),

                                                      ),

                                                    ),

                                                  ),

                                                  Container(

                                                    alignment: Alignment.center,

                                                    height: altoContenedorNombreEstudiante,

                                                    width: medidaUtilLadoBoton,

                                                    child: Text(

                                                      estudiantesFiltrados.keys.toList()[index].nombreCompleto(),

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

      floatingActionButton: FloatingActionButton(

        onPressed: () async {

          List<String>? datosPersonalesEstudiantes = await OperacionesArchivos.leerArchivoCSV();

          if(datosPersonalesEstudiantes != null) {

            ScaffoldMessenger.of(context).showSnackBar(

                SnackBar(

                  backgroundColor: Colors.orange,

                  duration: const Duration(seconds: 5),

                  content: const Text(

                    "Subiendo estudiantes",

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                      color: Colors.white,

                    ),

                  ),

                  padding: const EdgeInsets.all(20),

                  behavior: SnackBarBehavior.floating,

                  shape: RoundedRectangleBorder(

                      borderRadius: BorderRadius.circular(10)

                  ),

                )

            );

            bool operacionRealizada = await widget.encargado.cargarEstudiantes(datosPersonalesEstudiantes);

            ScaffoldMessenger.of(context).clearSnackBars();

            if(operacionRealizada != null) {

              String mensajeNotificacion = "";

              Color colorNotificacion = Colors.green;

              if (operacionRealizada) {

                mensajeNotificacion = "Han sido cargados correctamente los estudiantes al sistema";

              } else {

                mensajeNotificacion = "Error al cargar los estudiante. Reintente, por favor";

                colorNotificacion = Colors.red;

              }

              ScaffoldMessenger.of(context).showSnackBar(

                  SnackBar(

                    backgroundColor: colorNotificacion,

                    content: Text(

                      mensajeNotificacion,

                      textAlign: TextAlign.center,

                      style: const TextStyle(

                        fontWeight: FontWeight.bold,

                        color: Colors.white,

                      ),

                    ),

                    duration: const Duration(seconds: 3),

                    padding: const EdgeInsets.all(20),

                    behavior: SnackBarBehavior.floating,

                    shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(10)

                    ),

                  )

              );

            }

          }

        },

        clipBehavior: Clip.antiAliasWithSaveLayer,

        shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(30)

        ),

        child: ClipOval(

          clipBehavior: Clip.antiAliasWithSaveLayer,

          child: SvgPicture.asset("./assets/images/IconoCSV.svg", fit: BoxFit.fill, clipBehavior:
            Clip.antiAliasWithSaveLayer,),

        )

      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: PreferredSize(

        preferredSize: const Size.fromHeight(kToolbarHeight),

        child: Container(

            color: Colors.grey[100],

            child: TabBar(

              indicatorColor: Colors.white,

              indicatorSize: TabBarIndicatorSize.tab,

              dividerColor: Colors.white,

              automaticIndicatorColorAdjustment: true,

              tabAlignment: TabAlignment.fill,

              indicator: const BoxDecoration(

                  color: Colors.white,

                  borderRadius: BorderRadius.only(

                      topRight: Radius.circular(15),

                      topLeft: Radius.circular(15)

                  )

              ),

              tabs: [

                Tab(

                    icon: SvgPicture.asset("./assets/images/IconoEstudiantes.svg", clipBehavior: Clip.antiAliasWithSaveLayer,)

                ),

                Tab(

                    icon: SvgPicture.asset("./assets/images/IconoPerfil.svg", clipBehavior: Clip.antiAliasWithSaveLayer,)

                ),

              ],

            )

        ),

      ),

    ));

  }
}


