import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class FavoriteProductModel{

  final int idFavorite;
  final int idUsuario;
  final int idProducto;
  final bool activo;
  final Timestamp fecha;

  FavoriteProductModel({this.idFavorite, this.idUsuario, this.idProducto,
      this.activo, this.fecha});


  Map<String,dynamic> toJson(){
    return {
      "idFavorite":idFavorite,
      "idUsuario":idUsuario,
      "idProducto":idProducto,
      "activo":activo,
      "fecha":fecha

    };
  }

  factory FavoriteProductModel.fromJson(Map<String,dynamic> json){
    return FavoriteProductModel(
      idFavorite:json['idFavorite'] as int,
      idUsuario:json['idUsuario'] as int,
      idProducto:json['idProducto'] as int,
      activo:json['activo'] as bool,
      fecha:json['fecha'] as Timestamp
    );
  }

}


String FavoriteProductToJson(FavoriteProductModel favoriteProductModel){
  final jsonData=favoriteProductModel.toJson();
  print(jsonData);
  return json.encode(jsonData);
}