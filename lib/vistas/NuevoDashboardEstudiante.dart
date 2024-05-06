import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/Comprobante.dart";
import "package:gestor_de_horas_complementarias/datos/Encargado.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/vistas/LectorDocumentoPDF.dart";

class DashboardEstudianteWidget extends StatefulWidget {

  DashboardEstudianteWidget({super.key, required this.estudiante});

  Estudiante estudiante;

  @override
  DashboardEstudianteState createState() => DashboardEstudianteState();

}

class DashboardEstudianteState extends State<DashboardEstudianteWidget> {

  DashboardEstudianteState();

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

                  print("ALTO: $altoFloatingActionButton");

                  print("ANCHO: $anchoFloatingActionButton");

                  print("PROPORCION PADDING ALTO: ${20/altoFloatingActionButton}");

                  print("PROPORCON PADDING ANCHO: ${20/anchoFloatingActionButton}");

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

                          padding: const EdgeInsets.all(20),

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

                                      height: altoFloatingActionButton * 0.7,

                                      width: anchoFloatingActionButton,

                                      alignment: Alignment.center,

                                      child: SvgPicture.asset("./assets/images/IconoPDF.svg"),

                                    ),

                                    SizedBox(

                                      height: altoFloatingActionButton * 0.1,

                                      width: anchoFloatingActionButton,

                                    ),

                                    Container(

                                      height: altoFloatingActionButton * 0.10,

                                      width: anchoFloatingActionButton,

                                      alignment: Alignment.center,

                                      child: Text(

                                        datosComprobante["nombre"],

                                        textAlign: TextAlign.center,

                                        overflow: TextOverflow.ellipsis,

                                        maxLines: 1,

                                        style: const TextStyle(

                                            fontWeight: FontWeight.bold

                                        ),

                                      ),

                                    ),

                                    Container(

                                      height: altoFloatingActionButton * 0.10,

                                      width: anchoFloatingActionButton,

                                      alignment: Alignment.center,

                                      child: Text(

                                        "${fechaSubida.day}/${fechaSubida.month}/${fechaSubida.year}",

                                        textAlign: TextAlign.center,

                                        overflow: TextOverflow.ellipsis,

                                        maxLines: 1,

                                        style: const TextStyle(

                                            fontWeight: FontWeight.bold

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

    double altoAppBar = alto * 0.2;

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

                leading: Container(

                  height: altoAppBar,

                  width: ancho * 0.1,

                  padding: const EdgeInsets.all(20),

                  alignment: Alignment.topCenter,

                  child: IconButton(onPressed: (){



                  }, icon: const Icon(Icons.arrow_circle_left, color: Colors.white)),

                ),

                flexibleSpace: Container(

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

                  child: GestureDetector(

                    onTap: () {

                      print("Tapeado");

                    },

                    child: CircleAvatar(

                      foregroundColor: Colors.transparent,

                      backgroundColor: (snapshot == null) ? Colors.white : Colors.transparent,

                      radius: 70,

                      child: (snapshot.data == null) ? Image.asset("/images/Profile.png", fit: BoxFit.fill) : ClipOval(

                        clipBehavior: Clip.antiAliasWithSaveLayer,

                        child: Image.memory(snapshot.data!, fit: BoxFit.cover),

                      ),

                    ),

                  )

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

                  bool? operacionRealizada = await widget.estudiante.cargarComprobante();

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