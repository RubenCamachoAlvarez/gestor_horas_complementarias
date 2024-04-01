
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_horas_complementarias/datos/Usuario.dart';

class InformacionUsuarioWidget extends StatefulWidget {

  const InformacionUsuarioWidget({super.key});

  @override
  State<InformacionUsuarioWidget> createState() => InformacionUsuarioState();

}

class InformacionUsuarioState extends State<InformacionUsuarioWidget> {

  InformacionUsuarioState();

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView(

        padding: const EdgeInsets.all(20),

        children: [

          Column(

            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [ CircleAvatar(

                radius: 150,

                backgroundImage: const AssetImage("assets/images/ImagenUsuario.png"),

                backgroundColor: Colors.white70.withOpacity(0.1),

              ),

            ]

          ),

          const SizedBox(height: 10),

          ListTile(

            title: const Text("Nombre"),

            subtitle: Text("${Usuario.nombre} ${Usuario.apellidoPaterno} ${Usuario.apellidoMaterno}"),

            leading: const Icon(CupertinoIcons.person),

            trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

            tileColor: Colors.grey[100],

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(10)

            ),

            titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),

            horizontalTitleGap: 30,

          ),

          const SizedBox(height: 10,),

          ListTile(

            title: const Text("Fecha de nacimiento"),

            subtitle: Text("${Usuario.fechaNacimiento!.day}/${Usuario.fechaNacimiento!.month}/${Usuario.fechaNacimiento!.year}"),

            leading: const Icon(CupertinoIcons.calendar),

            trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

            tileColor: Colors.grey[100],

            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(10)

            ),

            titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),

            horizontalTitleGap: 30,

          ),

          const SizedBox(height: 10,),

          ListTile(

            title: const Text("Carrera"),

            subtitle: Text(Usuario.carrera!.id),

            leading: const Icon(CupertinoIcons.book),

            trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

            tileColor: Colors.grey[100],

            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(10)

            ),

            titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),

            horizontalTitleGap: 30,

          ),

          const SizedBox(height: 10,),

          ListTile(

            title: const Text("Ocupación"),

            subtitle: Text(Usuario.rol!.id),

            leading: const Icon(CupertinoIcons.alarm),

            trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

            tileColor: Colors.grey[100],

            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(10)

            ),

            titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),

            horizontalTitleGap: 30,

          ),

          const SizedBox(height: 10,),

          ListTile(

            title: Text("Número de ${Usuario.rol!.id == "Encargado" ? "trabajador" : "cuenta"}"),

            subtitle: Text(Usuario.numero!),

            leading: const Icon(CupertinoIcons.creditcard),

            trailing: const Icon(Icons.arrow_drop_down, color: Colors.grey),

            tileColor: Colors.grey[100],

            shape: RoundedRectangleBorder(

                borderRadius: BorderRadius.circular(10)

            ),

            titleTextStyle: const TextStyle(fontWeight: FontWeight.bold),

            horizontalTitleGap: 30,

          )

        ],

      )


    );

  }

}