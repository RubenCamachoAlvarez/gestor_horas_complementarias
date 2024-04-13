import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class VisorComprobanteWidget extends StatefulWidget {

  VisorComprobanteWidget({super.key, required this.comprobante});

  Comprobante comprobante;

  @override
  State<VisorComprobanteWidget> createState() => VisorComprobanteState();


}

class VisorComprobanteState extends State<VisorComprobanteWidget> {

  bool statusComprobante = false;

  VisorComprobanteState() {

    controladorCampoJustificacionRechazo.text = "mensaje";

  }

  TextEditingController controladorCampoJustificacionRechazo = TextEditingController();

  TextEditingController controladorCampoHorasValidezAceptado = TextEditingController();

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

        tooltip: (widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? "Enviar revisión" : "Modificar revisión",

        onPressed: () async {

          //Este await hace que el resto de las lineas de la función llamada, cuando se presiona el FloatingActionButton, se ejecuten hasta que el
          //BottomSheet se haya cerrado.
          await showModalBottomSheet(context: context,
            
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

                        controller: (statusComprobante) ? controladorCampoHorasValidezAceptado : controladorCampoJustificacionRechazo,

                        decoration: InputDecoration(

                          labelText: (statusComprobante) ? "Horas de validez" : "Justificación de rechazo",

                          hintText: (statusComprobante) ? "Ingresa la cantidad de horas de validez" : "Ingresa el mótivo del rechazo del comprobante",

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

                    child: ElevatedButton(onPressed: (){

                      //AQUI VAN LAS INSTRUCCIONES PARA ACTUALIZAR EL ESTADO DEL DOCUMENTO EN LA BASE DE DATOS Y EN EL COMPROBANTE RECIBIDO COMO ARGUMENTO
                      //A FIN DE MODIFICAR LOS DATOS MOSTRADOS EN EL WIDGET UNA VEZ QUE SEA CERRADO EL BOTTOMSHEET.

                      Navigator.of(context).pop();

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


                //Forma del BottomSheet.
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



          setState((){

            print("AQUI DESPUES DE ACTUALIZAR EL STATUS DEL DOCUMENTO ASEGURARSE QUE EL ICONO Y TOOLTIP DEL FLOATING ACTION BUTTON SE HAYA MODIFICADO");

          });

      },

      child: (widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? const Icon(Icons.send) : const Icon(Icons.edit),

    ),

    );

  }

}