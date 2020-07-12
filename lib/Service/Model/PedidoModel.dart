import 'dart:convert';

class PedidoModel{

  final int idProducto;
  final int cantidad ;
  final double precio;
  final int idUsuario;


  PedidoModel({
    this.idProducto,
    this.cantidad,
    this.precio,
    this.idUsuario
  });


  factory PedidoModel.fromJson(Map<String, dynamic> json){

    return PedidoModel(
      idProducto:json['idProducto'] as int ,
       cantidad:json['cantidad'] as int ,
      precio:json['precio'] as double,
      idUsuario: json['idUsuario'] as int
    );
  }


  Map<String,dynamic> toJson(){
    return{
      "idProducto":idProducto,
      "cantidad":cantidad,
      "precio":precio,
      "idUsuario":idUsuario
    };
  }



}

String pedidoToJson(PedidoModel pedido){
  final jsonData=pedido.toJson();
  return json.encode(jsonData);
}