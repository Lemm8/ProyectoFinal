import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';

import 'package:http/http.dart' as http;

class ConsultoriosProvider extends ChangeNotifier {  

  String _baseUrl = 'http://192.168.1.67:3000';

  List<Consultorio> consultorios = [];


  ConsultoriosProvider() {
    this.mostrarConsultorios();
  }


  mostrarConsultorios() async {
    final res = await http.get(Uri.parse('${this._baseUrl}/consultorios'));
    if (res.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(res.body);
      List<Consultorio> cs = List<Consultorio>.from(jsonResponse.map((e) => Consultorio.fromJson(e)));
      this.consultorios = cs;
    } else {
      print("Error");
    }

    notifyListeners();

  }

  mostrarConsultoriosServicios(int id_consultorio) async {
    final res = await http.get(Uri.parse('${this._baseUrl}/consultorios/consultorio_servicios/${id_consultorio}'));
    if (res.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(res.body);
      List<Consultorio> cs = List<Consultorio>.from(jsonResponse.map((e) => Consultorio.fromJson(e)));
      this.consultorios = cs;
    } else {
      print("Error");
    }

    notifyListeners();
  }

  mostrarConsultoriosInteres(int id_paciente) async {
    final res = await http.get(Uri.parse('${this._baseUrl}/consultorios/consultorios_interes/${id_paciente}'));
    if (res.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(res.body);
      List<Consultorio> cs = List<Consultorio>.from(jsonResponse.map((e) => Consultorio.fromJson(e)));
      this.consultorios = cs;
    } else {
      print("Error");
    }

    notifyListeners();
  }

  mostrarConsultoriosProfesional(int id_profesional) async {
    final res = await http.get(Uri.parse('${this._baseUrl}/consultorios_profesional/${id_profesional}'));
    if (res.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(res.body);
      List<Consultorio> cs = List<Consultorio>.from(jsonResponse.map((e) => Consultorio.fromJson(e)));
      this.consultorios = cs;
    } else {
      print("Error");
    }

    notifyListeners();
  }

}