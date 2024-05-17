import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/App.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestor_de_horas_complementarias/datos/DatosApp.dart';
import 'package:gestor_de_horas_complementarias/vistas/Login.dart';
import 'firebase_options.dart';
import 'dart:core';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  //Inicializacion Firebase para utilizarla en esta aplicacion.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DatosApp.navegador.agregarVista(const LoginWidget());

  runApp(const App());
}