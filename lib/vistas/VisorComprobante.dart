import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Encargado.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
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

  TextEditingController controladorCampoJustificacionRechazo = TextEditingController();

  TextEditingController controladorCampoHorasValidezAceptado = TextEditingController();

  late Future<void> consulta;

  VisorComprobanteState();

  @override

  void initState() {

    super.initState();

    consulta = consultarDatosComprobante();

  }

  Future<void> consultarDatosComprobante() async {

    if(widget.comprobante.statusComprobante == StatusComprobante.ACEPTADO) {

      statusComprobante = true;

      controladorCampoHorasValidezAceptado.text = widget.comprobante.horasValidez!.toString();

    }else if(widget.comprobante.statusComprobante == StatusComprobante.RECHAZADO) {

      DocumentSnapshot<Map<String, dynamic>> datos = await widget.comprobante.justificacionRechazo!.get();

      if(datos.exists) {

        controladorCampoJustificacionRechazo.text = datos.data()!["mensaje_justificacion"];

      }

    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(widget.comprobante.nombre),

        centerTitle: true,

        leading: IconButton(

          onPressed: () {

            Navigator.pop(context);

          },

          icon: const Icon(Icons.arrow_back_ios)

        ),

      ),

      body:

      Center(

        child: SfPdfViewer.memory(widget.comprobante.bytes),

      ),

      floatingActionButton: (Sesion.usuario is! Encargado && widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? null : FloatingActionButton(

        tooltip: (Sesion.usuario is Encargado) ? ((widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? "Enviar revisión" : "Modificar revisión") : "Visualizar revisión",

        onPressed: () {

          //Este await hace que el resto de las lineas de la función llamada, cuando se presiona el FloatingActionButton, se ejecuten hasta que el
          //BottomSheet se haya cerrado.
          showModalBottomSheet(context: context,
            
            shape: const RoundedRectangleBorder(
              
              borderRadius: BorderRadius.only(

                topLeft: Radius.circular(20),

                topRight: Radius.circular(20),

              )
              
            ),

            builder: (context) =>  FutureBuilder(

              future: consulta,

              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.done) {

                  print("Datos cargados correctamente");

                  return StatefulBuilder(

                      builder: (context, setState) {

                        print("Ejecutando esto");

                        List<Widget> elementosBottomSheet = <Widget> [];

                        if(Sesion.usuario is Encargado) {

                          elementosBottomSheet.add(

                              Switch(value: statusComprobante,

                                onChanged: (bool nuevoValor) {

                                  setState(() {

                                    statusComprobante = nuevoValor;
                                  });

                                },

                                activeTrackColor: Colors.green,

                                inactiveThumbColor: Colors.white,

                                inactiveTrackColor: Colors.red,

                              )

                          );

                        }else{

                          elementosBottomSheet.add(

                              Container(

                                alignment: Alignment.center,

                                padding: const EdgeInsets.all(20),

                                child: Text((statusComprobante) ? "Comprobante aprobado" : "Comprobante rechazado",

                                  style: TextStyle(

                                    fontWeight: FontWeight.bold,

                                    color: (statusComprobante) ? Colors.green : Colors.red,

                                    fontSize: 20,

                                  ),

                                ),

                              )

                          );

                        }

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

                                  textAlign: (statusComprobante) ? TextAlign.center : TextAlign.left,

                                  readOnly: (Sesion.usuario is Estudiante) ? true : false,

                                  maxLines: (statusComprobante) ? 1 : 5,

                                  decoration: InputDecoration(

                                      labelText: (statusComprobante) ? "Horas de validez" : "Justificación de rechazo",

                                      labelStyle: const TextStyle(

                                        fontWeight: FontWeight.bold,

                                      ),

                                      hintText: (statusComprobante) ? "Ingresa la cantidad de horas de validez" : "Ingresa el mótivo del rechazo del comprobante",

                                      border: OutlineInputBorder(

                                        borderRadius: BorderRadius.circular(20),

                                      )

                                  ),

                                )


                            )

                            )

                        );

                        if(Sesion.usuario is Encargado) {

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

                        }

                        //Forma del BottomSheet.
                        return Container(

                          width: double.infinity,

                          height: 300,

                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),

                            color: Colors.transparent,

                          ),

                          padding: const EdgeInsets.all(20),

                          child: Column(

                            children: elementosBottomSheet,

                          ),

                        );

                      }

                  );

                }

                print("Cargando datos");

                return Container(

                  width: double.infinity,

                  height: 300,

                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),

                    color: Colors.transparent,

                  ),

                  padding: const EdgeInsets.all(20),

                );

              },


            ),

            backgroundColor: Colors.white

          );

          setState((){

            print("AQUI DESPUES DE ACTUALIZAR EL STATUS DEL DOCUMENTO ASEGURARSE QUE EL ICONO Y TOOLTIP DEL FLOATING ACTION BUTTON SE HAYA MODIFICADO");

          });

          //

          consulta = consultarDatosComprobante();

      },

      child: (Sesion.usuario is Encargado) ? ((widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? const Icon(Icons.send) : const Icon(Icons.edit)) : const Icon(Icons.remove_red_eye),

    ),

    );

  }

}