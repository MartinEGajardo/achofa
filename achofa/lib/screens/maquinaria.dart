class Maquinaria {
  final int id;
  final String nombre;
  final String descripcion;

  Maquinaria({required this.id, required this.nombre, required this.descripcion});

  factory Maquinaria.fromJson(Map<String, dynamic> json) {
    return Maquinaria(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }
}
