
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tienda/Utils/local_notifications_helper.dart';
import 'package:flutter_tienda/http/crud_database.dart';
import 'package:flutter_tienda/Fragments/visualizar_ventas.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AddVentas extends StatefulWidget {
  Function callback;
  Function handler;
  List tempv;
  AddVentas(this.callback, this.handler, this.tempv);

  @override
  _AddVentasState createState() => new _AddVentasState(callback, handler, tempv);
}

class _AddVentasState extends State<AddVentas> {

  Function callback;
  Function handler;
  List tempv = List();
  List tempt = List();
  _AddVentasState(this.callback, this.handler, this.tempv);
  TextEditingController controllerfecha = new TextEditingController();
  TextEditingController controllerhora = new TextEditingController();
  TextEditingController controlleringreso = new TextEditingController();
  String url = "https://pruebasorlando.000webhostapp.com/addventas.php";
  var _validate = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Añadir venta"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerfecha,
                  decoration: new InputDecoration(
                      hintText: DateTime.now().toString(),
                      labelText:DateFormat("yyyy-MM-dd").format(DateTime.now()).toString() ),
                  onTap: (){
                      _selectDate(context);

                  },
                ),
                TextField(
                  controller: controllerhora,
                  decoration: new InputDecoration(
                      enabled: false,
                      labelText: DateTime.now().hour.toString()+":"+DateTime.now().minute.toString()),
                ),
                new TextField(
                  controller: controlleringreso,
                  decoration: new InputDecoration(labelText: "Ingreso",
                    errorText: _validate ? 'Campo obligatorio' : null,),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("^\$|^(0|([1-9][0-9]{0,20}))(\\.[0-9]{0,2})?\$")),
                  ] ,

                ),

                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Añadir Venta"),
                  color: Colors.blueAccent,
                  onPressed: () {

                    if(controlleringreso.text.isEmpty){
                      setState(() {
                        _validate = true ;
                      });
                    }else{
                      _validate = false;
                      controllerhora.text = DateTime.now().hour.toString();
                      controllerfecha.text = DateFormat("yyyy-MM-dd").format(selectedDate).toString();
                      tempv.add({
                        "fecha_venta": controllerfecha.text,
                        "hora_venta": controllerhora.text,
                        "ingreso": controlleringreso.text
                      });

                      crud_database.addData(url, body: tempv.last);
                      //this.callback(visualizar_ventas(), 0);
                      this.handler(tempv,tempt);
                      Navigator.pop(context);
                    }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        controllerfecha.text = DateFormat("yyyy-MM-dd").format(selectedDate).toString();
      });
  }
}