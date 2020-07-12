
import 'package:tienda_mimi/Service/Bloc/base.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';


class PedidoRealBloc extends BaseBloc<PedidoRealModel>{

  Stream<PedidoRealModel> get todo =>  fetcher.stream;
      //Stream<PedidoRealModel>.periodic(Duration(seconds: 5),fetcher.stream);
      /*(
      fetcher.stream
  );*/

  // Stream.periodic(Duration(seconds: 5));

  fetchTodo(http.Client client,String idUsuario) async {

    PedidoRealModel  itemPedido= await repository.fetchPedidoRealModelStream(client, idUsuario);
    fetcher.sink.add(itemPedido);
  }

}

final rxPedidoReal = PedidoRealBloc();


class UsuarioRealBloc extends BaseBloc<UsuarioModel>{

  Stream<UsuarioModel> get todo =>  fetcher.stream;
  //Stream<PedidoRealModel>.periodic(Duration(seconds: 5),fetcher.stream);
  /*(
      fetcher.stream
  );*/

  // Stream.periodic(Duration(seconds: 5));

  fetchTodo(http.Client client,String correo) async {

    UsuarioModel  usuario= await repositoryUsuario.fetchUsuarioModelStream(client, correo);
    fetcher.sink.add(usuario);
  }

}

final rxUsuario = UsuarioRealBloc();
