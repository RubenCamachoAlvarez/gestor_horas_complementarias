import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  TextEditingController controladorCampoNumero = TextEditingController();

  TextEditingController controladorCampoPassword = TextEditingController();

  String mensajeErrorCampoNumero = "";

  String mensajeErrorCampoPassword = "";

  bool campoPasswordSoloLectura = true;

  bool botonIniciarSesionHabilitado = false;

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

              padding: const EdgeInsets.all(50),

              child: Center(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [

                    Expanded(

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          TextField(

                            clipBehavior: Clip.antiAliasWithSaveLayer,

                            textAlign: TextAlign.center,

                            textAlignVertical: TextAlignVertical.center,

                            showCursor: true,

                            controller: controladorCampoNumero,

                            keyboardType: TextInputType.phone,

                            inputFormatters: [

                              FilteringTextInputFormatter.digitsOnly,

                              LengthLimitingTextInputFormatter(9),

                              FormateadorNumeroIngreso()

                            ],

                            onChanged: (value) {

                              setState(() {

                                if(controladorCampoNumero.text.isEmpty) {

                                  mensajeErrorCampoNumero = "Ingresa un número de cuenta/trabajador de la FES Aragon";

                                  controladorCampoPassword.text = "";

                                  mensajeErrorCampoPassword = "";

                                  campoPasswordSoloLectura = true;

                                  botonIniciarSesionHabilitado = false;

                                }else if(controladorCampoNumero.text.length < 8) {

                                  mensajeErrorCampoNumero = "Ingresa un número de almenos 8 dígitos";

                                  controladorCampoPassword.text = "";

                                  mensajeErrorCampoPassword = "";

                                  campoPasswordSoloLectura = true;

                                  botonIniciarSesionHabilitado = false;

                                }else{

                                  mensajeErrorCampoNumero = "";

                                  campoPasswordSoloLectura = false;

                                }

                              });

                            },

                            decoration: InputDecoration(

                              error: Center(

                                child: Text(

                                  mensajeErrorCampoNumero,

                                  textAlign: TextAlign.center,

                                  style: const TextStyle(

                                    fontWeight: FontWeight.bold,

                                    color: Colors.red

                                  ),

                                ),

                              ),

                              errorMaxLines: 1,

                              hintTextDirection: TextDirection.ltr,

                              hintText: "Número de cuenta",

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

                            readOnly: campoPasswordSoloLectura,

                            canRequestFocus: !campoPasswordSoloLectura,

                            onChanged: (value) {

                              setState(() {

                                if(value.isEmpty) {

                                  botonIniciarSesionHabilitado = false;

                                  mensajeErrorCampoPassword = "Ingresa una contraseña";

                                }else{

                                  botonIniciarSesionHabilitado = true;

                                  mensajeErrorCampoPassword = "";

                                }

                              });

                            },

                            clipBehavior: Clip.antiAliasWithSaveLayer,

                            textAlign: TextAlign.center,

                            textAlignVertical: TextAlignVertical.center,

                            showCursor: true,

                            obscureText: true,

                            obscuringCharacter: "*",

                            controller: controladorCampoPassword,

                            decoration: InputDecoration(

                              error: Center(

                                child: Text(

                                  mensajeErrorCampoPassword,

                                  textAlign: TextAlign.center,

                                  style: const TextStyle(

                                    fontWeight: FontWeight.bold,

                                    color: Colors.red

                                  ),

                                ),

                              ),

                              errorMaxLines: 1,

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

                    Expanded(

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          ElevatedButton(

                            onPressed: botonIniciarSesionHabilitado ? () {

                              print("Boton de login");

                            } : null,

                            style: ElevatedButton.styleFrom(
                              
                              backgroundColor: Colors.orange,
                              
                              shape: RoundedRectangleBorder(
                                
                                borderRadius: BorderRadius.circular(15)
                                
                              ),

                              minimumSize: const Size(double.infinity, 50),

                              disabledBackgroundColor: Colors.orange[200]
                              
                            ),

                            child: const Text(

                              "Iniciar sesion",

                              textAlign: TextAlign.center,

                              style: TextStyle(

                                fontWeight: FontWeight.bold,

                                color: Colors.white,

                              ),

                            )


                          )

                        ],

                      )

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

class FormateadorNumeroIngreso extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    final String nuevoNumero = newValue.text;

    return newValue.copyWith(

      text: nuevoNumero,

      selection: TextSelection.collapsed(offset: nuevoNumero.length)

    );

  }
  
  
  
}