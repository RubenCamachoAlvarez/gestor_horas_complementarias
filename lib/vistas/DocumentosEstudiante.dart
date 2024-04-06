
import 'package:flutter/material.dart';

class DocumentosEstudianteWidget extends StatefulWidget {


  const DocumentosEstudianteWidget({super.key});

  @override

  State<DocumentosEstudianteWidget> createState() => DocumentosEstudianteState();


}

class DocumentosEstudianteState extends State<DocumentosEstudianteWidget> {

  DocumentosEstudianteState();

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(

      length: 2,

      child: Scaffold(

        appBar: AppBar(

          bottom: const TabBar(

            tabs: [

              Tab(

                icon: Icon(Icons.cloud_download_rounded),

              ),

              Tab(

                icon: Icon(Icons.account_circle),

              )

            ]

          ),

        ),

        body: TabBarView(

          children: [

            Container(

              color: Colors.red,

            ),

            Container(

              color: Colors.yellow,

            ),

          ],

        ),

      ),

    );

  }


}