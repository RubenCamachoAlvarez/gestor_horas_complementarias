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

  late DocumentReference<Map<String, dynamic>> referenciaComprobante;

  late String mensajeBotonInferior;

  late SvgPicture iconoFlatingActionButton;

  late Map<String, dynamic> datosComprobante;

  void inicializarElementosInterfaz(){

    if(Sesion.usuario is Estudiante && widget.comprobante.statusComprobante != StatusComprobante.PENDIENTE){

      iconoFlatingActionButton = SvgPicture.asset("./assets/images/IconoVisualizarRevision.svg");

      mensajeBotonInferior = "Cerrar";

    }else if(widget.comprobante.statusComprobante != StatusComprobante.PENDIENTE) {

      iconoFlatingActionButton = SvgPicture.asset("./assets/images/IconoModificarRevision.svg");

      mensajeBotonInferior = "Modificar revision";

    }else{

      iconoFlatingActionButton = SvgPicture.asset("./assets/images/IconoEnviarRevision.svg");

      mensajeBotonInferior = "Publicar revisión";

    }

  }

  @override
  Widget build(BuildContext context) {

    inicializarElementosInterfaz();

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

      body: FutureBuilder(

        future: BaseDeDatos.conexion.collection("Comprobantes").where("nombre", isEqualTo: widget.comprobante.nombre).get(),

        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.done) {

            referenciaComprobante = snapshot.data!.docs.elementAt(0).reference;

            datosComprobante = snapshot.data!.docs.elementAt(0).data();

            if(datosComprobante["status_comprobante"] != StatusComprobante.PENDIENTE) {

              if(datosComprobante["status_comprobante"] == StatusComprobante.ACEPTADO) {

                status = true;

                numeroHorasValidez = (datosComprobante["horas_validez"] as int).toString();

                controladorTextField.text = datosOriginales = numeroHorasValidez;

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

              }else if(datosComprobante["status_comprobante"] == StatusComprobante.RECHAZADO){

                status = false;

                return FutureBuilder(

                  future: (datosComprobante["justificacion_rechazo"] as DocumentReference<Map<String, dynamic>>).get(),

                  builder: (context, snapshot) {

                    if(snapshot.connectionState == ConnectionState.done) {

                      Map<String, dynamic> datosJustificacionRechazo = snapshot.data!.data()!;

                      mensajeJustificacionRechazo = datosJustificacionRechazo["mensaje_justificacion"];

                      controladorTextField.text = datosOriginales = mensajeJustificacionRechazo;

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

                  },);

              }

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

      floatingActionButton: //(Sesion.usuario is Estudiante && widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? null :

        SizedBox(

          width: 60,

          height: 60,

          child: FloatingActionButton(

            onPressed: (){

              showModalBottomSheet(

                context: context,

                builder: (context) => StatefulBuilder(

                  builder: (context, setStateBS) {

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

                                  setStateBS((){

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

                                  setStateBS((){

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

                              setStateBS((){

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

                                  ? null : () async {

                                    if(widget.comprobante.statusComprobante != StatusComprobante.PENDIENTE) {

                                      //Aqui se inserta el codigo para cuando se hace una modificacion (update) del documento que representa al comprobante en cuestion.

                                      //Si el comprobante ya estaba aceptado previamente.
                                      if(widget.comprobante.statusComprobante == StatusComprobante.ACEPTADO) {

                                        if(status) { //Si el comprobante permanece como aceptado.

                                          await referenciaComprobante.update({

                                            "horas_validez" : int.parse(numeroHorasValidez)

                                          });


                                        }else{ //Si el comprobante ha cambiado su status a rechazado.

                                          DocumentReference<Map<String, dynamic>> nuevaReferenciaJustificacion = await BaseDeDatos.conexion.collection("Justificaciones_Rechazos").add({

                                            "mensaje_justificacion" : mensajeJustificacionRechazo

                                          });

                                          await referenciaComprobante.update({

                                            "horas_validez" : FieldValue.delete(),

                                            "justificacion_rechazo" : nuevaReferenciaJustificacion,

                                            "status_comprobante" : StatusComprobante.RECHAZADO

                                          });

                                          widget.comprobante.statusComprobante == StatusComprobante.RECHAZADO;

                                        }

                                      }else{//Si el comprobante estaba rechazado previamente.

                                        DocumentReference<Map<String, dynamic>> referenciaJustificacionRechazo = datosComprobante["justificacion_rechazo"];

                                        if(status) { //Si la nueva revision establece que el estado del comprobante fue aceptado.

                                          await referenciaComprobante.update({

                                            "justificacion_rechazo" : FieldValue.delete(),

                                            "horas_validez" : int.parse(numeroHorasValidez),

                                            "status_comprobante" : StatusComprobante.ACEPTADO

                                          });

                                          await referenciaJustificacionRechazo.delete();

                                          widget.comprobante.statusComprobante == StatusComprobante.ACEPTADO;


                                        }else{ //Si la nueva revision establece que el estado del comprobante se mantiene como rechazado.

                                          await referenciaJustificacionRechazo.update(

                                            {

                                              "mensaje_justificacion" : mensajeJustificacionRechazo

                                            }

                                          );

                                        }

                                      }

                                      Navigator.of(context).pop();

                                      setState(() {

                                        datosOriginales = (status) ? numeroHorasValidez : mensajeJustificacionRechazo;

                                        inicializarElementosInterfaz();

                                        ScaffoldMessenger.of(context).showSnackBar(

                                            SnackBar(

                                              backgroundColor: Colors.amber,

                                              content: const Text(

                                                "Se ha actualizado el status del comprobante",

                                                textAlign: TextAlign.center,

                                                style: TextStyle(

                                                  fontWeight: FontWeight.bold,

                                                  color: Colors.white,

                                                ),

                                              ),

                                              duration: const Duration(seconds: 3),

                                              padding: const EdgeInsets.all(20),

                                              behavior: SnackBarBehavior.floating,

                                              shape: RoundedRectangleBorder(

                                                  borderRadius: BorderRadius.circular(10)

                                              ),

                                            )

                                        );

                                      });

                                    }else{

                                      //Aqui va el codigo cuando se revisa por primera vez el comprobante.

                                      DocumentReference<Map<String, dynamic>> referenciaJustificacion;

                                      Map<String, dynamic> datosActualizacion = <String, dynamic> {};

                                      if(!status) {

                                        referenciaJustificacion = await BaseDeDatos.conexion.collection("Justificaciones_Rechazos").add({"mensaje_justificacion" : mensajeJustificacionRechazo});

                                        datosActualizacion["justificacion_rechazo"] = referenciaJustificacion;

                                        datosActualizacion["status_comprobante"] = StatusComprobante.RECHAZADO;

                                      }else{

                                        datosActualizacion["horas_validez"] = int.parse(numeroHorasValidez);

                                        datosActualizacion["status_comprobante"] = StatusComprobante.ACEPTADO;

                                      }

                                      referenciaComprobante.update(datosActualizacion).then((_) {

                                        Navigator.of(context).pop();

                                        setState(() {

                                          widget.comprobante.statusComprobante = datosActualizacion["status_comprobante"];

                                          datosOriginales = (status) ? numeroHorasValidez : mensajeJustificacionRechazo;

                                          inicializarElementosInterfaz();

                                          ScaffoldMessenger.of(context).showSnackBar(

                                              SnackBar(

                                                backgroundColor: Colors.amber,

                                                content: const Text(

                                                  "Se ha actualizado el status del comprobante",

                                                  textAlign: TextAlign.center,

                                                  style: TextStyle(

                                                    fontWeight: FontWeight.bold,

                                                    color: Colors.white,

                                                  ),

                                                ),

                                                duration: const Duration(seconds: 3),

                                                padding: const EdgeInsets.all(20),

                                                behavior: SnackBarBehavior.floating,

                                                shape: RoundedRectangleBorder(

                                                    borderRadius: BorderRadius.circular(10)

                                                ),

                                              )

                                          );

                                        });

                                      }).catchError((error){

                                        Navigator.of(context).pop();

                                        ScaffoldMessenger.of(context).showSnackBar(

                                            SnackBar(

                                              backgroundColor: Colors.orange,

                                              content: const Text(

                                                "Ha ocurrido un error en la revisión",

                                                textAlign: TextAlign.center,

                                                style: TextStyle(

                                                  fontWeight: FontWeight.bold,

                                                  color: Colors.white,

                                                ),

                                              ),

                                              duration: const Duration(seconds: 3),

                                              padding: const EdgeInsets.all(20),

                                              behavior: SnackBarBehavior.floating,

                                              shape: RoundedRectangleBorder(

                                                  borderRadius: BorderRadius.circular(10)

                                              ),

                                            )

                                        );

                                      });


                                    }

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

            child: iconoFlatingActionButton

          ),

        ),

    );

  }

}