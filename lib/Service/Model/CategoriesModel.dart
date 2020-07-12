class CategoriesModel {
  final int idCategoria;
  final String categoria_nombre;
  final String categoria_descripcion;
  final String categoria_imagen;
  final String categoria_uri_post;

  CategoriesModel({
    this.idCategoria,
    this.categoria_nombre,
    this.categoria_descripcion,
    this.categoria_imagen,
    this.categoria_uri_post
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      idCategoria: json['idCategoria'] as int,
      categoria_nombre: json['categoria_nombre'] as String,
      categoria_descripcion: json['categoria_descripcion'] as String,
      categoria_imagen: json['categoria_imagen'] as String,
      categoria_uri_post: json['categoria_uri_post'] as String
    );
  }
}