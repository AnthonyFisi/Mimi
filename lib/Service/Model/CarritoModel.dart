class CarritoModel{

   int idProducto;
   String producto_nombre;
   String producto_marca;
   String producto_envase;
   String producto_detalle;
  String producto_cantidad;
   int registropedido_cantidad;
   double registropedido_preciototal;
   String producto_uri_imagen;
   double Producto_precio;

 static List<CarritoModel> carritoModel= new List<CarritoModel>();



  CarritoModel({
    this.idProducto,
    this.producto_nombre,this.producto_marca,this.producto_envase,this.producto_cantidad,
    this.producto_detalle, this.registropedido_cantidad,
      this.registropedido_preciototal, this.producto_uri_imagen,this.Producto_precio,

  });

  factory CarritoModel.fromJson(Map<String, dynamic> json) {
    return CarritoModel(
      idProducto: json['idProducto'] as int,
      producto_nombre : json['producto_nombre']  as String ,
      producto_marca: json['producto_marca'] as String,
      producto_envase: json['producto_envase'] as String,
      producto_detalle: json['producto_detalle'] as String,
      producto_cantidad: json['producto_cantidad'] as String,
      registropedido_cantidad : json['registropedido_cantidad']  as  int,
      registropedido_preciototal : json['registropedido_preciototal']  as double ,
      producto_uri_imagen : json['producto_uri_imagen']  as  String,
      Producto_precio: json['producto_precio'] as double,
    );
  }

}