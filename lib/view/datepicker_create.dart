import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class datepicker extends StatefulWidget {
  @override
  _datepickerState createState() => _datepickerState();
}

class _datepickerState extends State<datepicker> {
  DateTime dateselected = DateTime.now();

  static String fecha_seleccionada = DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Icon(Icons.arrow_back_ios),
          onPressed: (){
            if(dateselected.isBefore(DateTime.now())){

          }else
            dateselected = dateselected.add(Duration(days: -1));
            actualizar_fecha(DateFormat("yyyy-MM-dd").format(dateselected).toString());
          },
        ),
        GestureDetector(
          onTap: (){
            _selectDate(context);
          },
          child:Text(fecha_seleccionada),
        ),

        FlatButton(
          child: Icon(Icons.arrow_forward_ios),
          onPressed: (){
              dateselected = dateselected.add(Duration(days: 1));
              actualizar_fecha(DateFormat("yyyy-MM-dd").format(dateselected).toString());
          },

        ),
        Icon(Icons.calendar_today),
      ],
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateselected,
        firstDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
        lastDate: DateTime(2101));
    if (picked != null && picked != dateselected)
      setState(() {
        dateselected = picked;
        actualizar_fecha(DateFormat("yyyy-MM-dd").format(dateselected).toString());
      });
  }

  void actualizar_fecha(String newdate){
    setState(() {
      fecha_seleccionada = newdate;
    });
}
}
