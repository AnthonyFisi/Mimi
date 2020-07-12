import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/HorarioModel.dart';
import 'package:http/http.dart' as http;



Future<List<HorarioModel>> fetchHorarioModel(http.Client client) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/Horario/lista');
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  print(response.body.toString());

  return compute(parseHorarioModel, response.body);

}

// Una función que convierte el body de la respuesta en un List<Photo>
List<HorarioModel> parseHorarioModel(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<HorarioModel>((json) => HorarioModel.fromJson(json)).toList();
}
