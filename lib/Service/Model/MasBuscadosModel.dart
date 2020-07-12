class MasBuscadosModel{



  final int idProducto;
  final int idCategoria;
  final int idImagenesProducto;
  final String producto_marca;
  final String producto_envase;
  final String producto_detalle;
  final String producto_cantidad;
  final double porcentaje;
  final String Producto_nombre;
  final double Producto_precio;
  final String Categoria_nombre;
  final String Categoria_descripcion;
  final String ImagenesProducto_nombre;
  final String ImagenesProducto_uri;


  MasBuscadosModel({
    this.idProducto,
    this.idCategoria,
    this.idImagenesProducto,
    this.producto_marca,
    this.producto_envase,
    this.producto_detalle,
    this.producto_cantidad,
    this.porcentaje,
    this.Producto_nombre,
    this.Producto_precio,
    this.Categoria_nombre,
    this.Categoria_descripcion,
    this.ImagenesProducto_nombre,
    this.ImagenesProducto_uri,
  });

  factory MasBuscadosModel.fromJson(Map<String, dynamic> json){
    return MasBuscadosModel(
      idProducto: json['idProducto'] as int,
      idCategoria: json['idCategoria'] as int,
      idImagenesProducto: json['idImagenesProducto'] as int,
      producto_marca: json['producto_marca'] as String,
      producto_envase: json['producto_envase'] as String,
      producto_detalle: json['producto_detalle'] as String,
      producto_cantidad: json['producto_cantidad'] as String,
      porcentaje: json['porcentaje'] as double,
      Producto_nombre: json['producto_nombre'] as String,
      Producto_precio: json['producto_precio'] as double,
      Categoria_nombre: json['categoria_nombre'] as String,
      Categoria_descripcion: json['categoria_descripcion'] as String,
      ImagenesProducto_nombre: json['imagenesProducto_nombre'] as String,
      ImagenesProducto_uri: json['imagenesProducto_uri'] as String,


    );
  }
}