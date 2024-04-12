import 'package:flutter/material.dart';
import 'package:calculadora/operaciones/suma.dart';
import 'package:calculadora/operaciones/resta.dart';
import 'package:calculadora/operaciones/producto.dart';
import 'package:calculadora/operaciones/division.dart';
import 'package:calculadora/operaciones/modulo.dart';
import 'package:calculadora/operaciones/potencia.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

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

class CustomInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final hasOnlyOneMinus = newValue.text.split('-').length - 1 <= 1;
    final hasOnlyOneDot = newValue.text.split('.').length - 1 <= 1;
    final hasValidCharacters = newValue.text.replaceAll(RegExp(r'[-0-9.]'), '').isEmpty;
    final minusIsAtBeginning = !newValue.text.startsWith('-') || newValue.text.indexOf('-') == 0;

    if (hasOnlyOneMinus && hasOnlyOneDot && hasValidCharacters && minusIsAtBeginning) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  late TextEditingController activeController;
  double resultado = 0.0;

  _MyHomePageState() {
    activeController = num1Controller; // Nuevo: inicializar el controlador activo con num1Controller
  }

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

    num1Controller.clear();
    num2Controller.clear();
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
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: num1Controller,
                    decoration: const InputDecoration(hintText: 'Ingrese el primer número'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      CustomInputFormatter(), // Solo permite dígitos
                    ],
                    onTap:() {
                      activeController = num1Controller;
                    },
                  ),
                  
                ),
                const SizedBox(width: 20),
                const DropdownButtonExample(),
                const SizedBox(width: 20),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: num2Controller,
                    decoration: const InputDecoration(hintText: 'Ingrese el segundo número'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      CustomInputFormatter(),
                    ],
                    onTap:() {
                      activeController = num2Controller;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return ElevatedButton(
                      onPressed: () {
                        activeController.text = activeController.text + (index + 1).toString();
                      },
                      child: Text((index + 1).toString()),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return ElevatedButton(
                      onPressed: () {
                        activeController.text = activeController.text + (index + 4).toString();
                      },
                      child: Text((index + 4).toString()),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return ElevatedButton(
                      onPressed: () {
                        activeController.text = activeController.text + (index + 7).toString();
                      },
                      child: Text((index + 7).toString()),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        activeController.text = activeController.text + '.';
                      },
                      child: Text('.'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        activeController.text = activeController.text + '0';
                      },
                      child: Text('0'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (activeController.text.isEmpty) {
                          activeController.text = activeController.text + '-';
                        }
                      },
                      child: Text('-'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        activeController.clear();
                      },
                      child: Text('AC'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (activeController.text.isNotEmpty)
                          activeController.text = activeController.text.substring(0, activeController.text.length - 1);
                      },
                      child: Text('DEL'),
                    ),
                  ],
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
              style: TextStyle(
                fontSize: 24, // Ajusta el tamaño de la fuente según tus necesidades
                fontWeight: FontWeight.bold, // Hace que el texto sea negrita
                color: Colors.teal, // Cambia el color del texto
              ),
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
