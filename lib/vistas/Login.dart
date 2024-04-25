import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'package:gestor_de_horas_complementarias/vistas/DashboardEncargado.dart';
import 'package:gestor_de_horas_complementarias/vistas/DashboardEstudiante.dart';

class LoginWidget extends StatefulWidget {

  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => LoginWidgetState();

}

class LoginWidgetState extends State<LoginWidget> {

  LoginWidgetState();

  TextEditingController controladorCampoUsuario = TextEditingController();

  TextEditingController controladorCampoPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double altoAppBar = MediaQuery.of(context).size.height * 0.3;

    double altoBody = MediaQuery.of(context).size.height * 0.7;

    return Scaffold(

      body: SingleChildScrollView(

        clipBehavior: Clip.antiAliasWithSaveLayer,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            ClipPath(

                clipper: CustomClipPath(),

                clipBehavior: Clip.antiAliasWithSaveLayer,

                child: Container(

                  padding: const EdgeInsets.all(30),

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

                  height: altoAppBar,

                  child: Center(

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,

                        mainAxisAlignment: MainAxisAlignment.start,

                        children: [

                          Image.asset("assets/images/logo-fes.png"),

                          Padding(

                            padding: EdgeInsets.all(altoAppBar * 0.10),

                            child: const Text(

                              "Sistema de registro de horas completamentarias",

                              maxLines: 2,

                              textAlign: TextAlign.center,

                              overflow: TextOverflow.visible,

                              softWrap: true,

                              style: TextStyle(

                                  color: Colors.white,

                                  fontWeight: FontWeight.bold,

                                  fontSize: 20

                              ),

                            ),

                          )

                        ],

                      )

                  ),

                )

            ),

            Container(

              height: altoBody,

              padding: const EdgeInsets.all(40),

              child: Center(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    TextField(

                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      textAlign: TextAlign.center,

                      textAlignVertical: TextAlignVertical.center,

                      showCursor: false,

                      controller: controladorCampoUsuario,

                      decoration: InputDecoration(

                        hintTextDirection: TextDirection.ltr,

                        hintText: "Usuario",

                        hintMaxLines: 1,

                        hintFadeDuration: const Duration(

                          milliseconds: 200

                        ),

                        hintStyle: const TextStyle(

                          fontWeight: FontWeight.bold,

                          color: Colors.black

                        ),

                        prefixIcon: const Icon(

                          Icons.person,

                          color: Colors.black,

                        ),

                        filled: true,

                        fillColor: Colors.grey.withOpacity(0.1),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide.none

                        )

                      ),

                    ),

                    SizedBox(

                      height: altoBody * 0.05,

                    ),

                    TextField(

                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      textAlign: TextAlign.center,

                      textAlignVertical: TextAlignVertical.center,

                      showCursor: false,

                      obscureText: true,

                      obscuringCharacter: "*",

                      controller: controladorCampoPassword,

                      decoration: InputDecoration(

                        hintTextDirection: TextDirection.ltr,

                        hintText: "Contraseña",

                        hintMaxLines: 1,

                        hintFadeDuration: const Duration(

                            milliseconds: 200

                        ),

                        hintStyle: const TextStyle(

                            fontWeight: FontWeight.bold,

                            color: Colors.black

                        ),

                        prefixIcon: const Icon(

                          Icons.info,

                          color: Colors.black,

                        ),

                        filled: true,

                        fillColor: Colors.grey.withOpacity(0.1),

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(10),

                          borderSide: BorderSide.none

                        )

                      ),

                    )

                  ],

                ),

              ),

            )

          ],

        ),

      )

    );

  }

}

class CustomClipPath extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {

    double width = size.width;

    double height = size.height;

    final path = Path();

    path.lineTo(0, height * 0.8);

    path.quadraticBezierTo(width * 0.7, height, width, height * 0.9);

    path.lineTo(width, 0);

    path.close();

    return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {

    return false;

  }

  

}