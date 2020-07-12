import 'package:tienda_mimi/Service/Model/VentaModel.dart';
import 'package:http/http.dart' as http;

Future<bool> createVenta(VentaModel ventaModel,int idUsuario) async {

  String url='https://backend-tienda-app.herokuapp.com/Venta/guardarVenta/'+(idUsuario).toString();

  final response=await http.post(
    url,
    headers: {"content-type":"application/json"},
    body: ventaToJson(ventaModel),
  );
  if(response.statusCode==200){
    return true;
  }else{
    return false;
  }
}