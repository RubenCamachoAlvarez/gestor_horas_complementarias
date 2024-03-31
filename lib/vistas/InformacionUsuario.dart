
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

    return Column(

      mainAxisAlignment: MainAxisAlignment.center,

      crossAxisAlignment: CrossAxisAlignment.center,

      children: <Widget>[

        ListView(

          padding: EdgeInsets.all(100),

          children: <Widget> []

        ),

      ],

    );

  }

}