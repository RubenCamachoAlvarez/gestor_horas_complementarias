import "package:flutter/material.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";

class PaginaBasica extends StatefulWidget{

  PaginaBasica({super.key});

  Widget widget = Container();

  EstadoPaginaBasica estado = EstadoPaginaBasica();

  void setWidget(Widget widget) {

    this.widget = widget;

    estado.repintar();

  }

  @override
  EstadoPaginaBasica createState() {

    estado = EstadoPaginaBasica();

    return estado;

  }

}

class EstadoPaginaBasica extends State<PaginaBasica> {

  EstadoPaginaBasica();

  void repintar(){

    if(mounted) {

      setState(() {

      });

    }

  }

  @override
  Widget build(BuildContext context){

    return WillPopScope(

      child: widget.widget,

      onWillPop: () async {

        DatosApp.navegador.removerVista();

        if(DatosApp.navegador.dimension() > 0){

          return false;

        }

        return true;

      },

    );

  }



}