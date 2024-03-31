
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';

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

        /*
        Image.asset("assets/Imagen_Usuario.png", width: 512, height: 512 ),

        SizedBox(height: 20,),

        Text("${Usuario.nombre} ${Usuario.apellidoPaterno} ${Usuario.apellidoMaterno}", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),

        SizedBox(height: 20,),

        Text("${Usuario.numero}", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

        SizedBox(height: 20,),

        Text("${Usuario.carrera!.id}", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

        SizedBox(height: 20,),

        Text("${Usuario.fechaNacimiento!.day}/${Usuario.fechaNacimiento!.month}/${Usuario.fechaNacimiento!.year}", textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        */
      ]

    );

  }

}