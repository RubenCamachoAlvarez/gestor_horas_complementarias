import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/Comprobante.dart";
import "package:gestor_de_horas_complementarias/datos/Encargado.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/OperacionesArchivos.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/vistas/LectorDocumentoPDF.dart";
import "package:gestor_de_horas_complementarias/vistas/PerfilUsuario.dart";

class SeccionEstudianteWidget extends StatefulWidget {

  SeccionEstudianteWidget({super.key, required this.estudiante});

  Estudiante estudiante;

  @override
  SeccionEstudianteState createState() => SeccionEstudianteState();

}

class SeccionEstudianteState extends State<SeccionEstudianteWidget> {

  SeccionEstudianteState();

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> crearPaginaVisualizacionComprobantes(Stream<QuerySnapshot<Map<String, dynamic>>> funcionObtenerComprobantes) {

    return StreamBuilder(

      stream: funcionObtenerComprobantes,

      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.active) {

          List<QueryDocumentSnapshot<Map<String, dynamic>>> consultaComprobantes = snapshot.data!.docs;

          return GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),

            padding: const EdgeInsets.all(25),

            itemCount: consultaComprobantes.length,

            itemBuilder: (context, index) {

              Map<String, dynamic> datosComprobante = consultaComprobantes.elementAt(index).data();

              DateTime fechaSubida = (datosComprobante["fecha_subida"] as Timestamp).toDate();

              return LayoutBuilder(

                builder: (context, constraints) {

                  double altoFloatingActionButton = constraints.maxHeight;

                  double anchoFloatingActionButton = constraints.maxWidth;

                  double padding = anchoFloatingActionButton * 0.05;

                  double anchoContenedor = (anchoFloatingActionButton - (padding * 2));

                  double altoContenedorIcono = (altoFloatingActionButton - (padding * 2)) * 0.7;

                  double altoContenedorInformacion = (altoFloatingActionButton - (padding * 2)) * 0.3;

                  return FloatingActionButton(

                      heroTag: index,

                      onPressed: () async {

                        Navigator.of(context).push(

                            MaterialPageRoute(

                              builder: (context) => FutureBuilder(

                                future: widget.estudiante.descargarComprobante(datosComprobante["nombre"]),

                                builder: (context, snapshot) {

                                  if(snapshot.connectionState == ConnectionState.done) {

                                    Comprobante? comprobante = snapshot.data;

                                    if(comprobante != null) {

                                      return LectorDocumentoPDFWidget(comprobante: comprobante);

                                    }else{

                                      Navigator.of(context).pop();

                                    }

                                  }

                                  return Container(

                                    color: Colors.white70,

                                    alignment: Alignment.center,

                                    child: const CircularProgressIndicator(),

                                  );

                                },),

                            )

                        );

                      },

                      backgroundColor: Colors.grey[100],

                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(25)

                      ),

                      child: Padding(

                          padding: EdgeInsets.all(padding),

                          child: Container(

                              alignment: Alignment.center,

                              decoration: BoxDecoration(

                                color: Colors.transparent,

                                borderRadius: BorderRadius.circular(25),

                              ),

                              child: Center(

                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.center,

                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [

                                    Container(

                                      height: altoContenedorIcono,

                                      width: anchoContenedor,

                                      alignment: Alignment.center,

                                      child: Center(

                                        child: SvgPicture.asset("./assets/images/IconoPDF.svg"),

                                      ),

                                    ),

                                    Container(

                                      height: altoContenedorInformacion,

                                      width: anchoContenedor,

                                      alignment: Alignment.center,

                                      child: Center(

                                        child: Column(

                                          children: [

                                            Text(

                                              datosComprobante["nombre"],

                                              textAlign: TextAlign.center,

                                              overflow: TextOverflow.ellipsis,

                                              maxLines: 1,

                                              style: const TextStyle(

                                                  fontWeight: FontWeight.bold

                                              ),

                                            ),

                                            Text(

                                              "${fechaSubida.day}/${fechaSubida.month}/${fechaSubida.year}",

                                              textAlign: TextAlign.center,

                                              overflow: TextOverflow.ellipsis,

                                              maxLines: 1,

                                              style: const TextStyle(

                                                  fontWeight: FontWeight.bold

                                              ),

                                            )

                                          ],

                                        ),

                                      ),

                                    )

                                  ],

                                ),

                              )

                          )

                      )

                  );

                },

              );

            },

          );

        }

        return Container(

            alignment: Alignment.center,

            child: const CircularProgressIndicator()

        );

      },

    );

  }

  @override
  Widget build(BuildContext context) {

    double ancho = MediaQuery.of(context).size.width;

    double alto = MediaQuery.of(context).size.height;

    //El alto del AppBar sera 20% del alto de la pantalla del dispositivo.
    double altoAppBar = alto * 0.2;

    //El alto de la seccion donde sera mostrado el contenido sera el 80% restante del alto de la pantalla.
    double altoContenido = alto * 0.8;

    return FutureBuilder(

      future: widget.estudiante.cargarImagenUsuario(),

      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.done) {

          return DefaultTabController(

            length: 3,

            child: Scaffold(

              backgroundColor: Colors.grey[100],

              appBar: AppBar(

                toolbarHeight: altoAppBar,

                /*leading: Container(

                  height: altoAppBar,

                  width: ancho * 0.1,

                  padding: const EdgeInsets.all(20),

                  alignment: Alignment.topCenter,

                  child: IconButton(onPressed: (){



                  }, icon: const Icon(Icons.arrow_circle_left, color: Colors.white)),

                ),*/

                flexibleSpace: LayoutBuilder(

                  builder: (context, constraints) {

                    double altoRegionFlexible = constraints.maxHeight;

                    double anchoRegionFlexible = constraints.maxWidth;

                    double altoTabBar = const Size.fromHeight(kToolbarHeight).height;

                    double radioCircleAvatar = (altoRegionFlexible - altoTabBar) * 0.4;

                    return Container(

                        decoration: const BoxDecoration(

                            gradient: LinearGradient(

                                colors: [

                                  Color.fromARGB(255, 27, 76, 222),

                                  Colors.indigo,

                                ],

                                begin: Alignment.topCenter,

                                end: Alignment.bottomCenter

                            )

                        ),

                        alignment: Alignment.center,

                        child: Stack(

                          children: [

                            Positioned(

                              right: anchoRegionFlexible * 0.5 - radioCircleAvatar,

                              top: (altoRegionFlexible - altoTabBar) * 0.2,

                              child: GestureDetector(

                                onTap: () {

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerfilUsuarioWidget(usuario: widget.estudiante),));

                                },

                                child: CircleAvatar(

                                  foregroundColor: Colors.transparent,

                                  backgroundColor: Colors.transparent,

                                  radius: radioCircleAvatar,

                                  child: (snapshot.data == null) ? ClipOval(

                                    clipBehavior: Clip.antiAliasWithSaveLayer,

                                    child: SvgPicture.asset("./assets/images/PerfilUsuario.svg", fit: BoxFit.fill),

                                  )

                                  : ClipOval(

                                    clipBehavior: Clip.antiAliasWithSaveLayer,

                                    child: Image.memory(snapshot.data!, fit: BoxFit.cover),

                                  ),

                                ),

                              ),

                            )

                          ],

                        )

                    );

                  },


                ),

                bottom: PreferredSize(

                  preferredSize: const Size.fromHeight(kToolbarHeight),

                  child: Container(

                      color: Colors.white,

                      child: TabBar(

                        indicatorColor: Colors.grey[100],

                        indicatorSize: TabBarIndicatorSize.tab,

                        dividerColor: Colors.grey[100],

                        automaticIndicatorColorAdjustment: true,

                        tabAlignment: TabAlignment.fill,

                        indicator: BoxDecoration(

                            color: Colors.grey[100],

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

                          Tab(

                              icon: SvgPicture.asset("./assets/images/IconoRechazado.svg", clipBehavior: Clip.antiAliasWithSaveLayer,)

                          )

                        ],

                      )

                  ),

                ),

              ),

              body: TabBarView(

                children: [

                  crearPaginaVisualizacionComprobantes(widget.estudiante.obtenerComprobantesAceptados()),

                  crearPaginaVisualizacionComprobantes(widget.estudiante.obtenerComprobantesPendientes()),

                  crearPaginaVisualizacionComprobantes(widget.estudiante.obtenerComprobantesRechazados()),

                ],

              ),

              floatingActionButton: (Sesion.usuario is Encargado) ? null : FloatingActionButton(

                onPressed: () async {

                  Map<String, dynamic>? datosComprobante = await OperacionesArchivos.seleccionarComprobantePDF();

                  if(datosComprobante != null) {

                    ScaffoldMessenger.of(context).showSnackBar(

                        SnackBar(

                          backgroundColor: Colors.orange,

                          duration: const Duration(seconds: 5),

                          content: const Text(

                            "Subiendo comprobante. Por favor espere.",

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

                    bool? operacionRealizada = await widget.estudiante.cargarComprobante(datosComprobante);

                    ScaffoldMessenger.of(context).clearSnackBars();

                    if(operacionRealizada != null) {

                      String mensajeNotificacion = "";

                      Color colorNotificacion = Colors.green;

                      if (operacionRealizada) {

                        mensajeNotificacion = "Los archivos han sido cargados correctamente";

                      } else {

                        mensajeNotificacion = "Ha ocurrido un error al cargar los archivos";

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

                backgroundColor: Colors.red,

                clipBehavior: Clip.antiAliasWithSaveLayer,

                shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(30)

                ),

                child: Padding(

                  padding: const EdgeInsets.all(10),

                  child: SvgPicture.asset("./assets/images/Icono.svg", fit: BoxFit.fill,),

                ),

              ),

              floatingActionButtonLocation: (Sesion.usuario is Encargado) ? null : FloatingActionButtonLocation.centerFloat,

            )

          );

        }

        return Container(

          alignment: Alignment.center,

          child: const CircularProgressIndicator(),

        );

      },

    );

  }

}