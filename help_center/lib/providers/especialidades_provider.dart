import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';

import 'package:http/http.dart' as http;

class EspecialidadesProvider extends ChangeNotifier {  

  String _baseUrl = 'http://192.168.1.67:3000';

  List<Especialidad> especialidades = [];
  List<Especialidad> consultorio_especialidades = [];


  // EspecialidadesProvider() {
  //   this.mostrarEspecialidades();
  // }


  Future<List<Especialidad>> mostrarEspecialidades() async {
    final res = await http.get(Uri.parse('${this._baseUrl}/especialidades'));
    Iterable jsonResponse = convert.jsonDecode(res.body);
    List<Especialidad> es = List<Especialidad>.from(jsonResponse.map((e) => Especialidad.fromJson(e)));
    this.especialidades = es;
    return es;
  }

  getEspecialidadesConsultorio(int id) async {
   final res = await http.get(Uri.parse('${this._baseUrl}/consultorio_especialidades/${id}'));
   if (res.statusCode == 200) {
     Iterable jsonResponse = convert.jsonDecode(res.body);
     List<Especialidad> es = List<Especialidad>.from(jsonResponse.map((e) => Especialidad.fromJson(e)));
     this.consultorio_especialidades = es;
   } else {
     print("Error");
   }
   
  notifyListeners();

  }

}