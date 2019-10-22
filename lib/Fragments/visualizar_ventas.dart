import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tienda/Model/credencial_basedatos.dart';
import 'package:flutter_tienda/http/crud_database.dart';
import 'package:flutter_tienda/view/datepicker_create.dart';
import 'package:intl/date_symbol_data_custom.dart';
import 'package:intl/intl.dart';
import '../http/crud_database.dart';


class visualizar_ventas extends StatefulWidget {
  StreamController stream;
  visualizar_ventas(this.stream);
  DateTime dateselected = DateTime.now();
  @override
  _visualizar_ventasState createState() => _visualizar_ventasState(stream, dateselected: dateselected);
}


class _visualizar_ventasState extends State<visualizar_ventas> {
  DateTime dateselected;
  StreamController stream;
  _visualizar_ventasState(this.stream, {this.dateselected});

  String fecha_seleccionada = DateFormat("yyyy-MM-dd")
      .format(DateTime.now())
      .toString();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (dateselected.isBefore(DateTime.now())) {

                  } else
                    dateselected = dateselected.add(Duration(days: -1));
                  actualizar_fecha(
                      DateFormat("yyyy-MM-dd").format(dateselected).toString());
                },
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Text(fecha_seleccionada),
              ),

              FlatButton(
                child: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  dateselected = dateselected.add(Duration(days: 1));
                  actualizar_fecha(
                      DateFormat("yyyy-MM-dd").format(dateselected).toString());
                },

              ),
              Icon(Icons.calendar_today),
            ],
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Dia",),
              Tab(text: "Semana",),
              Tab(text: "Mes",),
              Tab(text: "Trimeste",),
              Tab(text: "Año",)

            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                      stream: stream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);

                        if(snapshot.hasData){

                          return ItemTable(
                          list: snapshot.data,
                          date: dateselected,
                        );
                        }else {
                           return Center(
                          child: new CircularProgressIndicator(),
                          );
                        }


                      }
                  )
/*
                  FutureBuilder<List>(
                    future: crud_database.getDatos(url),

                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);

                      return snapshot.hasData
                          ? new ItemTable(
                        list: snapshot.data,
                        date: dateselected,
                      )
                          : new Center(
                        child: new CircularProgressIndicator(),
                      );
                    },
                  )
*/
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Text("Aqui va a haber un filtro por semana")
              ],
            ),
            Column(
              children: <Widget>[
                Text("Aqui va a haber un filtro por mes")
              ],
            ),
            Column(
              children: <Widget>[
                Text("Aqui va a haber un filtro por trimestre")
              ],
            ),
            Column(
              children: <Widget>[
                Text("Aqui va a haber un filtro por año")
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateselected,
        firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateselected)
      setState(() {
        dateselected = picked;
        actualizar_fecha(DateFormat("yyyy-MM-dd").format(dateselected).toString());
      });
  }

  void actualizar_fecha(String newdate) {
    setState(() {
      fecha_seleccionada = newdate;
    });
  }
}

String dias(int day){
  switch(day){
    case 1:
      return "Lunes";
    case 2:
      return "Martes";
    case 3:
      return "Miercoles";
    case 4:
      return "Jueves";
    case 5:
      return "Viernes";
    case 6:
      return "Sabado";
    case 7:
      return "Domingo";
    default:
      return "";
  }
}

class ItemTable extends StatelessWidget {
  final List list;
  DateTime date;
  ItemTable({this.list,this.date});
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              //width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: DataTable(columnSpacing: ((MediaQuery.of(context).size.width/100)*8),
                columns: [
                  DataColumn(label: Text('Hora')),
                  DataColumn(label: Text('Dia de la semana')),
                  DataColumn(label: Text('Ingreso')),
                  DataColumn(label: Text('Total')),

                ],

                rows:
                  list.map(
                    ((element) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(element["hora_venta"])), //Extracting from Map element the value
                        DataCell(Text(dias(DateTime.parse(element['fecha_venta']).weekday))),
                        DataCell(Text(element["ingreso"])),
                        DataCell(Text(""))
                      ],
                    )),
                  ).toList()

              ),
            ),
          ],

        )
    );
  }
}

