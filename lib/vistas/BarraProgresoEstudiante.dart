import 'package:flutter/material.dart';

class BarraProgresoEstudianteWidget extends StatefulWidget {

  const BarraProgresoEstudianteWidget({super.key});

  @override

  State<BarraProgresoEstudianteWidget> createState() => BarraProgresoEstudianteState();

}

class BarraProgresoEstudianteState extends State<BarraProgresoEstudianteWidget> {

  BarraProgresoEstudianteState();

  double? valorProgreso = null;

  String mensajeProgreso = "";

  @override

  void initState() {

    super.initState();

    //Aqui todo el codigo

    Future.delayed(Duration(seconds:1), () {

      setState(() {

        valorProgreso = 0.5;

        mensajeProgreso = "120 horas de 480 horas\n\n50%";

      });

    });

  }

  @override
  Widget build(BuildContext context) {

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[

        SizedBox(

          height: 50,

        ),

        Expanded(

          child: ListView(

            shrinkWrap: true,

            padding: EdgeInsets.all(150),

            children: <Widget>[

              Column(

                mainAxisAlignment: MainAxisAlignment.center,

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  CircularProgressIndicator(

                    color: Colors.red,

                    backgroundColor: Colors.grey,

                    //value: 0.6,

                    value: valorProgreso,

                    strokeWidth: 20,

                    strokeAlign: 10,

                  ),

                  SizedBox(

                    height: 200,

                  ),


                  Text(mensajeProgreso,

                    textAlign: TextAlign.center,

                    style: TextStyle(

                      color: Colors.black,

                      fontWeight: FontWeight.bold,

                      fontSize: 30

                    ),

                  ),

                ],

              ),

            ],

          ),

        ),

      ]

    );

  }

}

