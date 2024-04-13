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

  bool statusComprobante = false;

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

      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.send),

        onPressed: () {

          showModalBottomSheet(context: context,
            
            shape: const RoundedRectangleBorder(
              
              borderRadius: BorderRadius.only(

                topLeft: Radius.circular(20),

                topRight: Radius.circular(20),

              )
              
            ),

            builder: (context) =>  StatefulBuilder(

              builder: (context, setState) {

                print("Ejecutando esto");

                List<Widget> elementosBottomSheet = <Widget> [];

                elementosBottomSheet.add(

                  Switch(value: statusComprobante,

                    onChanged: (bool nuevoValor){

                      setState((){

                        statusComprobante = nuevoValor;

                      });

                    },

                    activeTrackColor: Colors.green,

                    inactiveThumbColor: Colors.white,

                    inactiveTrackColor: Colors.red,

                  )

                );

                late String mensajeBoton;

                late Color colorBoton;

                if(statusComprobante) {

                  mensajeBoton = "Aprobar comprobante";

                  colorBoton = Colors.green;

                }else{

                  mensajeBoton = "Rechazar comprobante";

                  colorBoton = Colors.red;

                }

                elementosBottomSheet.add(

                  Expanded(child:

                    Container(

                      alignment: Alignment.center,

                      child: TextField(

                        decoration: InputDecoration(

                          labelText: "Justificación",

                          border: OutlineInputBorder(

                            borderRadius: BorderRadius.circular(20),

                          )

                        ),

                      )


                    )

                  )

                );

                elementosBottomSheet.add(

                  Container(

                    width: double.infinity,

                    color: Colors.blue,

                    child: ElevatedButton(onPressed: (){



                    },

                      style: ButtonStyle(

                          backgroundColor: MaterialStatePropertyAll<Color>(colorBoton),

                          alignment: Alignment.center

                      ),

                      child: Text(mensajeBoton,

                        textAlign: TextAlign.center,

                        style: const TextStyle(

                          fontWeight: FontWeight.bold,

                          color: Colors.white,

                        ),

                      ),

                    )

                  )

                );



                return Container(

                  width: double.infinity,

                  height: 300,

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),

                    color: Colors.transparent,

                  ),

                  padding: const EdgeInsets.all(30),

                  child: Column(

                    children: elementosBottomSheet,

                  ),

                );

              }

            ),

            backgroundColor: Colors.white

          );

      },

    ),

    );

  }

}