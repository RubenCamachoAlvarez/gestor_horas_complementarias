import "dart:js_interop";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/Comprobante.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";
import "package:gestor_de_horas_complementarias/datos/Encargado.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart";
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

  late double altoBottomSheet;

  late double paddingBottomSheet;

  late double altoAreaUtilBottomSheet;

  bool status = true;

  Color colorFuenteSeleccion = Colors.grey[700]!;

  Color colorFuenteNoSeleccion = Colors.white;

  TextEditingController controladorTextField = TextEditingController();

  String mensajeJustificacionRechazo = "";

  String numeroHorasValidez = "";

  String datosOriginales = "";

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

      body: StreamBuilder(

        stream: BaseDeDatos.conexion.collection("Comprobantes").where("nombre", isEqualTo: widget.comprobante.nombre).snapshots(),

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.active) {

            List<QueryDocumentSnapshot<Map<String, dynamic>>> consultaDatos = snapshot.data!.docs;

            Map<String, dynamic> datosComprobante = consultaDatos.elementAt(0).data();

            if(datosComprobante["status_comprobante"] == StatusComprobante.ACEPTADO) {

              status = true;

              numeroHorasValidez = (datosComprobante["horas_validez"] as int).toString();

              datosOriginales = controladorTextField.text = numeroHorasValidez;

            }else if(datosComprobante["status_comprobante"] == StatusComprobante.RECHAZADO) {

              status = false;

              return StreamBuilder(

                stream: (datosComprobante["justificacion_rechazo"] as DocumentReference<Map<String, dynamic>>).snapshots(),

                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.active){

                    Map<String, dynamic>? datosComprobanteRechazado = snapshot.data!.data();

                    mensajeJustificacionRechazo = datosComprobanteRechazado!["mensaje_justificacion"];

                    datosOriginales = controladorTextField.text = mensajeJustificacionRechazo;

                    return LayoutBuilder(

                      builder: (context, constraints) {

                        altoBody = constraints.maxHeight;

                        anchoBody = constraints.maxWidth;

                        altoBottomSheet = altoBody * 0.3;

                        paddingBottomSheet = altoBottomSheet * 0.1468;

                        altoAreaUtilBottomSheet = altoBottomSheet - (paddingBottomSheet * 1.5);

                        return SfPdfViewerTheme(

                            data: SfPdfViewerThemeData(

                                backgroundColor: Colors.grey[200]
                            ),

                            child: SfPdfViewer.memory(

                              widget.comprobante.bytes,

                            )

                        );

                      },

                    );

                  }

                  return Container(

                    alignment: Alignment.center,

                    child: const CircularProgressIndicator(),

                  );

                },

              );

            }

            return LayoutBuilder(

              builder: (context, constraints) {

                altoBody = constraints.maxHeight;

                anchoBody = constraints.maxWidth;

                altoBottomSheet = altoBody * 0.3;

                paddingBottomSheet = altoBottomSheet * 0.1468;

                altoAreaUtilBottomSheet = altoBottomSheet - (paddingBottomSheet * 1.5);

                return SfPdfViewerTheme(

                    data: SfPdfViewerThemeData(

                        backgroundColor: Colors.grey[200]
                    ),

                    child: SfPdfViewer.memory(

                      widget.comprobante.bytes,

                    )

                );

              },

            );

          }

          return Container(

            alignment: Alignment.center,

            child: const CircularProgressIndicator()

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

                builder: (context) => StatefulBuilder(

                  builder: (context, setState) {

                    return Container(

                      padding: EdgeInsets.only(

                        right: paddingBottomSheet,

                        left: paddingBottomSheet,

                        top: paddingBottomSheet,

                        bottom: paddingBottomSheet * 0.5

                      ),

                      alignment: Alignment.center,

                      decoration: const BoxDecoration(

                        borderRadius: BorderRadius.only(

                            topRight: Radius.circular(50),

                            topLeft: Radius.circular(50)

                        ),

                      ),

                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,

                            crossAxisAlignment: CrossAxisAlignment.center,

                            children: [

                              ChoiceChip(

                                label: const Text("Aceptar"),

                                selectedColor: Colors.green,

                                backgroundColor: Colors.grey[200],

                                selected: status,

                                checkmarkColor: Colors.white,

                                labelStyle: TextStyle(

                                    color: (status) ? colorFuenteNoSeleccion : colorFuenteSeleccion,

                                    fontWeight: FontWeight.bold

                                ),

                                onSelected: (_) {

                                  setState((){

                                    status = !status;

                                    controladorTextField.text = numeroHorasValidez;

                                  });

                                },

                              ),

                              SizedBox(

                                width: anchoBody * 0.05,

                              ),

                              ChoiceChip(

                                label: const Text("Rechazar"),

                                selectedColor: Colors.red,

                                backgroundColor: Colors.grey[200],

                                checkmarkColor: Colors.white,

                                labelStyle: TextStyle(

                                    color: (!status) ? colorFuenteNoSeleccion : colorFuenteSeleccion,

                                    fontWeight: FontWeight.bold

                                ),

                                selected: !status,

                                onSelected: (_) {

                                  setState((){

                                    status = !status;

                                    controladorTextField.text = mensajeJustificacionRechazo;

                                  });

                                },

                              )

                            ],

                          ),

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.05,

                          ),

                          const Divider(),

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.1,

                          ),

                          TextField(

                            maxLines: 1,

                            minLines: 1,

                            controller: controladorTextField,

                            inputFormatters: (status) ? [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)] : null,

                            onChanged: (entrada){

                              setState((){

                                if(status) {

                                  numeroHorasValidez = entrada;

                                }else{

                                  mensajeJustificacionRechazo = entrada;

                                }

                              });

                            },

                            style: TextStyle(

                                color: Colors.grey[700],

                                fontWeight: FontWeight.bold

                            ),

                            decoration: InputDecoration(

                              prefixIcon: Padding(

                                padding: EdgeInsets.only(

                                  left: (anchoBody - (paddingBottomSheet * 2)) * 0.025,

                                ),

                                child: Icon((status) ? Icons.numbers_rounded : Icons.message, color: DatosApp.colorApp),

                              ),

                              hintText: (status) ? "Cantidad de horas de validez" : "Justificacion de rechazo",

                              hintFadeDuration: const Duration(milliseconds: 200),

                              hintStyle: TextStyle(

                                color: Colors.grey[700],

                                fontWeight: FontWeight.bold

                              ),

                              border: OutlineInputBorder(

                                  borderRadius: BorderRadius.circular(15),

                                  borderSide: BorderSide.none

                              ),

                              filled: true,

                              fillColor: Colors.grey[300],

                              constraints: BoxConstraints(

                                maxHeight: altoAreaUtilBottomSheet * 0.25,

                                maxWidth: double.infinity,

                                minHeight: altoAreaUtilBottomSheet * 0.25,

                                minWidth: double.infinity,

                              )

                            ),

                            textAlign: TextAlign.center,

                            textAlignVertical: TextAlignVertical.center,

                            readOnly: false //Sesion.usuario is Estudiante,

                          ),

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.05,

                          ),

                          SizedBox(

                              width: double.infinity,

                              height: altoAreaUtilBottomSheet * 0.25,

                              child: ElevatedButton(

                                onPressed: (controladorTextField.text.isEmpty ||
                                    ((widget.comprobante.statusComprobante == StatusComprobante.ACEPTADO && controladorTextField.text == datosOriginales) ||
                                      (widget.comprobante.statusComprobante == StatusComprobante.RECHAZADO && controladorTextField.text == datosOriginales)
                                    ))

                                    ? null : (){



                                },

                                style: ElevatedButton.styleFrom(

                                  backgroundColor: (status) ? Colors.green : Colors.red,

                                  disabledBackgroundColor: (status) ? Colors.green.shade200 : Colors.red.shade200,

                                  shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(15),

                                  ),

                                ),

                                child: Text(

                                  (widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? "Publicar revisión" : "Modificar revisión",

                                  style: const TextStyle(

                                      color: Colors.white

                                  ),

                                ),

                              ),

                          ),

                        ],

                      )

                    );

                  },

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

                  maxHeight: altoBottomSheet,

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