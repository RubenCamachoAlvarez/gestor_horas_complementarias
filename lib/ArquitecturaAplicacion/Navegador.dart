import "package:flutter/material.dart";
import "package:gestor_de_horas_complementarias/ArquitecturaAplicacion/PaginaBasica.dart";

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

    return widget.widget;

  }



}

class Navegador {

  Navegador();

  PaginaBasica pagina = PaginaBasica();

  List<Widget> pilaVistas = <Widget>[];

  int dimension() {

    return pilaVistas.length;

  }

  void agregarVista(Widget vista){

    pilaVistas.add(vista);

    pagina.setWidget(vista);

  }

  Widget removerVista() {

    if(pilaVistas.length > 1) {

      pagina.setWidget(pilaVistas[pilaVistas.length - 2]);

    }else{

      pagina.setWidget(Container());

    }

    return pilaVistas.removeLast();

  }

  bool reemplazarVista(int indiceVista, Widget vista){

    if(indiceVista < pilaVistas.length) {

      pilaVistas[indiceVista] = vista;

      pagina.setWidget(vista);

      return true;

    }

    return false;

  }

}