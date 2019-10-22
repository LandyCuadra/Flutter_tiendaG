import 'package:flutter/material.dart';
import 'Fragments/visualizar_cierre.dart';
import 'Configuracion.dart';
import 'Home.dart';


void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "My Store",

    initialRoute: '/',
    routes: {
      '/': (context) => configuracion(),
      '/home': (context) => Home(),
      '/visualizar_cierre':(context)=> visualizar_cierre(),

    },
  ));
}




