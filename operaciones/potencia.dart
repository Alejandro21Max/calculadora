import 'package:calculadora/operaciones/operacion.dart';
import 'dart:math';

class Potencia extends Operacion{
  Potencia(double n1, double n2) : super(n1, n2){
    r = pow(n1, n2).toDouble();
  }
}