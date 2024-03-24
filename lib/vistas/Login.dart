import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {


  const LoginWidget({super.key});

  State<LoginWidget> createState() => LoginWidgetState();



}

class LoginWidgetState extends State<LoginWidget> {

  LoginWidgetState();

  Container contenedorPrincipal = Container(color: Colors.orange,

    child: Column(

      mainAxisAlignment: MainAxisAlignment.center,



      children: [



      ],

    ),

  );

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body:

        Container(

          width: double.infinity,

          height: double.infinity,

          color: Colors.white,

          child:

            Center(

                child:

                Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[

                    Container(

                      width: 400,

                      height: 600,
                      
                      padding: EdgeInsets.all(50),

                      decoration: BoxDecoration(

                        color: Colors.white,
                        
                        borderRadius: BorderRadius.circular(20),

                        boxShadow: <BoxShadow>[

                          BoxShadow(

                            color: Colors.grey.withOpacity(0.8),

                            spreadRadius: 5,

                            blurRadius: 5,

                            offset: const Offset(0, 3),

                          )

                        ],

                      ),

                      child: Center(

                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.center,

                          mainAxisSize: MainAxisSize.max,

                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: <Widget>[

                            TextField(

                              decoration:

                                InputDecoration(

                                  labelText: "Usuario",
                                  
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))

                                ),

                            ),

                            SizedBox(height: 20),

                            TextField(

                              decoration:

                              InputDecoration(

                                  labelText: "Contraseña",

                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))

                              ),

                            ),

                          ],

                        ),

                      ),

                    )

                  ]

                )

            ),

        )


    );

  }


}