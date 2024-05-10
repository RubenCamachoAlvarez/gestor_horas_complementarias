import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/Comprobante.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";
import "package:gestor_de_horas_complementarias/datos/Encargado.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/valores_asignables/StatusComprobante.dart";
import "package:syncfusion_flutter_core/theme.dart";
import "package:syncfusion_flutter_pdfviewer/pdfviewer.dart";

class LectorDocumentoPDFWidget extends StatefulWidget{

  LectorDocumentoPDFWidget({super.key, required this.comprobante});

  Comprobante comprobante;

  @override
  State<LectorDocumentoPDFWidget> createState() => LectorDocumentoPDFState();

}

class LectorDocumentoPDFState extends State<LectorDocumentoPDFWidget> {

  late double altoBody;

  late double anchoBody;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(

          onPressed: (){

            Navigator.of(context).pop();

          },

          icon: SvgPicture.asset("./assets/images/IconoRetroceso.svg"),

        ),

        actions: [

          IconButton(

            onPressed: (){

              double medidaLadoCard = anchoBody * 0.5;

              showDialog(

                context: context,

                builder: (context) {

                  return Stack(

                    fit: StackFit.expand,

                    alignment: Alignment.center,

                    children: [

                      Dialog(

                        alignment: Alignment.center,

                        child: Container(

                          padding: const EdgeInsets.all(20),

                          alignment: Alignment.center,

                          width: medidaLadoCard,

                          height: medidaLadoCard,

                          decoration: BoxDecoration(

                              color: Colors.white,

                              borderRadius: BorderRadius.circular(15)

                          ),

                          child: Center(

                            child: Column(

                              mainAxisAlignment: MainAxisAlignment.center,

                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [

                                Expanded(

                                  child: Theme(

                                    data: ThemeData(

                                      textSelectionTheme: const TextSelectionThemeData(

                                        selectionColor: Colors.amber,

                                      )

                                    ),

                                    child: TextField(

                                      readOnly: true,

                                      maxLines: 1,

                                      minLines: 1,

                                      textAlign: TextAlign.center,

                                      style: TextStyle(

                                          color: Colors.grey[700],

                                          fontWeight: FontWeight.bold

                                      ),

                                      decoration: InputDecoration(

                                        border: OutlineInputBorder(

                                            borderRadius: BorderRadius.circular(10),

                                            borderSide: BorderSide.none

                                        ),

                                        filled: true,

                                        fillColor: Colors.grey[100],

                                        prefixIcon: Icon(Icons.description_rounded, color: DatosApp.colorApp),

                                      ),

                                      controller: TextEditingController(text: widget.comprobante.nombre),

                                    ),

                                  ),

                                ),

                                Expanded(

                                  child: Theme(

                                    data: ThemeData(

                                      textSelectionTheme: const TextSelectionThemeData(

                                        selectionColor: Colors.amber,

                                      ),

                                    ),

                                    child: TextField(

                                      readOnly: true,

                                      maxLines: 1,

                                      minLines: 1,

                                      textAlign: TextAlign.center,

                                      style: TextStyle(

                                          color: Colors.grey[700],

                                          fontWeight: FontWeight.bold

                                      ),

                                      decoration: InputDecoration(

                                        border: OutlineInputBorder(

                                            borderRadius: BorderRadius.circular(15),

                                            borderSide: BorderSide.none

                                        ),

                                        filled: true,

                                        fillColor: Colors.grey[100],

                                        prefixIcon: Icon(Icons.calendar_month, color: DatosApp.colorApp,),

                                      ),

                                      controller: TextEditingController(text: widget.comprobante.cadenaFechaSubida()),

                                    ),

                                  )

                                ),

                                Expanded(

                                  child: Theme(

                                    data: ThemeData(

                                      textSelectionTheme: const TextSelectionThemeData(

                                        selectionColor: Colors.amber

                                      )

                                    ),

                                    child: TextField(

                                      readOnly: true,

                                      maxLines: 1,

                                      minLines: 1,

                                      textAlign: TextAlign.center,

                                      style: TextStyle(

                                          color: Colors.grey[700],

                                          fontWeight: FontWeight.bold

                                      ),

                                      decoration: InputDecoration(

                                        border: OutlineInputBorder(

                                            borderRadius: BorderRadius.circular(15),

                                            borderSide: BorderSide.none

                                        ),

                                        filled: true,

                                        fillColor: Colors.grey[100],

                                        prefixIcon: Icon(Icons.account_circle, color: DatosApp.colorApp),

                                      ),

                                      controller: TextEditingController(text: widget.comprobante.estudiantePropietario.nombreCompleto()),

                                    ),

                                  ),

                                )

                              ],

                            ),

                          ),

                        ),

                      ),
                      
                      Positioned(

                        top: (altoBody * 0.5) - (medidaLadoCard * 0.47),

                        left: anchoBody * 0.73,

                        child: GestureDetector(

                          onTap: (){

                            Navigator.of(context).pop();

                          },

                          child: SvgPicture.asset(

                            "./assets/images/IconoBotonCerrar.svg",

                            clipBehavior: Clip.antiAliasWithSaveLayer,

                          ),

                        )

                      )

                    ],

                  );

                }

              );

            },

            icon: SvgPicture.asset("./assets/images/IconoInformacion.svg")

          )

        ],

        title: Text(widget.comprobante.nombre,

          textAlign: TextAlign.center,

          maxLines: 1,

          overflow: TextOverflow.ellipsis,

          style: TextStyle(

            color: Colors.grey[800],

            fontWeight: FontWeight.bold

          ),

        ),

        centerTitle: true,

        backgroundColor: Colors.grey[200]

      ),

      body: LayoutBuilder(

        builder: (context, constraints) {

          altoBody = constraints.maxHeight;

          anchoBody = constraints.maxWidth;

          return SfPdfViewerTheme(

            data: SfPdfViewerThemeData(

              backgroundColor: Colors.grey[200]
            ),

            child: SfPdfViewer.memory(

              widget.comprobante.bytes,

            )

          );

        },

      ),

      floatingActionButton: (Sesion.usuario is Estudiante && widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? null :

        SizedBox(

          width: 60,

          height: 60,

          child: FloatingActionButton(

            onPressed: (){

              showModalBottomSheet(

                context: context,

                builder: (context) => Container(
                  
                  padding: const EdgeInsets.all(40),

                  height: double.infinity,

                  width: double.infinity,

                  decoration: BoxDecoration(
                    
                    borderRadius: BorderRadius.only(
                      
                      topRight: Radius.circular(40),
                      
                      topLeft: Radius.circular(40)
                      
                    ),


                    
                  ),
                  
                ),

                backgroundColor: Colors.white,

                shape: const RoundedRectangleBorder(

                  borderRadius: BorderRadius.only(

                    topLeft: Radius.circular(40),

                    topRight: Radius.circular(40)

                  )
                ),

                constraints: BoxConstraints(

                  maxWidth: anchoBody,

                  maxHeight: altoBody * 0.4,

                ),

              );

            },

            backgroundColor: Colors.white,

            foregroundColor: Colors.white,

            clipBehavior: Clip.antiAliasWithSaveLayer,

            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(30)

            ),

            child: (Sesion.usuario is Estudiante) ? SvgPicture.asset("./assets/images/IconoEnviarRevision.svg", width: 40, height: 40,) :

            (Sesion.usuario is Encargado && widget.comprobante.statusComprobante != StatusComprobante.PENDIENTE) ?

            SvgPicture.asset("./assets/images/IconoModificarRevision.svg", width: 40, height: 40,) : SvgPicture.asset("./assets/images/IconoEnviarRevision.svg", width: 40, height: 40,),

          ),

        ),

    );

  }

}