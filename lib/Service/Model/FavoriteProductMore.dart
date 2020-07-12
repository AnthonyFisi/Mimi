class FavoriteProductMoreModel{


  int idProducto;
  String producto_nombre;
  String producto_marca;
  String producto_envase;
  String producto_detalle;
  String producto_cantidad;
  String producto_uri_imagen;
  double producto_precio;

  FavoriteProductMoreModel({
    this.idProducto,
    this.producto_nombre,this.producto_marca,this.producto_envase,this.producto_cantidad,
    this.producto_detalle,  this.producto_uri_imagen,this.producto_precio,

  });

  factory FavoriteProductMoreModel.fromJson(Map<String, dynamic> json) {
    return FavoriteProductMoreModel(
      idProducto: json['idProducto'] as int,
      producto_nombre : json['producto_nombre']  as String ,
      producto_marca: json['producto_marca'] as String,
      producto_envase: json['producto_envase'] as String,
      producto_detalle: json['producto_detalle'] as String,
      producto_cantidad: json['producto_cantidad'] as String,
      producto_uri_imagen : json['producto_uri_imagen']  as  String,
      producto_precio: json['producto_precio'] as double,
    );
  }


}