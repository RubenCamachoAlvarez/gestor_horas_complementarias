import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:gestor_de_horas_complementarias/datos/Comprobante.dart";
import "package:gestor_de_horas_complementarias/datos/DatosApp.dart";
import "package:gestor_de_horas_complementarias/datos/Estudiante.dart";
import "package:gestor_de_horas_complementarias/helpers/BaseDeDatos.dart";
import "package:gestor_de_horas_complementarias/helpers/Sesion.dart";
import "package:gestor_de_horas_complementarias/valores_asignables/Roles.dart";
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

  late String mensajeBotonInferior;

  late SvgPicture iconoFlatingActionButton;

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

    altoBody = MediaQuery.of(context).size.height;

    anchoBody = MediaQuery.of(context).size.width;

    altoBottomSheet = altoBody * 0.3;

    paddingBottomSheet = altoBottomSheet * 0.1;

    altoAreaUtilBottomSheet = altoBottomSheet - (paddingBottomSheet * 1.5);

    inicializarElementosInterfaz();

    return Scaffold(

      resizeToAvoidBottomInset: true,

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

              double medidaLadoCard = anchoBody * 0.6;

              double padding = medidaLadoCard * 0.08;

              showDialog(

                context: context,

                builder: (context) {

                  return Dialog(

                      alignment: Alignment.center,

                      child: Container(

                        padding: EdgeInsets.all(padding),

                        alignment: Alignment.center,

                        width: medidaLadoCard,

                        height: medidaLadoCard,

                        decoration: BoxDecoration(

                            color: Colors.white,

                            borderRadius: BorderRadius.circular(15)

                        ),

                        child: LayoutBuilder(

                          builder: (context, constraints) {

                            double altoDialog = constraints.maxHeight;

                            double anchoDialog = constraints.maxWidth;

                            double altoElemento = altoDialog * 0.3;

                            return Center(

                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,

                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [

                                  SizedBox(

                                    width: anchoDialog,

                                    height: altoElemento,

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

                                  SizedBox(

                                    height: altoDialog * 0.05,

                                  ),

                                  SizedBox(

                                      width: anchoDialog,

                                      height: altoElemento,

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

                                  SizedBox(

                                    height: altoDialog * 0.05,

                                  ),

                                  SizedBox(

                                    width: anchoDialog,

                                    height: altoElemento,

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

                            );

                          },

                        ),

                      )

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

      body: SfPdfViewerTheme(

          data: SfPdfViewerThemeData(

              backgroundColor: Colors.grey[200]
          ),

          child: SfPdfViewer.memory(

            widget.comprobante.bytes,

          )

      ),

      floatingActionButton: (Sesion.usuario is Estudiante && widget.comprobante.statusComprobante == StatusComprobante.PENDIENTE) ? null :

        FloatingActionButton(

          backgroundColor: Colors.white,

          onPressed: () async {

            if(widget.comprobante.statusComprobante == StatusComprobante.ACEPTADO) {

              datosOriginales = controladorTextField.text = widget.comprobante.horasValidez!.toString();

              status = true;

            }else if(widget.comprobante.statusComprobante == StatusComprobante.RECHAZADO) {

              status = false;

              datosOriginales = controladorTextField.text = widget.comprobante.justificacionRechazo!;

            }

            DocumentReference<Map<String, dynamic>> referenciaComprobante = (await BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: widget.comprobante.estudiantePropietario.referenciaUsuario).where("nombre", isEqualTo: widget.comprobante.nombre).get()).docs.elementAt(0).reference;

            print(referenciaComprobante.id);

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

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.2,

                            width: anchoBody,

                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.center,

                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: (Sesion.usuario!.rol == Roles.ENCARGADO)

                                  ? [

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

                              ]

                                  :[

                                ChoiceChip(

                                  label: Text((status) ? "Aceptado" : "Rechazado"),

                                  selected: true, selectedColor: (status) ? Colors.green : Colors.red,

                                  checkmarkColor: Colors.white,

                                  labelStyle: const TextStyle(

                                      color: Colors.white,

                                      fontWeight: FontWeight.bold

                                  ),

                                  onSelected: (_){},


                                )

                              ],

                            ),

                          ),

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.01,

                          ),

                          const Divider(),

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.05,

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

                                    maxHeight: altoAreaUtilBottomSheet * 0.35,

                                    maxWidth: double.infinity,

                                    minHeight: altoAreaUtilBottomSheet * 0.35,

                                    minWidth: double.infinity,

                                  )

                              ),

                              textAlign: TextAlign.center,

                              textAlignVertical: TextAlignVertical.center,

                              readOnly: Sesion.usuario!.rol == Roles.ESTUDIANTE

                          ),

                          SizedBox(

                            height: altoAreaUtilBottomSheet * 0.05,

                          ),

                          (Sesion.usuario!.rol == Roles.ENCARGADO) ? SizedBox(

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

                                      widget.comprobante.statusComprobante = StatusComprobante.RECHAZADO;

                                    }

                                  }else{//Si el comprobante estaba rechazado previamente.

                                    QuerySnapshot<Map<String, dynamic>> consulta =  await BaseDeDatos.conexion.collection("Comprobantes").where("propietario", isEqualTo: widget.comprobante.estudiantePropietario.referenciaUsuario).where("nombre", isEqualTo: widget.comprobante.nombre).get();

                                    Map<String, dynamic> datosComprobante = consulta.docs.elementAt(0).data();

                                    DocumentReference<Map<String, dynamic>> referenciaJustificacionRechazo = datosComprobante["justificacion_rechazo"];

                                    if(status) { //Si la nueva revision establece que el estado del comprobante fue aceptado.

                                      await referenciaJustificacionRechazo.delete();

                                      await referenciaComprobante.update({

                                        "justificacion_rechazo" : FieldValue.delete(),

                                        "horas_validez" : int.parse(numeroHorasValidez),

                                        "status_comprobante" : StatusComprobante.ACEPTADO

                                      });

                                      widget.comprobante.statusComprobante = StatusComprobante.ACEPTADO;


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

                                    if(widget.comprobante.statusComprobante == StatusComprobante.ACEPTADO) {

                                      widget.comprobante.horasValidez = int.parse(numeroHorasValidez);

                                      widget.comprobante.justificacionRechazo = null;

                                    }else if(widget.comprobante.statusComprobante == StatusComprobante.RECHAZADO){

                                      widget.comprobante.justificacionRechazo = mensajeJustificacionRechazo;

                                      widget.comprobante.horasValidez = null;

                                    }

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

                                    widget.comprobante.justificacionRechazo = mensajeJustificacionRechazo;

                                    widget.comprobante.statusComprobante = StatusComprobante.RECHAZADO;

                                    datosActualizacion["justificacion_rechazo"] = referenciaJustificacion;

                                    datosActualizacion["status_comprobante"] = StatusComprobante.RECHAZADO;

                                  }else{

                                    widget.comprobante.horasValidez = int.parse(numeroHorasValidez);

                                    widget.comprobante.statusComprobante = StatusComprobante.ACEPTADO;

                                    datosActualizacion["horas_validez"] = int.parse(numeroHorasValidez);

                                    datosActualizacion["status_comprobante"] = StatusComprobante.ACEPTADO;

                                  }

                                  referenciaComprobante.update(datosActualizacion).then((_) {

                                    datosOriginales = (status) ? numeroHorasValidez : mensajeJustificacionRechazo;

                                    Navigator.of(context).pop();

                                    setState(() {

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

                          ) : SizedBox(

                              width: double.infinity,

                              height: altoAreaUtilBottomSheet * 0.25,

                              child: ElevatedButton(

                                onPressed: () {

                                  Navigator.of(context).pop();

                                },

                                style: ElevatedButton.styleFrom(

                                  backgroundColor: DatosApp.colorApp,

                                  shape: RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(15),

                                  ),

                                ),

                                child: const Text(

                                  "Cerrar",

                                  style: TextStyle(

                                      color: Colors.white

                                  ),

                                ),

                              )

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

          clipBehavior: Clip.antiAliasWithSaveLayer,

          shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(30)

          ),

          child: ClipOval(

              clipBehavior: Clip.antiAliasWithSaveLayer,

              child: Padding(

                padding: const EdgeInsets.all(10),

                child: (Sesion.usuario is Estudiante) ? SvgPicture.asset("./assets/images/IconoVisualizarRevision.svg", fit: BoxFit.fill, clipBehavior:
                Clip.antiAliasWithSaveLayer,) : ((widget.comprobante.statusComprobante != StatusComprobante.PENDIENTE) ? SvgPicture.asset("./assets/images/IconoModificarRevision.svg", fit: BoxFit.fill, clipBehavior:
                Clip.antiAliasWithSaveLayer,)  : SvgPicture.asset("./assets/images/IconoEnviarRevision.svg", fit: BoxFit.fill, clipBehavior:
                Clip.antiAliasWithSaveLayer,)),

              )

          )

      )

    );

  }

}