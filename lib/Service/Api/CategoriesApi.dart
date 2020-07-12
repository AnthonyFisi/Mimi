import 'dart:async';
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:http/http.dart' as http;


Future<List<CategoriesModel>> fetchCategoriesModel(http.Client client) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/categoria/lista');
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
 // return compute(parseCategoria, response.body);
  return parseCategoria(response.body);

}

// Una función que convierte el body de la respuesta en un List<Photo>
List<CategoriesModel> parseCategoria(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<CategoriesModel>((json) => CategoriesModel.fromJson(json)).toList();
}
