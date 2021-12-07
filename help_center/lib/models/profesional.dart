class Profesional {

  Profesional({
    required this.id_profesional,
    required this.nombre,
    required this.apellidos,
    required this.correo,
    required this.contrasena
  });

  int id_profesional;
  String nombre;
  String apellidos;
  String correo;
  String contrasena;

  factory Profesional.fromJson(dynamic json) {
    return Profesional(
      id_profesional: json["id_profesional"], 
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

