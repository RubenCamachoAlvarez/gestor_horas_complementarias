import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';

class LoginWidget extends StatefulWidget {

  const LoginWidget({super.key});

  State<LoginWidget> createState() => LoginWidgetState();

}

class LoginWidgetState extends State<LoginWidget> {

  LoginWidgetState();

  final TextEditingController campoUsuario = TextEditingController();

  final TextEditingController campoPassword = TextEditingController();

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body:

        LayoutBuilder(

          builder: (context, constraints) {

            double ancho = constraints.maxWidth;

            double alto = constraints.maxHeight;

            double anchoContenedor = ancho * 0.6;

            double altoContenedor = alto * 0.8;

            return Center(

              child: Container(

                width: anchoContenedor,

                height: altoContenedor,
                
                padding: const EdgeInsets.all(30),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius: BorderRadius.circular(20),

                  boxShadow: <BoxShadow> [

                    BoxShadow(

                      color:Colors.grey.withOpacity(0.5),

                      spreadRadius: 5,

                      blurRadius: 5,

                      offset: const Offset(0, 3),

                      blurStyle: BlurStyle.normal

                    )

                  ],

                ),
                
                child: Center(
                  
                  child: Column(
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: <Widget>[

                      const Text("Sistema de horas complementarias",

                        textAlign: TextAlign.center,

                        style: TextStyle(

                          color: Colors.teal,

                          fontSize: 50,

                          fontWeight: FontWeight.bold

                        ),

                      ),

                      SizedBox(height: altoContenedor * 0.05),
                      
                      TextField(
                        
                        decoration: InputDecoration(
                          
                          labelText: "Usuario",

                          labelStyle: const TextStyle(

                            fontWeight: FontWeight.bold

                          ),
                          
                          border: OutlineInputBorder(
                            
                            borderRadius: BorderRadius.circular(10)
                            
                          ),
                          
                        ),

                        textAlign: TextAlign.center,

                        controller: campoUsuario,
                        
                      ),

                      SizedBox(height: altoContenedor * 0.03),
                      
                      TextField(

                        decoration: InputDecoration(

                          labelText: "Contraseña",

                          labelStyle: const TextStyle(

                            fontWeight: FontWeight.bold

                          ),

                          border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(10)

                          ),

                        ),

                        textAlign: TextAlign.center,

                        controller: campoPassword,

                      ),

                      SizedBox(height: altoContenedor * 0.03),

                      FloatingActionButton(

                        onPressed: () {

                          String numeroCuenta = campoUsuario.value.text;

                          String password = campoPassword.value.text;

                          print("El numero de cuenta es: $numeroCuenta");

                          print("El password es: $password");

                          BaseDeDatos.conexion.collection("Usuarios").doc(numeroCuenta).get().then((value) => {

                            if(value.exists) {

                              print("Acceso correcto")

                            }else{

                              print("Acceso no satisfactorio")

                          }

                          });

                        },

                        child: const Text(

                          "Iniciar sesion",

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontWeight: FontWeight.bold

                          ),

                        ),

                      )
                      
                    ],
                    
                  ),
                  
                ),

              ),

            );

          },

        )

    );

  }


}