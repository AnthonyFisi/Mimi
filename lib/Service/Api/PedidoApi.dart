import 'dart:async';
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/PedidoModel.dart';
import 'package:http/http.dart' as http;


Future<PedidoModel> fetchPedidoModel(http.Client client, int idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/mostrarUsuario/'+(idUsuario).toString());
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
   return compute(parsePedido, response.body);
  //return parsePedido(response.body);

}

// Una función que convierte el body de la respuesta en un List<Photo>
PedidoModel parsePedido(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<PedidoModel>((json) => PedidoModel.fromJson(json));
}



Future<bool> createPedido(PedidoModel pedidoModel) async {

  String url='https://backend-tienda-app.herokuapp.com/Pedido/RegistrarProducto';

  final response=await http.post(
   url,
   headers: {"content-type":"application/json"},
   body: pedidoToJson(pedidoModel),
  );
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}




Future<bool> createPedidoAumentar(PedidoModel pedidoModel) async {

  String url='https://backend-tienda-app.herokuapp.com/RegistroPedido/incrementarCantidad';

  final response=await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: pedidoToJson(pedidoModel),
  );
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}



Future<bool> createPedidoDisminuir(PedidoModel pedidoModel) async {

  String url='https://backend-tienda-app.herokuapp.com/RegistroPedido/disminuirCantidad';

  final response=await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: pedidoToJson(pedidoModel),
  );
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}



Future<bool> createPedidoDetalle(PedidoModel pedidoModel) async {

  String url='https://backend-tienda-app.herokuapp.com/Pedido/RegistrarProductoDetalle';

  final response=await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: pedidoToJson(pedidoModel),
  );
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}



Future<bool> eliminarProducto(int idUsuario,int idProducto) async {

  String url='https://backend-tienda-app.herokuapp.com/RegistroPedido/eliminarRegistroPedido/'+(idUsuario).toString()+'/'+(idProducto).toString();

  final response=await http.delete(
    url,
    headers: {"content-type":"application/json"},
  );
  if(response.statusCode==200){
    return true;

  }else{
    return false;
  }
}