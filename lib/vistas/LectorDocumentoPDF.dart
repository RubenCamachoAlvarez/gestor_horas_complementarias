import "package:flutter/material.dart";
import "package:gestor_de_horas_complementarias/datos/Comprobante.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

class LectorDocumentoPDFWidget extends StatefulWidget{

  LectorDocumentoPDFWidget({super.key, required this.comprobante});

  Comprobante comprobante;

  @override
  State<LectorDocumentoPDFWidget> createState() => LectorDocumentoPDFState();

}

class LectorDocumentoPDFState extends State<LectorDocumentoPDFWidget> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(

          onPressed: (){

            Navigator.of(context).pop();

          },

          icon: Icon(Icons.arrow_back_ios_new, color: Colors.grey[400]),

        ),

        actions: [

          IconButton(

            onPressed: (){},

            icon: Icon(Icons.info, color: Colors.grey[400])

          )

        ],

        title: Text(widget.comprobante.nombre,

          textAlign: TextAlign.center,

          maxLines: 1,

          overflow: TextOverflow.ellipsis,

          style: const TextStyle(

            color: Colors.black,

            fontWeight: FontWeight.bold

          ),

        ),

        backgroundColor: Colors.white

      ),

      body: SfPdfViewer.memory(widget.comprobante.bytes)

    );

  }

}