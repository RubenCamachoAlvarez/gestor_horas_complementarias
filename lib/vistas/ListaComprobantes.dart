import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Comprobante.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';
import 'dart:async';
import 'package:gestor_de_horas_complementarias/vistas/VisorComprobante.dart';

class ListaComprobantesWidget extends StatefulWidget {

  ListaComprobantesWidget({super.key, required this.estudiante, required this.filtroStatusComprobante});

  DocumentReference filtroStatusComprobante;

  Estudiante estudiante;

  @override
  State<ListaComprobantesWidget> createState() => ListaComprobantesState();

}

class ListaComprobantesState extends State<ListaComprobantesWidget> {

  @override
  Widget build(BuildContext context) {

    Stream<QuerySnapshot<Map<String, dynamic>>> streamConsulta = widget.estudiante.obtenerComprobantesPendientes();

    if(widget.filtroStatusComprobante == StatusComprobante.ACEPTADO) {

      streamConsulta = widget.estudiante.obtenerComprobantesAceptados();

    }else if(widget.filtroStatusComprobante == StatusComprobante.RECHAZADO) {

      streamConsulta = widget.estudiante.obtenerComprobantesRechazados();

    }

    return StreamBuilder(

      stream: streamConsulta,

      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.waiting) {

          return Container(

            alignment: Alignment.center,

            child: const Column(

              mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,

              children: <CircularProgressIndicator>[

                CircularProgressIndicator()

              ],

            ),

          );

        }else{

          List<QueryDocumentSnapshot<Map<String, dynamic>>> consultaComprobantes = snapshot.data!.docs;

          return ListView.separated(

            padding: const EdgeInsets.all(30),

            separatorBuilder: (context, index) => const SizedBox(height: 20,),

            itemCount: consultaComprobantes.length,

            itemBuilder: (context, index) {

              Map<String, dynamic> datosComprobante = consultaComprobantes.elementAt(index).data();

              return FutureBuilder(

                future: BaseDeDatos.almacenamiento.ref().child("Comprobantes_estudiantes/${widget.estudiante.numero}/${datosComprobante["nombre"]}").getData(),

                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.done) {

                    Uint8List bytesArchivo = snapshot.data!;

                    Comprobante comprobante = Comprobante(

                        nombre: datosComprobante["nombre"],

                        bytes: bytesArchivo,

                        propietario: datosComprobante["propietario"],

                        fechaSubida: datosComprobante["fecha_subida"],

                        statusComprobante: datosComprobante["status_comprobante"]

                    );

                    if(widget.filtroStatusComprobante == StatusComprobante.ACEPTADO) {

                      comprobante.horasValidez = datosComprobante["horas_validez"];


                    }else if(widget.filtroStatusComprobante == StatusComprobante.RECHAZADO) {

                      comprobante.justificacionRechazo = datosComprobante["justificacion_rechazo"];

                    }

                    return ListTile(

                      title: Text(comprobante.nombre, textAlign: TextAlign.center,),

                      leading: const Icon(Icons.picture_as_pdf, color: Color.fromARGB(
                          255, 194, 2, 2)),

                      trailing: const Icon(Icons.play_arrow_sharp, color: Colors.black),

                      shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(10)

                      ),

                      titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),

                      horizontalTitleGap: 30,

                      tileColor: Colors.white24,

                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => VisorComprobanteWidget(comprobante: comprobante),));

                      },

                    );

                  }else{

                    return Container();

                  }

                },

              );

            },

          );

        }

      },

    );

  }

}