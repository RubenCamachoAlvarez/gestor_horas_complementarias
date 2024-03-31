
import 'package:flutter/material.dart';

class InformacionUsuarioWidget extends StatefulWidget {

  const InformacionUsuarioWidget({super.key});

  @override
  State<InformacionUsuarioWidget> createState() => InformacionUsuarioState();

}

class InformacionUsuarioState extends State<InformacionUsuarioWidget> {

  InformacionUsuarioState();

  @override
  Widget build(BuildContext context) {

    return ListView(

      padding: EdgeInsets.all(0),

      children: [

        Image.asset("assets/Imagen_Usuario.png", width: 512, height: 512 ),

        SizedBox(height: 20,),

        Text("Nombre completo", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),

        SizedBox(height: 20,),

        Text("Numero de cuenta", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

        SizedBox(height: 20,),

        Text("Carrera", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

        SizedBox(height: 20,),

        Text("Fecha de nacimiento", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

      ]

    );

  }

}