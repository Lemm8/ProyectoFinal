import 'dart:ffi';

class Resena {

  Resena({
    required this.id_resena,
    required this.paciente,
    required this.calificacion,
    required this.comentario
  });

  int id_resena;
  String paciente;
  double calificacion;
  String comentario;

  factory Resena.fromJson(dynamic json) {
    return Resena(
      id_resena: json["id_resena"], 
      paciente: json["paciente"],       
      calificacion: json["calificacion"].toDouble(), 
      comentario: json["comentario"], 
    );    
  }

  @override
  String toString() {
    return '${this.calificacion}';
  }

}

