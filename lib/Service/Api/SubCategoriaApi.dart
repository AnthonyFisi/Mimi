import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:http/http.dart' as http;




Future<List<SubCategoriaModel>> fetchSubCategoriaModel(http.Client client,int idCategoria) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/SubCategoria/listaSubCategoria/'+(idCategoria).toString());
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseSubCategoriaModel, response.body);

}


// Una función que convierte el body de la respuesta en un List<Photo>
List<SubCategoriaModel> parseSubCategoriaModel(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<SubCategoriaModel>((json) => SubCategoriaModel.fromJson(json)).toList();
}
