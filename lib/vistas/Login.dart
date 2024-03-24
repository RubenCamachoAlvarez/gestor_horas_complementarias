import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {


  const LoginWidget({super.key});

  State<LoginWidget> createState() => LoginWidgetState();



}

class LoginWidgetState extends State<LoginWidget> {

  LoginWidgetState();

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Center(

          child: Text("Gestor de horas complementarias",

            textAlign: TextAlign.center,

            style: TextStyle(

              color: Colors.white,

            ),

          ),

        ),

        backgroundColor: Colors.red

      ),

    );

  }


}