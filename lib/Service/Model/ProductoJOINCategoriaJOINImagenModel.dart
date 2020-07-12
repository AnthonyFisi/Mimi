class ProductoJOINCategoriaJOINImagenModel{


  final int idProducto;
  final int idCategoria;
  final String producto_uri_imagen;
  final String producto_marca;
  final String producto_envase;
  final String producto_detalle;
  final String producto_cantidad;
  final String nombresubcategoria;
  final int idsubcategoria;
  final String detalle;
  final String Categoria_nombre;
  final String Categoria_descripcion;
  final String Producto_nombre;
  final double Producto_precio;





  ProductoJOINCategoriaJOINImagenModel({
        this.idProducto,
        this.idCategoria,
        this.producto_uri_imagen,
        this.producto_marca,
        this.producto_envase,
        this.producto_detalle,
        this.producto_cantidad,
        this.nombresubcategoria,
        this.idsubcategoria,
        this.detalle,
        this.Categoria_nombre,
        this.Categoria_descripcion,
        this.Producto_nombre,
        this.Producto_precio,

    });

    factory ProductoJOINCategoriaJOINImagenModel.fromJson(Map<String, dynamic> json){
      return ProductoJOINCategoriaJOINImagenModel(
        idProducto: json['idProducto'] as int,
        idCategoria: json['idCategoria'] as int,
        producto_uri_imagen: json['producto_uri_imagen'] as String,
        producto_marca: json['producto_marca'] as String,
        producto_envase: json['producto_envase'] as String,
        producto_detalle: json['producto_detalle'] as String,
        producto_cantidad: json['producto_cantidad'] as String,
        nombresubcategoria: json['nombresubcategoria'] as String,
        idsubcategoria:json['idsubcategoria'] as int ,
        detalle: json['detalle'] as String,
        Categoria_nombre: json['categoria_nombre'] as String,
        Categoria_descripcion: json['categoria_descripcion'] as String,
        Producto_nombre: json['producto_nombre'] as String,
        Producto_precio: json['producto_precio'] as double,
      );
    }



}
