import "dart:typed_data";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/datos/Usuario.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/valores_asignables/Carreras.dart";
import "package:gestor_de_horas_complementarias/valores_asignables/Roles.dart";

class PerfilUsuarioWidget extends StatefulWidget {

  PerfilUsuarioWidget({super.key, required this.usuario});

  Usuario usuario;

  @override
  State<PerfilUsuarioWidget> createState() => PerfilUsuarioState();

}

class PerfilUsuarioState extends State<PerfilUsuarioWidget> {

  PerfilUsuarioState();

ListTile crearTileList(SvgPicture icono, String titulo, String subtitulo) {

    return ListTile(

      leading: icono,

      horizontalTitleGap: 30,

      trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

      title: Text(titulo),

      subtitle: Text(subtitulo),

      titleTextStyle: TextStyle(

          fontWeight: FontWeight.bold,

          color: DatosApp.colorApp

      ),

      tileColor: Colors.grey[100],

      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(15)

      ),

      subtitleTextStyle: TextStyle(

        fontWeight: FontWeight.bold,

        color: Colors.grey[700],

      ),

    );

  }

  @override
  Widget build(BuildContext context) {

    double altoEncabezado = MediaQuery.of(context).size.height * 0.25;

    double altoCuerpo = MediaQuery.of(context).size.height * 0.75;

    double ancho = MediaQuery.of(context).size.width;

    ValueNotifier<double> notificadorValor = ValueNotifier(0);

    int horasObligatoriasCarrera = 0;

    return FutureBuilder(

      future: widget.usuario.cargarImagenUsuario(),

      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.done) {

          Uint8List? imagenUsuario = snapshot.data;

          return  StreamBuilder(

            stream: (widget.usuario is Estudiante) ? (widget.usuario as Estudiante).obtenerComprobantesAceptados() : null,

            builder: (context, snapshot) {

              if(snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.none){

                if(widget.usuario is Estudiante && snapshot.data != null) {

                  List<QueryDocumentSnapshot<Map<String, dynamic>>> consulta = snapshot.data!.docs;

                  int horasValidadas = 0;

                  consulta.forEach((datosComprobante) {

                    horasValidadas += (datosComprobante.data()["horas_validez"] as int);

                  });

                  notificadorValor.value = horasValidadas.toDouble();

                }

                return FutureBuilder(

                  future: Carreras.obtenerNumeroHorasObligatorias(widget.usuario.carrera),

                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.done) {


                      if(snapshot.data != null) {

                        horasObligatoriasCarrera = snapshot.data!;

                      }

                      return Scaffold(

                          body: SingleChildScrollView(

                            clipBehavior: Clip.antiAliasWithSaveLayer,

                            child: Center(

                                child: Stack(

                                  children: [

                                    Column(

                                      mainAxisAlignment: MainAxisAlignment.start,

                                      crossAxisAlignment: CrossAxisAlignment.center,

                                      children: [

                                        SizedBox(

                                          height: altoEncabezado,

                                          width: ancho,

                                          child: ClipPath(

                                            clipper: CustomClipperPath(),

                                            clipBehavior: Clip.antiAliasWithSaveLayer,

                                            child: Container(

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

                                              clipBehavior: Clip.antiAliasWithSaveLayer,

                                              width: ancho,

                                              child: (widget.usuario.imagenPerfil == null) ? null : Image.asset(

                                                "/images/Paisajes.jpeg",

                                                fit: BoxFit.fill,

                                              ),

                                            ),


                                          ),

                                        ),

                                        Material(

                                          color: Colors.white,

                                          child:  ListView(

                                            shrinkWrap: true,

                                            physics: const NeverScrollableScrollPhysics(),

                                            clipBehavior: Clip.antiAliasWithSaveLayer,

                                            padding: const EdgeInsets.only(

                                              right: 30,

                                              left: 30,

                                              top: 60,

                                              bottom: 30,

                                            ),

                                            children: [

                                              crearTileList(SvgPicture.asset("./assets/images/IconoPerfil.svg", width: 20, height: 20, color: DatosApp.colorApp,), "Nombre", widget.usuario.nombreCompleto()),

                                              SizedBox(

                                                height: altoCuerpo * 0.025,

                                              ),

                                              crearTileList(SvgPicture.asset("./assets/images/IconoCalendario.svg", width: 20, height: 20, color: DatosApp.colorApp,), "Fecha de nacimiento", widget.usuario.cadenaFechaNacimiento()),

                                              SizedBox(

                                                height: altoCuerpo * 0.025,

                                              ),

                                              crearTileList(SvgPicture.asset("./assets/images/IconoLibro.svg", width: 20, height: 20, color: DatosApp.colorApp,), "Carrera", widget.usuario.carrera.id),

                                              SizedBox(

                                                height: altoCuerpo * 0.025,

                                              ),

                                              crearTileList(SvgPicture.asset("./assets/images/IconoReloj.svg", width: 20, height: 20, color: DatosApp.colorApp,), "Ocupación", widget.usuario.rol.id),

                                              SizedBox(

                                                height: altoCuerpo * 0.025,

                                              ),

                                              crearTileList(SvgPicture.asset("./assets/images/IconoNumeral.svg", width: 20, height: 20, color: DatosApp.colorApp,), (widget.usuario.rol == Roles.ESTUDIANTE) ? "Número de cuenta" : "Número de trabajador", widget.usuario.numero),

                                              SizedBox(

                                                height: altoCuerpo * 0.025,

                                              ),

                                              Container(

                                                child: (widget.usuario.rol == Roles.ENCARGADO) ? null : Column(

                                                  crossAxisAlignment: CrossAxisAlignment.center,

                                                  mainAxisAlignment: MainAxisAlignment.start,

                                                  children: [

                                                    SizedBox(

                                                      height: altoCuerpo * 0.075,

                                                    ),

                                                    SizedBox(

                                                        height: ancho * 0.35,

                                                        child: DashedCircularProgressBar.aspectRatio(

                                                          aspectRatio: 3, // width ÷ height

                                                          valueNotifier: notificadorValor,

                                                          progress: notificadorValor.value,

                                                          maxProgress: horasObligatoriasCarrera.toDouble(),

                                                          corners: StrokeCap.round,

                                                          foregroundColor: Colors.blue,

                                                          backgroundColor: const Color(0xffeeeeee),

                                                          foregroundStrokeWidth: 15,

                                                          backgroundStrokeWidth: 25,

                                                          animation: true,

                                                          animationDuration: const Duration(seconds: 2),

                                                          child: Center(

                                                            child: ValueListenableBuilder(

                                                                valueListenable: notificadorValor,

                                                                builder: (_, double value, __) => Column(

                                                                  crossAxisAlignment: CrossAxisAlignment.center,

                                                                  mainAxisAlignment: MainAxisAlignment.center,

                                                                  children: [

                                                                    Text(

                                                                      '${value.toInt()}',

                                                                      style: const TextStyle(

                                                                          color: Colors.black,

                                                                          fontWeight: FontWeight.bold,

                                                                          fontSize: 25

                                                                      ),

                                                                    ),

                                                                    Text(

                                                                      (notificadorValor.value == 1) ? "hora" : "horas",

                                                                      style: const TextStyle(

                                                                          color: Colors.grey,

                                                                          fontWeight: FontWeight.bold,

                                                                          fontSize: 10

                                                                      ),

                                                                    ),

                                                                  ],

                                                                )

                                                            ),

                                                          ),

                                                        )

                                                    )

                                                  ],

                                                ),

                                              )

                                            ],

                                          ),

                                        )

                                      ],

                                    ),

                                    Positioned(

                                      right: ancho * 0.5 - 60,

                                      top: altoEncabezado * 0.60,

                                      child: CircleAvatar(

                                        foregroundColor: Colors.transparent,

                                        backgroundColor: Colors.transparent,

                                        radius: 60,

                                        child: (imagenUsuario == null) ? ClipOval(

                                          clipBehavior: Clip.antiAliasWithSaveLayer,

                                          child: SvgPicture.asset("./assets/images/PerfilUsuarioSeccionEncargado.svg", fit: BoxFit.fill,),

                                        ) : ClipOval(

                                          clipBehavior: Clip.antiAliasWithSaveLayer,

                                          child: Image.memory(imagenUsuario, fit: BoxFit.cover),

                                        ),

                                      ),

                                    ),

                                  ],

                                )

                            ),

                          ),

                          bottomSheet: (widget.usuario != Sesion.usuario) ? null : DraggableScrollableSheet(

                            maxChildSize: 0.3,

                            minChildSize: 0.03,

                            initialChildSize: 0.03,

                            expand: false,

                            snap: true,

                            builder: (context, scrollController) {

                              return DecoratedBox(

                                decoration: const BoxDecoration(

                                    color: Colors.white,

                                    boxShadow: [

                                      BoxShadow(

                                        color: Colors.black,

                                        blurRadius: 10,

                                        spreadRadius: 1,

                                        offset: Offset(0, 1),

                                      )

                                    ],

                                    borderRadius: BorderRadius.only(

                                        topLeft: Radius.circular(22),

                                        topRight: Radius.circular(22)

                                    )

                                ),

                                child: CustomScrollView(

                                    controller: scrollController,

                                    shrinkWrap: true,

                                    clipBehavior: Clip.antiAliasWithSaveLayer,

                                    physics: const AlwaysScrollableScrollPhysics(),

                                    slivers: [

                                      SliverToBoxAdapter(

                                        child: Padding(

                                          padding: const EdgeInsets.only(

                                              top: 30,

                                              left: 30,

                                              right: 30

                                          ),

                                          child: ElevatedButton(

                                            onPressed: () {

                                            },

                                            style: ElevatedButton.styleFrom(

                                                shape: RoundedRectangleBorder(

                                                    borderRadius: BorderRadius.circular(10)

                                                ),

                                                backgroundColor: Colors.grey[100]

                                            ),

                                            child: const Text(

                                              "Seleccionar foto de perfil",

                                              style: TextStyle(

                                                fontWeight: FontWeight.bold,

                                              ),

                                            ),

                                          ),

                                        ),

                                      ),

                                      SliverToBoxAdapter(

                                        child: Padding(

                                          padding: const EdgeInsets.only(

                                              top: 8,

                                              left: 30,

                                              right: 30

                                          ),

                                          child: ElevatedButton(

                                            onPressed: () {

                                            },

                                            style: ElevatedButton.styleFrom(

                                                shape: RoundedRectangleBorder(

                                                    borderRadius: BorderRadius.circular(10)

                                                ),

                                                backgroundColor: Colors.grey[100]

                                            ),

                                            child: const Text(

                                              "Seleccionar imagen de feed",

                                              style: TextStyle(

                                                fontWeight: FontWeight.bold,

                                              ),

                                            ),

                                          ),

                                        ),

                                      ),

                                      SliverToBoxAdapter(

                                        child: Padding(

                                          padding: const EdgeInsets.only(

                                              top: 8,

                                              left: 30,

                                              right: 30,

                                              bottom: 30

                                          ),

                                          child: ElevatedButton(

                                            onPressed: () {

                                            },
                                            style: ElevatedButton.styleFrom(

                                                shape: RoundedRectangleBorder(

                                                    borderRadius: BorderRadius.circular(10)

                                                ),

                                                backgroundColor: Colors.grey[100]

                                            ),

                                            child: const Text(

                                              "Seleccionar tema",

                                              style: TextStyle(

                                                fontWeight: FontWeight.bold,

                                              ),

                                            ),

                                          ),

                                        ),

                                      )

                                    ]

                                ),

                              );

                            },

                            controller: DraggableScrollableController(),

                          )

                      );

                    }

                    return Container(

                      alignment: Alignment.center,

                      child: const CircularProgressIndicator(),

                    );

                  },

                );

              }else{

                return Container(

                  alignment: Alignment.center,

                  child: const CircularProgressIndicator(),

                );

              }

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

}

class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {

    double ancho = size.width;

    double alto = size.height;

    final Path path = Path();

    path.lineTo(0, alto);

    path.quadraticBezierTo(ancho * 0.5, alto * 0.75, ancho, alto);

    path.lineTo(ancho, 0);

    path.close();

    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return false;

  }



}