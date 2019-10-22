import 'package:flutter/material.dart';
import 'Fragments/editdata.dart';

class DetalleTienda extends StatefulWidget {
  List list;
  int index;
  DetalleTienda({this.index,this.list});

  @override
  _DetalleTiendaState createState() => new _DetalleTiendaState();
}

class _DetalleTiendaState extends State<DetalleTienda> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("${widget.list[widget.index]['id_tienda']}")),
      body: Column(
        children: <Widget>[
          Container(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Venta", style: TextStyle(fontSize: 25.0),),
                    Text(widget.list[widget.index]['venta'], style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Tiendas", style: TextStyle(fontSize: 25.0),),
                    Text(widget.list[widget.index]['cant_tiendas'], style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("venta/Doc", style: TextStyle(fontSize: 25.0),),
                    Text(widget.list[widget.index]['venta_doc'], style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Docs", style: TextStyle(fontSize: 25.0),),
                    Text(widget.list[widget.index]['docs'], style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Venta/Tienda", style: TextStyle(fontSize: 25.0),),
                    Text(widget.list[widget.index]['venta_tienda'], style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Card(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text("Venta/Uds", style: TextStyle(fontSize: 25.0),),
                    Text(widget.list[widget.index]['venta_uds'], style: TextStyle(fontSize: 40.0, color: Colors.blue[700]),),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}