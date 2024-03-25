import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/App.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:core';

void main() async {

  //Inicializacion Firebase para utilizarla en esta aplicacion.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Llamada para comenzar la ejecucion de la aplicacion
  runApp(const App());
}