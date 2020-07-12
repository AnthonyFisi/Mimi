import 'dart:async';
import 'dart:convert';


import 'package:tienda_mimi/Service/Model/RegistroPedidoModel.dart';
import 'package:http/http.dart' as http;


Future<RegistroPedidoModel> fetchRegistroPedido(http.Client client,String idUsuario,String idProducto) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/RegistroPedido/mostrarProductoExistente/'+idUsuario+'/'+idProducto);
  if(response.statusCode==200){
    Map<String,dynamic> json=jsonDecode(response.body);
    var m=RegistroPedidoModel.fromJson(json);

    return m;

  }else{
return null;
  }

}