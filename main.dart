import 'package:flutter/material.dart';
import 'package:calculadora/operaciones/suma.dart';
import 'package:calculadora/operaciones/resta.dart';
import 'package:calculadora/operaciones/producto.dart';
import 'package:calculadora/operaciones/division.dart';
import 'package:calculadora/operaciones/modulo.dart';
import 'package:calculadora/operaciones/potencia.dart';
import 'package:flutter/services.dart';
// Add more imports for each file in the 'operaciones' directory

const List<String> list = <String>['Suma', 'Resta', 'Producto', 'Division', 'Modulo', 'Potencia'];
String dropdownValue = list.first;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  double resultado = 0.0;

  void calcular(){
    if(num1Controller.text.isEmpty || num2Controller.text.isEmpty){
      return;
    }
    double num1 = double.parse(num1Controller.text);
    double num2 = double.parse(num2Controller.text);

    switch (dropdownValue) {
      case 'Suma':
        resultado = Suma(num1, num2).resultado();
        break;
      case 'Resta':
        resultado = Resta(num1, num2).resultado();
        break;
      case 'Producto':
        resultado = Producto(num1, num2).resultado();
        break;
      case 'Division':
        resultado = Division(num1, num2).resultado();
        break;
      case 'Modulo':
        resultado = Modulo(num1, num2).resultado();
        break;
      case 'Potencia':
        resultado = Potencia(num1, num2).resultado();
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: num1Controller,
                    decoration: const InputDecoration(hintText: 'Ingrese el primer número'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly // Solo permite dígitos
                  ],
                  ),
                ),
                const DropdownButtonExample(),
                Expanded(
                  child: TextField(
                    controller: num2Controller,
                    decoration: const InputDecoration(hintText: 'Ingrese el segundo número'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            Text(
              'Resultado: $resultado',
            ),
          ],
        ),
      ),
    );
  }
}
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}
