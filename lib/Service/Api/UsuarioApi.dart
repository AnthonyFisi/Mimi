import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';

class UsuarioApi{

  //http.Client client;

  Future<UsuarioModel> fetchUsuariofindById(http.Client client,String idUsuario) async {

    final response = await client.get('https://backend-tienda-app.herokuapp.com/Usuario/mostrarUsuario/'+idUsuario);
    // Usa la función compute para ejecutar parsePhotos en un isolate separado

    if(response.statusCode==200){
      print('Bien');
    }else{
      print('No');
    }
    Map<String,dynamic> json=jsonDecode(response.body);
    var m=UsuarioModel.fromJson(json);
    return m;
  }



  Future<UsuarioModel> fetchUsuariofindByCorreo(http.Client client,String correo) async {

    final response = await client.get('https://backend-tienda-app.herokuapp.com/Usuario/mostrarUsuarioByCorreo/'+correo);
    // Usa la función compute para ejecutar parsePhotos en un isolate separado

    if(response.statusCode==200){
      print('Bien');
    }else{
      print('No');
    }
    Map<String,dynamic> json=jsonDecode(response.body);
    var m=UsuarioModel.fromJson(json);
    print('I am HERE perrasssssssssssssssssssssss');
   // print(m.Usuario_correo.toLowerCase()+'correooo');
    UsuarioModel.idUsuario=m.idusuario;
    print('el id de usuario es :'+UsuarioModel.idUsuario.toString());
    return m;
  }





  Future<bool> creatUsuarioModel(UsuarioModel usuarioModel) async {
    String url='https://backend-tienda-app.herokuapp.com/Usuario/registrarUsuarioFirebase';
    final response=await http.post(
      url,
      headers: {"content-type":"application/json"},
      body: usuarioToJson(usuarioModel),
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }


}