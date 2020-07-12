import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Api/UsuarioApi.dart';

import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
class Repository{

  Future<PedidoRealModel> fetchPedidoRealModelStream(http.Client client,String idUsuario) => fetchPedidoReal(client, idUsuario);

}


class RepositoryUsuario{

  UsuarioApi usuarioApi= new UsuarioApi();

  Future<UsuarioModel> fetchUsuarioModelStream(http.Client client,String correo) => usuarioApi.fetchUsuariofindByCorreo(client, correo);

}