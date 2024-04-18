import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_de_horas_complementarias/App.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'firebase_options.dart';
import 'dart:core';

void main() async {

  /*SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(

    statusBarColor: Colors.transparent,

    statusBarIconBrightness: Brightness.dark

  ));*/

  WidgetsFlutterBinding.ensureInitialized();

  //Inicializacion Firebase para utilizarla en esta aplicacion.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //await Sesion.iniciarSesion("421084898", "");
  
  await Sesion.iniciarSesion("56789038", "");

  //BaseDeDatos.almacenamiento.useStorageEmulator("10.0.2.2", 9199);

  //Llamada para comenzar la ejecucion de la aplicacion
  runApp(const App());
}