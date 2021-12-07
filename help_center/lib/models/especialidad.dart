import 'dart:convert';

class Especialidad {

  Especialidad({
    required this.id_especialidad,
    required this.nombre,
  });

  int id_especialidad;
  String nombre;

  factory Especialidad.fromJson(dynamic json) {
    return Especialidad(
      id_especialidad: json["id_especialidad"], 
      nombre: json["nombre"], 
    );    
  }

  @override
  String toString() {
    return '${this.nombre}';
  }

}
