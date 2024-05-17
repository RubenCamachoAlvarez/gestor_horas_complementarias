import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/DatosApp.dart';

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

      darkTheme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black45),

        useMaterial3: true

      ),

      home: DatosApp.navegador.pagina,

      //home: const LoginWidget(),

      //home: SeccionEncargadoWidget(encargado: (Sesion.usuario! as Encargado)),

      //home: SeccionEstudianteWidget(estudiante: (Sesion.usuario! as Estudiante),),

      debugShowCheckedModeBanner: false,

    );

  }

}