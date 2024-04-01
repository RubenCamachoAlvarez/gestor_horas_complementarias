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

  //Inicializacion Firebase para utilizarla en esta aplicacion.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Sesion.iniciarSesion("421084898", "");

  //Llamada para comenzar la ejecucion de la aplicacion
  runApp(const App());
}