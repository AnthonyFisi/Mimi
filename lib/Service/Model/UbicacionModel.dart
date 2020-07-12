import 'dart:convert';

class UbicacionModel{


  final int idubicacion;
  final String ubicacion_nombre;
  final String ubicacion_comentarios;
  final int idusuario;
  final String ubicacion_estado;
  final bool eliminado;

  UbicacionModel({
    this.idubicacion,
    this.ubicacion_nombre,
    this.ubicacion_comentarios,
    this.idusuario,
    this.ubicacion_estado,
    this.eliminado
  });


  factory UbicacionModel.fromJson(Map<String,dynamic> json){

    return UbicacionModel(
      idubicacion: json['idubicacion'] as int,
      ubicacion_nombre: json['ubicacion_nombre'] as String,
      ubicacion_comentarios: json['ubicacion_comentarios'] as String,
      idusuario: json['idusuario'] as int,
      ubicacion_estado: json['ubicacion_estado'] as String,
      eliminado: json['eliminado'] as bool
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "idubicacion":idubicacion,
      "ubicacion_nombre":ubicacion_nombre,
      "ubicacion_comentarios":ubicacion_comentarios,
      "idusuario":idusuario,
      "ubicacion_estado":ubicacion_estado,
      "eliminado":eliminado
    };
  }
}


String ubicacionToJson(UbicacionModel ubicacion){
  final jsonData=ubicacion.toJson();
  print(jsonData);
  return json.encode(jsonData);
}