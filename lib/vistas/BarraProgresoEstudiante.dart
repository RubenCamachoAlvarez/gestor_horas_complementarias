import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';
import 'package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart';

class BarraProgresoEstudianteWidget extends StatefulWidget {

  const BarraProgresoEstudianteWidget({super.key});

  @override

  State<BarraProgresoEstudianteWidget> createState() => BarraProgresoEstudianteState();

}

class BarraProgresoEstudianteState extends State<BarraProgresoEstudianteWidget> {

  BarraProgresoEstudianteState();

  DocumentReference referenciaEstudiante = BaseDeDatos.conexion.collection("Usuarios").doc(Sesion.usuario!.numero);

  ValueNotifier<double> notificador = ValueNotifier<double>(10);

  double porcentajeProgreso = 0.0;

  int horasProgreso = 0;

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(

        stream: BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: referenciaEstudiante).where("status_comprobante", isEqualTo: StatusComprobante.ACEPTADO).snapshots(),

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {

            return Container(

              alignment: Alignment.center,

              child: const CircularProgressIndicator(),

            );

          }else{

            horasProgreso = 0;

            List<QueryDocumentSnapshot<Map<String, dynamic>>> comprobantes = snapshot.data!.docs;

            comprobantes.forEach((element) {

              horasProgreso += (element.data()["horas_validez"] as int);

            });

            return FutureBuilder(

              future: Sesion.usuario!.carrera!.get(),

              builder: (context, snapshot) {

                if(snapshot.connectionState == ConnectionState.done) {

                  int horasObligatorias = snapshot.data!.data()!["horas_obligatorias"];

                  porcentajeProgreso = horasProgreso * 100 / horasObligatorias;

                  return Container(

                      alignment: Alignment.center,

                      color: Colors.white,

                      padding: const EdgeInsets.all(100),

                      child: DashedCircularProgressBar.aspectRatio(
                        animationDuration: const Duration(seconds: 1),
                        aspectRatio: 1, // width ÷ height
                        valueNotifier: notificador,
                        progress: porcentajeProgreso,
                        startAngle: 225,
                        sweepAngle: 270,
                        foregroundColor: Colors.blueAccent,
                        backgroundColor: const Color(0xffeeeeee),
                        foregroundStrokeWidth: 15,
                        backgroundStrokeWidth: 15,
                        animation: true,
                        seekSize: 6,
                        seekColor: const Color(0xffeeeeee),
                        child: Center(
                          child: ValueListenableBuilder(
                              valueListenable: notificador,
                              builder: (_, double value, __) => Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    horasProgreso.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 60
                                    ),
                                  ),
                                  Text(
                                    (horasProgreso != 1) ? "Horas" : "Hora",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ),
                      )

                  );

                }else{

                  return Container(

                    alignment: Alignment.center,

                    child:

                      const CircularProgressIndicator(),

                  );

                }

              },

            );

          }

        },

    );

  }

}

