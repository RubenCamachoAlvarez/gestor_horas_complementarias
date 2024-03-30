
import 'package:flutter/material.dart';

class BarraProgresoEstudianteWidget extends StatefulWidget {

  const BarraProgresoEstudianteWidget({super.key});

  @override

  State<BarraProgresoEstudianteWidget> createState() => BarraProgresoEstudianteState();

}

class BarraProgresoEstudianteState extends State<BarraProgresoEstudianteWidget> {

  BarraProgresoEstudianteState();

  @override
  Widget build(BuildContext context) {

    return Container(

      color: Colors.amber,

      alignment: Alignment.center,

      child:

      ListView(

        children: const <Widget>[

          Text("Hola mundo", textAlign: TextAlign.center,),

          Text("Hola mundo 2"),

          Text("Hola mundo 3"),

        ],

      )

    );

  }

}

