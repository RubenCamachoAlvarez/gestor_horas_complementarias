import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'package:http/http.dart';

class OperacionesArchivos {

  static Future<List<String>?> leerArchivoCSV() async {

    FilePickerResult? archivoSeleccionado = await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: <String>["csv"]

    );

    if(archivoSeleccionado != null) {

      String contenidoArchivo = "";

      if(kIsWeb) { //Se ejecuta cuando es aplicación web.

        Uint8List bytesContenidoArchivo = archivoSeleccionado.files.first.bytes!;

        contenidoArchivo = utf8.decode(bytesContenidoArchivo);

      }else if (Platform.isAndroid) { //Se ejecuta cuando es aplicación Android.

        try {

            File archivo = File(archivoSeleccionado.files.first.path!);

            //Posible error en Android
            contenidoArchivo = archivo.readAsStringSync();

        }catch(e){

          print("Error: $e"); //Cuando se suscita un error esta parte del catch se ejecuta.

        }

      }

      return contenidoArchivo.trim().split("\n");

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

  static Future<Map<String, dynamic>?> seleccionarComprobantePDF() async{

    FilePickerResult? seleccion = await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: const <String>["pdf"]

    );

    if(seleccion != null) {

      PlatformFile archivoSeleccionado = seleccion.files.first;

      String nombreArchivo = archivoSeleccionado.name;

      Timestamp fechaSubida = Timestamp.now();

      late Uint8List bytesArchivo;

      if(kIsWeb) { //Cuando el código se ejecuta en una plataforma web.

        bytesArchivo = archivoSeleccionado.bytes!;

      }else if(Platform.isAndroid) { //Cuando el código se ejecuta en un dispositivo Android.

        bytesArchivo = File(archivoSeleccionado.path!).readAsBytesSync();

      }

      return {

        "nombre" : nombreArchivo,

        "bytes" : bytesArchivo,

        "fecha_subida" : fechaSubida,

      };

    }

  }


}