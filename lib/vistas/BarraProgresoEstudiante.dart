import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Estudiante.dart';
import 'package:gestor_de_horas_complementarias/helpers/Sesion.dart';

class BarraProgresoEstudianteWidget extends StatefulWidget {

  const BarraProgresoEstudianteWidget({super.key});

  @override

  State<BarraProgresoEstudianteWidget> createState() => BarraProgresoEstudianteState();

}

class BarraProgresoEstudianteState extends State<BarraProgresoEstudianteWidget> {

  double porcentajeProgreso = 0.0;

  int horasProgreso = 0;

  BarraProgresoEstudianteState();

  ValueNotifier<double> notificador = ValueNotifier<double>(10);

  late Future<void> resultadoTarea;

  @override
  void initState() {

    super.initState();

    resultadoTarea = calcularProgreso();

  }

  Future<void> calcularProgreso() async {

    porcentajeProgreso = await (Sesion.usuario as Estudiante).calcularPorcentajeAvance();

    horasProgreso = await (Sesion.usuario as Estudiante).calcularHorasProgreso();

  }


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(

      future: resultadoTarea,

      builder: (context, snapshot) {

        if(snapshot.connectionState == ConnectionState.done) {

          return Container(

              alignment: Alignment.center,

              color: Colors.white,

              padding: const EdgeInsets.all(100),

              child: DashedCircularProgressBar.aspectRatio(
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

        }

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

      },

    );

  }

}

