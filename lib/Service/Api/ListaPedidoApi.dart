import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/ListaPedidoModel.dart';
import 'package:http/http.dart' as http;



Future<List<ListaPedidoModel>> fetchListaPedidoModel(http.Client client,String idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/ListaPedido/listaDeOrdenes/1');
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  print(response.body.toString());

  return compute(parseListaPedidoModel, response.body);
}



Future<List<ListaPedidoModel>> fetchListaPedidoModelHoy(http.Client client,String idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/ListaPedido/listaDeOrdenesHoy/'+idUsuario);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  print(response.body.toString());

  return compute(parseListaPedidoModel, response.body);

}


Future<List<ListaPedidoModel>> fetchListaPedidoModelPendiente(http.Client client,String idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/ListaPedido/listaDeOrdenesPendiente/'+idUsuario);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  print(response.body.toString());

  return compute(parseListaPedidoModel, response.body);

}


Future<List<ListaPedidoModel>> fetchListaPedidoModelHistorial(http.Client client,String idUsuario) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/ListaPedido/listaDeOrdenesHistorial/'+idUsuario);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  print(response.body.toString());

  return compute(parseListaPedidoModel, response.body);

}

// Una función que convierte el body de la respuesta en un List<Photo>
List<ListaPedidoModel> parseListaPedidoModel(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ListaPedidoModel>((json) => ListaPedidoModel.fromJson(json)).toList();
}
