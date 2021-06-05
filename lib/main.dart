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
  double _altura = 1.50;
  double _peso = 65;
  double _imc = 0;

  double _minPeso = 40;
  double _maxPeso = 150;
  double _minAltura = 1.50;
  double _maxAltura = 2.10;
  int pesoValues = 5;
  int alturaValues = 5;
  var _displayText = {"textColor": Colors.black12, "text": ""};

  void pesoNumbers(){
    int formula = _maxPeso.toInt() - _minPeso.toInt() * 10;
    setState(() => {
      if(formula * 10 < 1 || formula * 10 == null){
        pesoValues = 200
      }else{
        pesoValues = formula
      }
    });
  }
  void alturaNumbers(){
    int formula = (_maxAltura*100 - _minAltura * 100).toInt();
    setState(() => {
      if(formula < 1 || formula == null){
        alturaValues = 40
      }else{
        alturaValues = formula
      }
    });
  }
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

            Container(
              width: double.infinity,
              child: Text(
                'Arraste até o seu PESO (Kg)',textAlign: TextAlign.start,
              ),
            ),Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(child: Text("Peso menos que $_minPeso"), onPressed: () {
                    if(_minPeso >= 20){
                      setState(() {
                        _minPeso = _minPeso - 5;
                      });
                    }
                  },),
                  TextButton(child: Text("Peso mais que $_maxPeso"), onPressed: (){
                    if(_maxPeso <= 250){
                      setState(() {
                        _maxPeso = _maxPeso + 20;
                      });
                    }
                  },),
                    ],
              ),
            Slider(
              onChangeStart: (value) => pesoNumbers(),
              onChangeEnd: (value) => _calcularImc(),
              value: _peso,
              onChanged: (newPeso){
                setState(() {
                  _peso = newPeso;
                });
              },
              min: _minPeso,
              max: _maxPeso,
              label: _peso.toStringAsFixed(2)+" Kg",
              divisions: pesoValues,
            ),

            Container(
              width: double.infinity,
              child: Text("Sua altura (m)", textAlign: TextAlign.left),
            ),
            Slider(
              onChangeStart: (value) => alturaNumbers(),
              onChangeEnd: (value) => _calcularImc(),
              value: _altura,
              onChanged: (newAltura){
                setState(() {
                  _altura = newAltura;
                });
              },
              min: _minAltura,
              max: _maxAltura,
              label: _altura.toStringAsFixed(2)+" m",
              divisions:alturaValues,
            ),
              Text( _peso.toStringAsFixed(2)+" Kg - "+_altura.toStringAsFixed(2)+" m",style: TextStyle(fontSize: 24.0),),
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
