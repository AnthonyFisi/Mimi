import 'dart:async';
import 'dart:convert';

import 'package:tienda_mimi/Service/Model/CarritoModel.dart';
import 'package:http/http.dart' as http;


Future<List<CarritoModel>> fetchCarritoModel(http.Client client,String idUsuario) async {
  final response = await client.get('http://backend-tienda-app.herokuapp.com/Carrito/mostrarCarrito/'+idUsuario);
  return parseCarrito(response.body);
}


Future<List<CarritoModel>> fetchPedidoRealizado(http.Client client,String idPedido) async {
  final response = await client.get('http://backend-tienda-app.herokuapp.com/Carrito/mostrarPedidoRealizados/'+idPedido);
  return parseCarrito(response.body);
}

List<CarritoModel> parseCarrito(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<CarritoModel>((json) => CarritoModel.fromJson(json)).toList();
}



Future<bool> eliminarCarritoModel(int idCarrito) async {
  String url='https://backend-tienda-app.herokuapp.com/Carrito/eliminarCarrito/'+idCarrito.toString();
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


/*                  CLASE CARRITO */


class CarritoApi{

  Future<List<CarritoModel>> fetchCarritoModel(http.Client client,String idUsuario) async {
    final response = await client.get('http://backend-tienda-app.herokuapp.com/Carrito/mostrarCarrito/'+idUsuario);
    return parseCarrito(response.body);
  }


  Future<List<CarritoModel>> fetchPedidoRealizado(http.Client client,String idPedido) async {
    final response = await client.get('http://backend-tienda-app.herokuapp.com/Carrito/mostrarPedidoRealizados/'+idPedido);
    return parseCarrito(response.body);
  }

  List<CarritoModel> parseCarrito(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CarritoModel>((json) => CarritoModel.fromJson(json)).toList();
  }

}
