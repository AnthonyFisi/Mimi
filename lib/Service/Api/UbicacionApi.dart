import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';




Future<List<UbicacionModel>> fetchUbicacionModel(http.Client client,String idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/Ubicacion/listaUbicacion/'+idUsuario);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseUbicacionModel, response.body);

}





// Una función que convierte el body de la respuesta en un List<Photo>
List<UbicacionModel> parseUbicacionModel(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<UbicacionModel>((json) => UbicacionModel.fromJson(json)).toList();
}




Future<UbicacionModel> fetchfindByIdUbicacion(http.Client client,String idUbicacion) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/Ubicacion/findUbicacion/'+idUbicacion);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  if(response.statusCode==200){
    print('Bien');
  }else{
    print('No');
  }
  Map<String,dynamic> json=jsonDecode(response.body);
  var m=UbicacionModel.fromJson(json);

  return m;
}





Future<bool> creatUbicacionModel(UbicacionModel ubicacionModel) async {
  String url='https://backend-tienda-app.herokuapp.com/Ubicacion/registrarUbicacion';
  final response=await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: ubicacionToJson(ubicacionModel),
  );
  UsuarioModel.direccion=ubicacionModel.ubicacion_nombre;

  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}


Future<UbicacionModel> showUbicacionActual(http.Client client,String idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/Ubicacion/encontrarUbicacion/'+idUsuario);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  UbicacionModel ubicacion;
  if(response.statusCode==200){
    print('SI EXISTE DARA');
  Map<String,dynamic> json=jsonDecode(response.body);
  ubicacion=UbicacionModel.fromJson(json);
  UsuarioModel.direccion=ubicacion.ubicacion_nombre;
    return ubicacion;

  }else{
    return null;
  }
}


Future<bool> actualizarUbicacionModel(UbicacionModel ubicacionModel) async {
  String url='https://backend-tienda-app.herokuapp.com/Ubicacion/actualizarUbicacion';
  final response=await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: ubicacionToJson(ubicacionModel),
  );
  UsuarioModel.direccion=ubicacionModel.ubicacion_nombre;

  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}



Future<bool> eliminarUbicacionModel(int idUbicacionEliminar) async {
  String url='https://backend-tienda-app.herokuapp.com/Ubicacion/eliminarUbicacion/'+idUbicacionEliminar.toString();
  final response=await http.delete(
    url,
    headers: {"content-type":"application/json"},
  //  body: ubicacionToJson(ubicacionModel),
  );
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}

