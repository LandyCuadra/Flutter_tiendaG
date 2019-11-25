import 'package:flutter/material.dart';
import 'package:flutter_tienda/http/crud_database.dart';
import 'package:flutter_tienda/detalletienda.dart';
import 'package:flutter_tienda/view/datepicker_create.dart';

import '../http/crud_database.dart';

class visualizar_tiendas extends StatefulWidget {
  @override
  _visualizar_tiendasState createState() => _visualizar_tiendasState();
}

class _visualizar_tiendasState extends State<visualizar_tiendas> {

  final String url = "https://pruebasorlando.000webhostapp.com/gettiendas.php";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: datepicker(),
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
            new FutureBuilder<List>(
              future: crud_database.getDatos(url),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? new TableList(
                  list: snapshot.data,
                )
                    : new Center(
                  child: new CircularProgressIndicator(),
                );
              },
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
}

class TableList extends StatelessWidget {
  final List list;

  TableList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DetalleTienda(list: list, index: i,)
              ));
            },

            child: new Card(

              child: new ListTile(
                title: new Text(list[i]['id_tienda']),
                leading: new Icon(Icons.widgets),
                subtitle: new Text("venta: ${list[i]['venta']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
