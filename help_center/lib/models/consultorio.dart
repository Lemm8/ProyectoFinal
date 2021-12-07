class Consultorio {

  Consultorio({
    required this.id_consultorio,
    required this.nombre,
    required this.correo,
    required this.telefono,
    required this.contrasena,
    required this.direccion,
    required this.tipo
  });

  int id_consultorio;
  String nombre;
  String correo;
  String telefono;
  String contrasena;
  String direccion;
  String tipo;

  factory Consultorio.fromJson(dynamic json) {
    return Consultorio(
      id_consultorio: json["id_consultorio"], 
      nombre: json["nombre"], 
      correo: json["correo"], 
      telefono: json["telefono"], 
      contrasena: json["contrasena"], 
      direccion: json["direccion"], 
      tipo: json["tipo"]
    );    
  }

  @override
  String toString() {
    return '{ ${this.nombre}, ${this.correo}, ${this.telefono}, ${this.direccion} }';
  }

}
