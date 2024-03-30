import 'dart:convert';
//import 'dart:html' as html;
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';

class OperacionesArchivos {

  static Future<Set<Estudiante>?> leer_archivo_csv() async {

    FilePickerResult? archivoSeleccionado = await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: <String>["csv"]

    );

    if(archivoSeleccionado != null) {

      String contenidoArchivo = "";

      if (Platform.isAndroid) {

        try {

            File archivo = File(archivoSeleccionado.files.first.path!);

            //Posible error en android
            contenidoArchivo = archivo.readAsStringSync();

        }catch(e){}

      }/*else if (html.window != null) {*/
      else {

        Uint8List bytesContenidoArchivo = archivoSeleccionado.files.first.bytes!;

        contenidoArchivo = utf8.decode(bytesContenidoArchivo);

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

  static Future<Comprobante?> cargarComprobantePDF() async{

    FilePickerResult? seleccion = await FilePicker.platform.pickFiles(

      type: FileType.custom,

      allowedExtensions: const <String>["pdf"]

    );

    if(seleccion != null) {

      PlatformFile archivoSeleccionado = seleccion.files.first;

      Uint8List bytesArchivo = archivoSeleccionado.bytes!;

      String nombreArchivo = archivoSeleccionado.name;

      Timestamp fechaSubida = Timestamp.now();

      DocumentReference<Map<String, dynamic>> propietario = BaseDeDatos.conexion.collection("Usuarios").doc(Usuario.numero);
      
      return Comprobante(nombre: nombreArchivo, bytes: bytesArchivo, propietario: propietario, fechaSubida: fechaSubida, statusComprobante: StatusComprobante.PENDIENTE);

    }

  }


}