import 'dart:convert';
import 'dart:html' as html;
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';

class OperacionesArchivos {

  static Future<Set<Estudiante>?> leer_archivo_csv() async {

    FilePickerResult? archivoSeleccionado = await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: <String>["csv"]

    );

    if(archivoSeleccionado != null) {

      String contenidoArchivo = "";

      if (html.window != null) {

        Uint8List bytesContenidoArchivo = archivoSeleccionado.files.first.bytes!;

        contenidoArchivo = utf8.decode(bytesContenidoArchivo);

      } else if (Platform.isAndroid) {

        File archivo = File(archivoSeleccionado.files.first.path!);

        //Posible error en android
        contenidoArchivo = archivo.readAsStringSync();

      }

      Set<Estudiante> estudiantes = <Estudiante>{};

      for(String datosEstudiante in contenidoArchivo.trim().split("\n")) {

        List<String> campos = datosEstudiante.split(",");

        List<String> camposFechaNacimiento = campos[4].trim().split("/");

        Estudiante estudiante = Estudiante(numeroCuenta: campos[0], nombre: campos[1], apellidoPaterno: campos[2], apellidoMaterno: campos[3],

            fechaNacimiento: DateTime(int.parse(camposFechaNacimiento[2]), int.parse(camposFechaNacimiento[1]), int.parse(camposFechaNacimiento[0])));

        estudiantes.add(estudiante);

      }

      return estudiantes;

    }else{

      return null;

    }

  }

  static Future<Image?> cargarImagen() async {

    FilePickerResult? imagenSeleccionada = await FilePicker.platform.pickFiles(

      type: FileType.image

    );

    if(imagenSeleccionada != null) {

      Uint8List bytesImagen = imagenSeleccionada.files.first.bytes!;

      ui.Image imagen = await decodeImageFromList(bytesImagen);

      return Image.memory(bytesImagen,

        width: imagen.width.toDouble(),

        height: imagen.height.toDouble(),

      );


    }else{

      return null;

    }

  }

}