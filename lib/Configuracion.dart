import 'package:flutter/material.dart';
import 'package:flutter_tienda/Home.dart';
import 'package:flutter_tienda/Model/credencial_basedatos.dart';
import 'package:flutter_tienda/http/crud_database.dart';

class configuracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController database = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Configuracion"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[

            TextField(
              decoration: InputDecoration(labelText: "Usuario", icon: Icon(Icons.person)),
              controller: username,
              onTap: (){
                username.text = "id11170913_landy";
              },
            ),

              TextField(
              decoration: InputDecoration(labelText: "Contraseña", icon: Icon(Icons.security)),
            controller: password,
                onTap: (){
                  password.text = "123456";
                },
            ),
            TextField(
            decoration: InputDecoration(labelText: "Base de datos", icon: Icon(Icons.backup)),
            controller: database,
              onTap: (){
                database.text = "id11170913_tiendas";
              },
            ),

            FlatButton(child: Text("Configurar"),
            onPressed: () {
              credencial_basedatos credenciales = credencial_basedatos();
              crud_database.addData("https://pruebasorlando.000webhostapp.com/conn.php", body: {

                "username": username.text,
                "password": password.text,
                "database": database.text
              }).then((response){
                if(response.statusCode < 200 || response.statusCode > 400 || response.body != "conectado") {
                  print("============================================ : "+ response.body);

                }else{
                  print("============================================ : "+ response.body);
                  credenciales.username = username.text;
                  credenciales.password = password.text;
                  credenciales.dabatase = database.text;

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (BuildContext context) =>
                          Home(credenciales: credenciales,)));
                }
              });

            },)
          ],
        ),
      ),
    );
  }
}
