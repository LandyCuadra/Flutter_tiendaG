import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_tienda/Model/credencial_basedatos.dart';
import 'package:flutter_tienda/http/crud_database.dart';
import 'package:flutter_tienda/Utils/local_notifications_helper.dart';
import 'package:flutter_tienda/addVentas.dart';
import 'Fragments/visualizar_cierre.dart';
import 'Fragments/visualizar_tiendas.dart';
import 'Fragments/visualizar_ventas.dart';
import 'addTiendas.dart';
import 'view/drawer_create.dart';
import 'package:rxdart/rxdart.dart';

class Home extends StatefulWidget {
  credencial_basedatos credenciales;

  Home({this.credenciales});
  @override
  _HomeState createState() => new _HomeState(credenciales);
}

class _HomeState extends State<Home> {
  credencial_basedatos credenciales;
  _HomeState(this.credenciales);

  FlutterLocalNotificationsPlugin localNotifications = new FlutterLocalNotificationsPlugin();
  List datos_nuevos_venta = List();
  List datos_temp_venta = List();

  List datos_nuevos_tienda = List();
  List datos_temp_tienda = List();

  List datos_nuevos_cierre = List();
  List datos_temp_cierre = List();

  String urlv = "https://pruebasorlando.000webhostapp.com/getventas.php";
  String urlt = "https://pruebasorlando.000webhostapp.com/gettiendas.php";
  String urlc = "https://pruebasorlando.000webhostapp.com/getcierres.php";

  Widget view;
  int i = 0;

  StreamController<List> stream = BehaviorSubject();


  @override
  void initState() {
    // TODO: implement initState
    iniciar();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    localNotifications.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    localNotifications.cancelAll();
    super.initState();
  }

  Future _fetchData() async {
    List data = await crud_database.getDatos(urlv,body: credenciales.toMap());
    if (data == null) {
      stream.sink.addError("No data, trying again");
      return await _fetchData();
    }
    stream.sink.add(data);
  }

  @override
  Widget build(BuildContext context) {
    drawer_create drawer = drawer_create();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tienda"),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            if (i == 0) {

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AddVentas(this.callback, this.handlerEnvioDatos, datos_temp_venta)));
            } else if (i == 1) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      AddTiendas(this.callback, this.handlerEnvioDatos, datos_temp_tienda)));
            }
          }
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            drawer.createHeader(),
            drawer.createDrawerItem(
              icon: Icons.monetization_on,
              text: "Ventas",
              onTap: () {
                this.callback(visualizar_ventas(stream),0);
                Navigator.of(context).pop();
              }, ),

            drawer.createDrawerItem(
                icon: Icons.store,
                text: "Tienda",
                onTap: () {
                  this.callback(visualizar_tiendas(),1);
                  Navigator.of(context).pop();
                }
            ),

            drawer.createDrawerItem(
                icon: Icons.web,
                text: "Cierre",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          visualizar_cierre()));
                }
            )
          ],
        ),
      ),

      body: view,

    );
  }

  Future onSelectNotification(String payload) async {

    if(payload == "0" ){
      var esactual = false;
      var ruta_home = "/home";
      Navigator.of(context).popUntil((route){
        if(route.settings.name == ruta_home){
          esactual = true;
          return true;
        }
        return true;
      });

      if(!esactual){
        Navigator.of(context).pop();
      }
    }

    if(payload == "1" ){
      Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
      this.callback(visualizar_tiendas(), 1);
    }

    if(payload == "2"){
      var esactual = false;
      var ruta_cierre = "/visualizar_cierre";
      Navigator.of(context).popUntil((route){
          if(route.settings.name == ruta_cierre){
            esactual = true;
            Navigator.popAndPushNamed(context, ruta_cierre);
            return true;
          }
            return true;
      });

      if(!esactual){
        Navigator.of(context).pushNamed(ruta_cierre);
      }
    }
  }

  void revisarNuevosDatos() async{

    datos_nuevos_venta = await crud_database.getDatos(urlv, body: credenciales.toMap());
    //datos_nuevos_tienda = await crud_database.getDatos(urlt);
    //datos_nuevos_cierre = await crud_database.getDatos(urlc);

    if(datos_temp_venta.length < datos_nuevos_venta.length && datos_temp_venta.length>0){
      String monto = datos_nuevos_venta.last['ingreso'];
      showOngoingNotifications(localNotifications, title: "Hay una nueva venta", body: "Nueva venta por un monto de :\$ $monto", id: 0, payload: "0");
    }

    if(datos_temp_tienda.length < datos_nuevos_tienda.length && datos_temp_tienda.length>0){
      String monto = datos_nuevos_tienda.last['venta'];
      showOngoingNotifications(localNotifications, title: "Hay un dato en tienda", body: "Nuevo dato en tienda por un monto de :\$ $monto", id: 1, payload: "1");
    }

    if(datos_temp_cierre.length < datos_nuevos_cierre.length && datos_temp_cierre.length>0){
      String id = datos_nuevos_cierre.last['id_cierre'];
      showOngoingNotifications(localNotifications, title: "Nuevo cierre", body: "Llego el cierre numero :\$ $id", id: 2, payload: "2");
    }

    if(datos_temp_venta.length < datos_nuevos_venta.length)
      datos_temp_venta = datos_nuevos_venta;
    if(datos_temp_tienda.length < datos_nuevos_tienda.length)
      datos_temp_tienda = datos_nuevos_tienda;
    if(datos_temp_cierre.length < datos_nuevos_cierre.length)
      datos_temp_cierre = datos_nuevos_cierre;
  }


  Timer iniciar() {
    return Timer.periodic(Duration(seconds: 5), (timer) {
      revisarNuevosDatos();

      if (i == 0) {
        _fetchData();
        callback(visualizar_ventas(stream), 0);
      } else if (i == 1) {
        callback(visualizar_tiendas(), 1);
      }
    });
  }

  void callback(Widget nextview, int j) {
    setState(() {
      this.view = nextview;
      this.i = j;
    });
  }

  void handlerEnvioDatos(List tempv, List tempt){

    setState(() {
      if(tempv.length > this.datos_temp_venta.length){
        this.datos_temp_venta = tempv;
      }
      if(tempt.length > this.datos_temp_tienda.length){
        this.datos_temp_tienda = tempt;
      }

    });
  }
}
