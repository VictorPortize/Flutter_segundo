import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey;

  String _info = 'Informe seus dados: ';

  void _resetFilds() {
    weightController.text = '';
    heightController.text = '';
    setState(() {
      _info = 'Informe seus dados: ';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculaIMG() {
    double peso = double.parse(weightController.text);
    double altura =
        double.parse(heightController.text.replaceAll(',', '.')) / 100;
    //Peso dividido pelo quadrado da altura: 70 / 2,89 = 24,22
    double imc = peso / (altura * altura);

    setState(() {
      if (imc < 18.5) {
        _info = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc < 24.9) {
        _info = "Peso ideial (${imc.toStringAsPrecision(4)})";
      } else if (imc < 29.9) {
        _info = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc < 34.9) {
        _info = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc < 39.9) {
        _info = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else {
        _info = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFilds,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira seu peso!';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Insira um número válido';
                      } else if (double.parse(value) < 1) {
                        return "Insira um número válido";
                      }
                    },
                    controller: weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Insira sua altura!';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Insira um número válido';
                      } else if (double.parse(value) < 20) {
                        return "Insira um número válido";
                      }
                    },
                    controller: heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (cm)",
                        labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculaIMG();
                          }
                        },
                        child: Text(
                          'Calcular',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(
                    _info,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25.0),
                  )
                ],
              ),
            )));
  }
}
