import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:help_center/models/models.dart';
import 'package:http/http.dart' as http;


class AuthProvider extends ChangeNotifier {

  String _baseUrl = 'http://192.168.1.67:3000/auth';

  Consultorio? consultorio;
  Paciente? paciente;
  Profesional? profesional;

  Future<dynamic> registroPaciente( String nombre, String apellidos, String correo, String contrasena ) async {

    final http.Response response = await http.post(
      Uri.parse('${this._baseUrl}/registro_paciente'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'apellidos': apellidos, 
        'correo': correo, 
        'contrasena': contrasena 
      })
    );
    
    if(response.statusCode == 200) {

      var jsonResponse = json.decode(response.body);
      Paciente pc = Paciente.fromJson(jsonResponse);
      this.paciente = pc;
      return await json.decode(response.body);

    } else {

      return await false;

    }
  }



  Future<dynamic> registroProfesional( String nombre, String apellidos, String correo, String contrasena ) async {

    final http.Response response = await http.post(
      Uri.parse('${this._baseUrl}/registro_profesional'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'apellidos': apellidos, 
        'correo': correo, 
        'contrasena': contrasena 
      })
    );
    
    if(response.statusCode == 200) {

      var jsonResponse = json.decode(response.body);
      Profesional pr = Profesional.fromJson(jsonResponse);
      this.profesional = pr;
      return await json.decode(response.body);

    } else {

      return await false;
      
    }
  }



  Future<dynamic> registroConsultorio( String nombre, String correo, String telefono, String contrasena, String direccion, String tipo  ) async {

    final http.Response response = await http.post(
      Uri.parse('${this._baseUrl}/registro_consultorio'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'nombre': nombre,
        'correo': correo,
        'telefono': telefono,         
        'contrasena': contrasena,
        'direccion': direccion,
        'tipo': tipo
      })
    );
    
    if(response.statusCode == 200) {

      var jsonResponse = json.decode(response.body);
      Consultorio cs = Consultorio.fromJson(jsonResponse);
      this.consultorio = cs;
      return await json.decode(response.body);

    } else {

      return await false;
      
    }
  }



  
  Future<dynamic> loginUsuario( String tipoUsuario, String correo, String contrasena ) async {

    final http.Response response = await http.post(
      Uri.parse('${this._baseUrl}/login_usuario'),
      headers: <String, String> {
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{
        'tipoUsuario': tipoUsuario, 
        'correo': correo, 
        'contrasena': contrasena 
      })
    );    

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);

      switch (tipoUsuario) {
        case "paciente": {
          Paciente pc = Paciente.fromJson(jsonResponse);
          this.paciente = pc;
        }
        break;

        case "profesional": {
          Profesional pr = Profesional.fromJson(jsonResponse);
          this.profesional = pr;
        }
        break;

        case "consultorio": {
          Consultorio cs = Consultorio.fromJson(jsonResponse);
          this.consultorio = cs;
        }
        break;

        default: {
          print("Error");
        }
      }
    return await json.decode(response.body);
    } else {
      return await false;
    }
    
  }


}