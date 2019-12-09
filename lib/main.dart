import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int itemSelected;

  bool interrupteur = false;

  double sliderDouble = 0.0;

  DateTime date;
  TimeOfDay time;

  List<Widget> radios() {
    List<Widget> l = [];
    for (int x = 0 ; x < 4 ; x++) {
      Row row = Row(
        children: <Widget>[
          Text("Choix numéro ${x + 1}"),
          Radio(value: x, groupValue: itemSelected, onChanged: (int i) {
            setState(() {
              itemSelected = i;
            });
          }),
        ],
      );
      l.add(row);
    }
    return l;
  }

  Map check = {
    "Carottes": false,
    "Bananes": false,
    "Yaourts": false,
    "Pain": false
  };

  List<Widget> checkList() {
    List<Widget> l = [];
    check.forEach((key, value) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(key, style: TextStyle(color: (value)? Colors.green : Colors.red, fontWeight: FontWeight.bold),),
          Checkbox(
            value: (value),
            onChanged: (bool b) {
              setState(() {
                check[key] = b;
              });
            },
          )
        ],
      );
      l.add(row);
    });
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text((date == null) ? 'Appuyez moi': date.toString()),
              onPressed: montrerDate,
            ),
            FlatButton(
              child: Text((time == null) ? 'Appuyez moi': time.toString()),
              onPressed: montrerHeure,
            ),
          ],
        ),
      ),
    );
  }

  Future montrerDate() async {
    DateTime choix = await showDatePicker(context: context, initialDatePickerMode: DatePickerMode.year, initialDate: DateTime.now(), firstDate: DateTime(1983), lastDate: DateTime(2045));
    if (choix != null) {
      setState(() {
        date = choix;
      });
    }
  }
  Future montrerHeure() async {
    TimeOfDay heure = await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (heure != null) {
      setState(() {
        time = heure;
      });
    }
  }
}