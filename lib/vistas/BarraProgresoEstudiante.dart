
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class BarraProgresoEstudianteWidget extends StatefulWidget {

  const BarraProgresoEstudianteWidget({super.key});

  @override

  State<BarraProgresoEstudianteWidget> createState() => BarraProgresoEstudianteState();

}

class BarraProgresoEstudianteState extends State<BarraProgresoEstudianteWidget> {

  BarraProgresoEstudianteState();

  @override
  Widget build(BuildContext context) {

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[

        Expanded(

          child: ListView(
            
            padding: EdgeInsets.all(120),

            children: <Widget>[

              Column(

                children: [

                  CircularProgressIndicator(

                      color: Colors.red,

                      backgroundColor: Colors.grey,

                      value: 0.6,

                      strokeWidth: 20,

                      strokeAlign: 10,

                    )

                ],

              )



            ],

          ),

        )

      ]

    );

  }

}

