import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class InteresProvider extends ChangeNotifier {

  String _baseUrl = 'http://192.168.1.67:3000';
  bool interes_consultorio_paciente = false;

  getInteresPacienteConsultorio( int id_paciente, int id_consultorio ) async {

    final res = await http.get(
      Uri.parse('${this._baseUrl}/interes_paciente_consultorio/${id_paciente}/${id_consultorio}')
    );

    if (res.statusCode == 200) {
      bool jsonResponse = convert.jsonDecode(res.body);
      interes_consultorio_paciente = jsonResponse;
    } else {
      return "Error";
    }
  }

  

  Future<bool> postInteres(int id_paciente, int id_consultorio) async {

    final http.Response res = await http.post(
      Uri.parse('${this._baseUrl}/interes'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, int>{
        'id_paciente': id_paciente,
        'id_consultorio': id_consultorio
      })
    );
    return await json.decode(res.body);
  }


  Future<bool> deleteInteres(int id_paciente, int id_consultorio) async {
    final http.Response res = await http.delete(
      Uri.parse('${this._baseUrl}/interes/${id_paciente}/${id_consultorio}')
    );
    return await json.decode(res.body);
  }


}