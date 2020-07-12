import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/MasBuscadosModel.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:http/http.dart' as http;




Future<List<MasBuscadosModel>> fetchMasBuscadosModel(http.Client client,String idCategoria) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/MasBuscados/lista/'+idCategoria);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseProductoJOINCategoriaJOINImagen, response.body);

}

// Una función que convierte el body de la respuesta en un List<Photo>
List<MasBuscadosModel> parseProductoJOINCategoriaJOINImagen(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<MasBuscadosModel>((json) => MasBuscadosModel.fromJson(json)).toList();
}
