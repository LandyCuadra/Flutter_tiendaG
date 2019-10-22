import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tienda/http/crud_database.dart';
import 'package:flutter_tienda/Fragments/visualizar_tiendas.dart';

class AddTiendas extends StatefulWidget {
  Function callback;
  Function handler;
  List tempt;
  AddTiendas(this.callback, this.handler, this.tempt);

  @override
  _AddTiendasState createState() => new _AddTiendasState(callback, handler, tempt);
}

class _AddTiendasState extends State<AddTiendas> {

  Function callback;
  Function handler;
  List tempv = List();
  List tempt = List();

  _AddTiendasState(this.callback, this.handler, this.tempt);
  TextEditingController controllerventa = new TextEditingController();
  TextEditingController controllertiendas = new TextEditingController();
  TextEditingController controllerventa_doc = new TextEditingController();
  TextEditingController controllerdocs = new TextEditingController();
  TextEditingController controllerventa_tienda = new TextEditingController();
  TextEditingController controllerventa_uds = new TextEditingController();

  var _validate = false;
  var _validate1 = false;
  var _validate2 = false;
  var _validate3 = false;
  var _validate4 = false;
  var _validate5 = false;

  String url = "https://pruebasorlando.000webhostapp.com/addtienda.php";


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Añadir Tienda"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                TextField(
                  controller: controllerventa,
                  decoration: new InputDecoration( labelText: "Venta",
                    errorText: _validate ? 'Campo obligatorio' : null,),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                    ] ,
                    keyboardType: TextInputType.number
                ),
                TextField(
                  controller: controllertiendas,
                  decoration: new InputDecoration( labelText: "cantidad tiendas",
                    errorText: _validate1 ? 'Campo obligatorio' : null),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                    ] ,
                    keyboardType: TextInputType.number

                ),
                TextField(
                  controller: controllerventa_doc,
                  decoration: new InputDecoration( labelText: "venta_doc",
                      errorText: _validate2 ? 'Campo obligatorio' : null),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                    ] ,
                    keyboardType: TextInputType.number

                ),
                TextField(
                  controller: controllerdocs,
                  decoration: new InputDecoration( labelText: "docs",
                      errorText: _validate3 ? 'Campo obligatorio' : null),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                    ] ,
                    keyboardType: TextInputType.number

                ),
                TextField(
                  controller: controllerventa_tienda,
                  decoration: new InputDecoration( labelText: "venta/tienda",
                      errorText: _validate4 ? 'Campo obligatorio' : null),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                    ] ,
                    keyboardType: TextInputType.number

                ),
                new TextField(
                  controller: controllerventa_uds,
                  decoration: new InputDecoration( labelText: "venta/uds",
                      errorText: _validate5 ? 'Campo obligatorio' : null),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                    ] ,
                    keyboardType: TextInputType.number

                ),

                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Añadir tienda"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (controllerventa.text.isEmpty) {
                      setState(() {
                        _validate = true;
                      });
                    } else {
                      setState(() {
                        _validate = false;
                      });
                    }

                    if (controllertiendas.text.isEmpty) {
                      setState(() {
                        _validate1 = true;
                      });
                    } else {
                      setState(() {
                        _validate1 = false;
                      });
                    }

                    if (controllerventa_doc.text.isEmpty) {
                      setState(() {
                        _validate2 = true;
                      });
                    } else {
                      setState(() {
                        _validate2 = false;
                      });
                    }

                    if (controllerdocs.text.isEmpty) {
                      setState(() {
                        _validate3 = true;
                      });
                    } else {
                      setState(() {
                        _validate3 = false;
                      });
                    }

                    if (controllerventa_tienda.text.isEmpty) {
                      setState(() {
                        _validate4 = true;
                      });
                    } else {
                      setState(() {
                        _validate4 = false;
                      });
                    }

                    if (controllerventa_uds.text.isEmpty) {
                      setState(() {
                        _validate5 = true;
                      });
                    } else {
                      setState(() {
                        _validate5 = false;
                      });
                    }

                    if(!_validate && !_validate1 && !_validate2 && !_validate3 && !_validate4 && !_validate5){

                      tempt.add({
                        "venta": controllerventa.text,
                        "cant_tiendas": controllertiendas.text,
                        "venta_doc": controllerventa_doc.text,
                        "docs": controllerdocs.text,
                        "venta_tienda": controllerventa_tienda.text,
                        "venta_uds": controllerventa_uds.text,

                      });
                      crud_database.addData(url, body: tempt.last);
                      this.callback(visualizar_tiendas(), 1);
                      this.handler(tempv,tempt);
                      Navigator.pop(context);
                    }

                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}