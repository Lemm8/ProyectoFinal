class Paciente {

  Paciente({
    required this.id_paciente,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.contrasena
  });

  int id_paciente;
  String nombre;
  String apellidos;
  String correo;
  String contrasena;

  factory Paciente.fromJson(dynamic json) {
    return Paciente(
      id_paciente: json["id_paciente"], 
      nombre: json["nombre"],       
      apellidos: json["apellidos"], 
      correo: json["correo"], 
      contrasena: json["contrasena"]
    );    
  }

  @override
  String toString() {
    return '${this.nombre}';
  }

}

