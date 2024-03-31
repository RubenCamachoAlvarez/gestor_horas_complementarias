import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class BarraProgresoEstudianteWidget extends StatefulWidget {

  const BarraProgresoEstudianteWidget({super.key});

  @override

  State<BarraProgresoEstudianteWidget> createState() => BarraProgresoEstudianteState();

}

class BarraProgresoEstudianteState extends State<BarraProgresoEstudianteWidget> {

  BarraProgresoEstudianteState();

  ValueNotifier<double> notificador = ValueNotifier<double>(10);

  @override
  void initState() {

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Container(

      alignment: Alignment.center,

      color: Colors.white,

      padding: const EdgeInsets.all(100),

      child: DashedCircularProgressBar.aspectRatio(
        aspectRatio: 1, // width ÷ height
        valueNotifier: notificador,
        progress: 60,
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
                  const Text(
                    //'${value.toInt()}%',
                    '460',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 60
                    ),
                  ),
                  Text(
                    'Horas',
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

}

