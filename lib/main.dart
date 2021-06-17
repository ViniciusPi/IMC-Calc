import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightcontroller = TextEditingController();
  TextEditingController heightcontroller = TextEditingController();
  int index = 15478;

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _info = "Informe seus dados";

  void _reset() {
    weightcontroller.text = '';
    heightcontroller.text = '';
    setState(() {
      index = 15478;
      _info = "Informe seus dados";
      _formkey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightcontroller.text);
      double height = double.parse(heightcontroller.text) / 100;
      double imc = weight / (height * height);
      if (imc < 18.6) {
        _info = "Abaixo do peso ${imc.toStringAsPrecision(3)}";
        setState(() {
          index = 0;
        });
      } else if (imc > 18.6 && imc < 24.9) {
        _info = "peso ideal  ${imc.toStringAsPrecision(3)}";
        setState(() {
          index = 1;
        });
      } else if (imc > 24.9 && imc < 29.9) {
        _info = "levemente acima do peso ${imc.toStringAsPrecision(3)}";
        setState(() {
          index = 2;
        });
      } else if (imc > 29.9 && imc < 34.9) {
        _info = " obesidade grau I ${imc.toStringAsPrecision(3)}";
        setState(() {
          index = 3;
        });
      } else if (imc > 34.9 && imc < 39.9) {
        _info = "obesidade grau II  ${imc.toStringAsPrecision(3)}";
        setState(() {
          index = 4;
        });
      } else if (imc >= 40) {
        _info = " obesidade grau III  ${imc.toStringAsPrecision(3)}";
        setState(() {
          index = 5;
        });
      }
    });
  }

  colorController() {
    switch (index) {
      case 0:
        return Colors.grey;
        break;
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.lime;
        break;
      case 3:
        return Colors.orange;
        break;
      case 4:
        return Colors.red;
        break;
      case 5:
        return Colors.red[900];
        break;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calculo de imc'),
        centerTitle: true,
        backgroundColor: colorController(),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _reset,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0.0, 10.0, 0.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.person_outline_sharp,
                  size: 120, color: colorController()),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'Peso (Kg)',
                    labelStyle: TextStyle(color: colorController())),
                textAlign: TextAlign.center,
                style: TextStyle(color: colorController(), fontSize: 15.0),
                controller: weightcontroller,
                // ignore: missing_return
                validator: (value) {
                  if (value!.isEmpty) {
                    return "insira seu peso!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'altura (cm)',
                    labelStyle: TextStyle(color: colorController())),
                textAlign: TextAlign.center,
                style: TextStyle(color: colorController(), fontSize: 15.0),
                controller: heightcontroller,
                // ignore: missing_return
                validator: (value) {
                  if (value!.isEmpty) {
                    return "insira sua altura!";
                  }
                },
              ),
              Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          _calculate();
                        }
                      },
                      child: Text(
                        'calcular',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      color: colorController(),
                    ),
                  )),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: colorController(), fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
