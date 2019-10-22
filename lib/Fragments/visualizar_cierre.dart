import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../http/crud_database.dart';

class visualizar_cierre extends StatefulWidget {
  @override
  _visualizar_cierreState createState() => _visualizar_cierreState();
}

class _visualizar_cierreState extends State<visualizar_cierre> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  String url = "https://pruebasorlando.000webhostapp.com/getcierres.php";
  List datos_cierre = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cierre"),
      ),
      body: FutureBuilder(
        future: crud_database.getDatos(url),
        builder: (context, snapshot){
          if(snapshot.hasError) print(snapshot.error);

          if( snapshot.hasData){
            datos_cierre = snapshot.data;
            return WebView(
              initialUrl: UriData.fromString(datos_cierre.last["webhtml"], mimeType: "text/html").toString() ,
              onWebViewCreated: (WebViewController webViewController){
                _controller.complete(webViewController);
              },
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }


        },
      ),

    );
  }
}
