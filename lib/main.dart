import 'dart:typed_data';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
  double _altura = 0;
  double _peso = 0;
  double _imc = 0;
  static validateNumber(double number){
    if(number.isNegative){
      number = number.abs();
    }
    if (number.isNaN){
      number = 0;
    }
    return number;
  }

  void _calcularImc() {

    setState(() {
      _imc = double.parse((_peso / (_altura * _altura)).toStringAsFixed(2));
    });
    //setImcText(_imc)
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
          children: <Widget>[
            Text(
              'IMC: $_imc',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Aqui você digita seu PESO',
            ),

            TextField(onChanged: (number) {
              var novoNum = validateNumber(double.parse(number));
              setState(() {
                _peso = novoNum;
              });
            },),
            Text("Aqui a sua altura"),
            TextField(onChanged: (number) {
              var novoNum = validateNumber(double.parse(number));
              setState(() {
                _altura = novoNum;
              });
              },),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calcularImc,
        tooltip: 'Calcular IMC',
        child: Icon(Icons.accessibility_new_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
