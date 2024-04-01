import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OperacionesArchivos {

  static Future<List<String>?> leerArchivoCSV() async {

    FilePickerResult? archivoSeleccionado = await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: <String>["csv"]

    );

    if(archivoSeleccionado != null) {

      String contenidoArchivo = "";

      if (Platform.isAndroid) {

        try {

            File archivo = File(archivoSeleccionado.files.first.path!);

            //Posible error en Android
            contenidoArchivo = archivo.readAsStringSync();

        }catch(e){}

      }else {

        Uint8List bytesContenidoArchivo = archivoSeleccionado.files.first.bytes!;

        contenidoArchivo = utf8.decode(bytesContenidoArchivo);

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

      Uint8List bytesArchivo = archivoSeleccionado.bytes!;

      String nombreArchivo = archivoSeleccionado.name;

      Timestamp fechaSubida = Timestamp.now();

      return {

        "nombre" : nombreArchivo,

        "bytes" : bytesArchivo,

        "fecha_subida" : fechaSubida,

      };

    }

  }


}