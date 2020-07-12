class SubCategoriaModel{


  final int idsubcategoria;
  final int idcategoria;
  final String nombresubcategoria;
  final String urisubcategoria;
  final String detalle;

  SubCategoriaModel({
      this.idsubcategoria,
      this.idcategoria,
      this.nombresubcategoria,
      this.urisubcategoria,
      this.detalle
  });


  factory SubCategoriaModel.fromJson(Map<String, dynamic> json){
    return SubCategoriaModel(
    idsubcategoria: json['idsubcategoria'] as int,
      idcategoria: json['idcategoria'] as int,
      nombresubcategoria: json['nombresubcategoria'] as String,
      urisubcategoria: json['urisubcategoria'] as String,
      detalle: json['detalle'] as String,
    );
  }



}