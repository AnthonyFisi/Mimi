import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/TipoPago.dart';
import 'package:http/http.dart' as http;




Future<List<TipoPago>> fetchTipoPago(http.Client client) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/TipoPago/listaTipoPago');
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseTipoPago, response.body);

}


// Una función que convierte el body de la respuesta en un List<Photo>
List<TipoPago> parseTipoPago(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<TipoPago>((json) => TipoPago.fromJson(json)).toList();
}
