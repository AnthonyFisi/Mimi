import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';

class UsuarioModel extends BaseModel{

  static  int idUsuario=0;
 // static int cantidadTotal;
  static bool sesion=false;
  static String keepEmail="";
  static String direccion="";



  final int idusuario;
  final String Usuario_nombre;
  final String Usuario_correo;
  final String Usuario_contrasena;
  final String Usuario_apellido;
  final String Usuario_foto;
  final String Usuario_celular;

  UsuarioModel({
      this.idusuario,
      this.Usuario_nombre,
      this.Usuario_correo,
      this.Usuario_contrasena,
      this.Usuario_apellido,
      this.Usuario_foto,
      this.Usuario_celular
  });


  factory UsuarioModel.fromJson(Map<String,dynamic> json){
    return UsuarioModel(
      idusuario: json['idusuario'] as int,
      Usuario_apellido: json['usuario_apellido'] as String,
      Usuario_foto: json['usuario_foto'] as String,
      Usuario_celular: json['usuario_celular'] as String,
      Usuario_nombre:json['usuario_nombre'] as String,
      Usuario_correo: json['usuario_correo'] as String,
      Usuario_contrasena: json['usuario_contraseña'] as String,
    );
  }

  Map<String,dynamic> toJson(){
    return{
      "idusuario":idusuario,
      "usuario_nombre":Usuario_nombre,
      "usuario_correo":Usuario_correo,
      "usuario_contraseña":Usuario_contrasena,
      "usuario_apellido":Usuario_apellido,
      "usuario_foto":Usuario_foto,
      "usuario_celular":Usuario_celular
    };
  }

  static void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool userSession = prefs.getBool('sessionValue');

    if (userSession != null) {
      UsuarioModel.sesion = true;
    }
  }
  static void loadEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UsuarioModel.keepEmail = prefs.getString('email');
  }
}


String usuarioToJson(UsuarioModel usuarioModel){
  final jsonData=usuarioModel.toJson();
  print(jsonData);
  return json.encode(jsonData);
}


