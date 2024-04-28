import "dart:typed_data";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart";
import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
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

  @override
  Widget build(BuildContext context) {

    double altoEncabezado = MediaQuery.of(context).size.height * 0.25;

    double altoCuerpo = MediaQuery.of(context).size.height * 0.75;

    double ancho = MediaQuery.of(context).size.width;

    ValueNotifier<double> notificadorValor = ValueNotifier(0);

    int horasObligatoriasCarrera = 0;

    Color temaComponentesInterfaz = DatosApp.colorApp;

    return StreamBuilder(

      stream: (widget.usuario is Estudiante) ? (widget.usuario as Estudiante).obtenerComprobantesAceptados() : null,

      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.active){

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

                                    decoration: BoxDecoration(

                                      color: temaComponentesInterfaz,

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

                                    ListTile(

                                      leading: Icon(CupertinoIcons.person_alt, color: temaComponentesInterfaz),

                                      horizontalTitleGap: 30,

                                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

                                      title: const Text("Nombre"),

                                      subtitle: Text(widget.usuario.nombreCompleto()),

                                      titleTextStyle: TextStyle(

                                          fontWeight: FontWeight.bold,

                                          color: temaComponentesInterfaz

                                      ),

                                      tileColor: Colors.grey[100],

                                      shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(15)

                                      ),

                                      subtitleTextStyle: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                        color: Colors.black,

                                      ),

                                    ),

                                    SizedBox(

                                      height: altoCuerpo * 0.025,

                                    ),

                                    ListTile(

                                      leading: Icon(Icons.calendar_month, color: temaComponentesInterfaz,),

                                      horizontalTitleGap: 30,

                                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

                                      title: const Text("Fecha de nacimiento"),

                                      subtitle: Text(widget.usuario.cadenaFechaNacimiento()),

                                      titleTextStyle: TextStyle(

                                          fontWeight: FontWeight.bold,

                                          color: temaComponentesInterfaz

                                      ),

                                      tileColor: Colors.grey[100],

                                      shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(15)

                                      ),

                                      subtitleTextStyle: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                        color: Colors.black,

                                      ),

                                    ),

                                    SizedBox(

                                      height: altoCuerpo * 0.025,

                                    ),

                                    ListTile(

                                      leading: Icon(CupertinoIcons.book_fill, color: temaComponentesInterfaz,),

                                      horizontalTitleGap: 30,

                                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

                                      title: const Text("Carrera"),

                                      subtitle: Text(widget.usuario.carrera.id),

                                      titleTextStyle: TextStyle(

                                          fontWeight: FontWeight.bold,

                                          color: temaComponentesInterfaz

                                      ),

                                      tileColor: Colors.grey[100],

                                      shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(15)

                                      ),

                                      subtitleTextStyle: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                        color: Colors.black,

                                      ),

                                    ),

                                    SizedBox(

                                      height: altoCuerpo * 0.025,

                                    ),

                                    ListTile(

                                      leading: Icon(CupertinoIcons.alarm_fill, color: temaComponentesInterfaz,),

                                      horizontalTitleGap: 30,

                                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

                                      title: const Text("Ocupación"),

                                      subtitle: Text(widget.usuario.rol.id),

                                      titleTextStyle: TextStyle(

                                          fontWeight: FontWeight.bold,

                                          color: temaComponentesInterfaz

                                      ),

                                      tileColor: Colors.grey[100],

                                      shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(15)

                                      ),

                                      subtitleTextStyle: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                        color: Colors.black,

                                      ),

                                    ),

                                    SizedBox(

                                      height: altoCuerpo * 0.025,

                                    ),

                                    ListTile(

                                      leading: Icon(CupertinoIcons.number_circle_fill, color: temaComponentesInterfaz,),

                                      horizontalTitleGap: 30,

                                      trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

                                      title: Text("Número de ${(widget.usuario.rol == Roles.ESTUDIANTE) ? "cuenta" : "trabajador"}"),

                                      subtitle: Text(widget.usuario.numero),

                                      titleTextStyle: TextStyle(

                                          fontWeight: FontWeight.bold,

                                          color: temaComponentesInterfaz

                                      ),

                                      tileColor: Colors.grey[100],

                                      shape: RoundedRectangleBorder(

                                          borderRadius: BorderRadius.circular(15)

                                      ),

                                      subtitleTextStyle: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                        color: Colors.black,

                                      ),

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

                              backgroundImage: ((widget.usuario.imagenPerfil == null) ? const AssetImage("assets/images/ImagenUsuario.png") : null) as ImageProvider<Object>,

                              radius: 60,

                              backgroundColor: Colors.white,

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