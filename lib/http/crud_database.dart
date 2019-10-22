import 'dart:convert';
import 'package:http/http.dart' as http;


class crud_database{

   static Future<List> getDatos(String url, {Map<String, dynamic> body}) async {
    final response = await http.post(url, body: body);
    return json.decode(response.body);
  }



   static Future<http.Response> addData(String url, {Map<String, dynamic> body}) async {
     return await http.post(url, body: body);
   }

   void deleteData(Map<String, dynamic> body){
     var url="http://10.0.2.2/my_store/deleteData.php";
     http.post(url, body: body);
   }
}