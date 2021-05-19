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
      title: 'Calculadora IMC',
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Color(0xff272727),
        accentColor: Color(0xff102a43),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculadora IMC'),
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
  var _displayText = {"textColor": Colors.black12, "text": ""};

  static validateNumber(double number) {
    if (number.isNegative) {
      number = number.abs();
    }
    if (number.isNaN) {
      number = 0;
    }
    if(number.toString().contains(',')){
      number = double.parse(number.toString().replaceFirst(',', '.'));
    }
    return number;
  }

  void _calcularImc() {
    setState(() {
      _imc = double.parse((_peso / (_altura * _altura)).toStringAsFixed(2));
    });
    setImcText(_imc);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

            Text(
              'Aqui você digita seu PESO (Kg)',
            ),
            TextField(
              decoration: InputDecoration(hintText: "ex: 68.9"),
              onChanged: (number) {
                var novoNum = validateNumber(double.parse(number));
                setState(() {
                  _peso = novoNum;
                });
              },
            ),
            Text("Aqui a sua altura (m)"),
            TextField(
              decoration: InputDecoration(hintText: "ex: 1.69"),
              onChanged: (number) {
                var novoNum = validateNumber(double.parse(number));
                setState(() {
                  _altura = novoNum;
                });
              },
            ),
              Text(
                'IMC: $_imc',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                _displayText['text'],
                style: TextStyle(color: _displayText['textColor']),
              ),
          ],
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calcularImc,
        tooltip: 'Calcular IMC',
        child: Icon(Icons.accessibility_new_sharp),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void setImcText(double imc) {
    var texto;
    var cor;
    if (imc < 18.5) {
      texto = "Abaixo do peso";
      cor = Colors.deepOrange;
    } else {
      if (imc < 24.999) {
        texto = "Peso ideal";
        cor = Colors.green;
      } else {
        if (imc < 29.999) {
          texto = "Sobrepeso";
          cor = Colors.amber;
        } else {
          if (imc < 34.999) {
            texto = "Obesidade - Grau 1";
            cor = Colors.deepOrange;
          } else {
            if (imc < 39.999) {
              texto = "Obesidade - Grau 2";
              cor = Colors.red;
            } else {
              texto = "Obesidade Mórbida";
              cor = Colors.red;
            }
          }
        }
      }
    }
    setState(() {
      _displayText['text'] = texto;
      _displayText['textColor'] = cor;
    });
  }
}
