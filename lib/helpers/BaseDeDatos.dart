
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BaseDeDatos {

  static final conexion = FirebaseFirestore.instance;

  static final almacenamiento = FirebaseStorage.instance;

}