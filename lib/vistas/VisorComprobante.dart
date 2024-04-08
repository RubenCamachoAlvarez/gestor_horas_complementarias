import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class VisorComprobanteWidget extends StatefulWidget {

  VisorComprobanteWidget({super.key, required this.comprobante});

  Comprobante comprobante;

  @override

  State<VisorComprobanteWidget> createState() => VisorComprobanteState();


}

class VisorComprobanteState extends State<VisorComprobanteWidget> {

  VisorComprobanteState();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.comprobante.nombre),

        centerTitle: true,

        leading: IconButton(

          onPressed: () {

            print("Regresar");

            Navigator.pop(context);

          },

          icon: const Icon(Icons.arrow_back_ios)

        ),

      ),

      body:

        Center(

          child: SfPdfViewer.memory(widget.comprobante.bytes),

        )
      ,

    );

  }



}