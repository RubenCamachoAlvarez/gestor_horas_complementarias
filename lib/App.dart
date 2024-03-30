import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/vistas/DashboardEstudiante.dart';
import 'package:gestor_de_horas_complementarias/vistas/Login.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: "Gestor de horas complementarias",

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        useMaterial3: true,
      ),

      //home: const LoginWidget(),

      home: const DashboardEstudianteWidget(),

      debugShowCheckedModeBanner: false,

    );

  }

}