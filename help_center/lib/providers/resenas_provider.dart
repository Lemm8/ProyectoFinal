import 'package:flutter/material.dart';
import 'package:help_center/models/resena.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ResenasProvider extends ChangeNotifier {

  String _baseUrl = 'http://192.168.1.67:3000';

  List<Resena> resenas = [];
  //Resena nueva_resena = ;

  getResenasConsultorio( int id_consultorio ) async {

    final res = await http.get(
      Uri.parse('${this._baseUrl}/resenas_consultorio/${id_consultorio}')
    );
    if (res.statusCode == 200) {
      Iterable jsonResponse = convert.jsonDecode(res.body);
      List<Resena> rs = List<Resena>.from(jsonResponse.map((e) => Resena.fromJson(e)));
      this.resenas = rs;
    } else {
      print("Error");
    }

    notifyListeners();
  }


  Future<dynamic> registroResena( int id_paciente, int id_consultorio, double calificacion, String comentario ) async {
    final http.Response response = await http.post(
      Uri.parse('${this._baseUrl}/resena'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: convert.jsonEncode(<String, dynamic>{
        'id_paciente': id_paciente,
        'id_consultorio': id_consultorio, 
        'calificacion': calificacion, 
        'comentario': comentario 
      })
    );  
    return await convert.json.decode(response.body);
  }

}