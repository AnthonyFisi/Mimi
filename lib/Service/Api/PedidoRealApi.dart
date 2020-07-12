import 'dart:async';
import 'dart:convert';

import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:http/http.dart' as http;




Future<PedidoRealModel> fetchPedidoReal(http.Client client,String idUsuario) async {
  final response = await client.get('http://backend-tienda-app.herokuapp.com/Pedido/mostrarMontoTotal2/'+idUsuario);
  if(response.statusCode==200){
    Map<String,dynamic> json=jsonDecode(response.body);
    var m=PedidoRealModel.fromJson(json);
    return m;
  }else{
    print('No');
  }

}

