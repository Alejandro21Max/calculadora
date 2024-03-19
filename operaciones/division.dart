import 'package:calculadora/operaciones/operacion.dart';

class Division extends Operacion{
  Division(double n1, double n2) : super(n1, n2){
    r = n1 / n2;
  }
}