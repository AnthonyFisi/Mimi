import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/FavoriteProductModel.dart';
import 'package:tienda_mimi/Service/Model/FavoriteProductMore.dart';

class FavoriteProductApi{


  Future<bool> createFavoriteProduct(FavoriteProductModel favoriteProductModel) async {

    String url='https://backend-tienda-app.herokuapp.com/favoriteProduct/registrarFavorite';

    final response=await http.post(
      url,
      headers: {"content-type":"application/json"},
      body: FavoriteProductToJson(favoriteProductModel),
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }

  Future<bool> updateFavoriteProduct(int idFavoriteProduct,bool activo) async {

    String url='https://backend-tienda-app.herokuapp.com/favoriteProduct/updateFavoriteProduct/'+idFavoriteProduct.toString()+'/'+activo.toString();

    final response=await http.post(
      url,
      headers: {"content-type":"application/json"},
    );
    if(response.statusCode==200){
      return true;
    }else{
      return false;
    }
  }


  Future<FavoriteProductModel> findByFavoriteProduct(http.Client client,int idUsuario,int idProducto)async{
print('fimreeeeeeeeeee');
    final response= await client.get('https://backend-tienda-app.herokuapp.com/favoriteProduct/findFavoriteByIds/'
        +idUsuario.toString()+'/'+
        idProducto.toString()
    );
    print('paso por acaaaaaaaaaa');
    if(response.statusCode==200){
      print(response.body);
      Map<String ,dynamic> json=jsonDecode(response.body);
      return FavoriteProductModel.fromJson(json);
    }else{
      print ('nothissssssssssssssss');
      return null;
    }
  }
  
  
  Future<List<FavoriteProductMoreModel>> listaFavoriteProduct(int idUsuario)async{
    final response= await http.get('http://backend-tienda-app.herokuapp.com/favoriteProductMore/mostrarFavoriteProduct/'+idUsuario.toString());
    print(response.body.toString());
    print(response.body.toString());
    return parseFavoriteProductMoreModel(response.body);
    return compute(parseFavoriteProductMoreModel, response.body);
    
  }


// Una función que convierte el body de la respuesta en un List<Photo>
  List<FavoriteProductMoreModel> parseFavoriteProductMoreModel(String responseBody) {
    print('acc');
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    print('acc');
    return parsed.map<FavoriteProductMoreModel>((json) =>FavoriteProductMoreModel.fromJson(json)).toList();
  }


}