import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:http/http.dart' as http;




Future<List<ProductoJOINCategoriaJOINImagenModel>> fetchProductoJOINCategoriaJOINImagen(http.Client client,String idCategoria) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/productoJOINImagen/lista/'+idCategoria);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseProductoJOINCategoriaJOINImagen, response.body);

}

Future<List<ProductoJOINCategoriaJOINImagenModel>> fetchProductoSubCategoria(http.Client client,String idSubCategoria) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/productoJOINImagen/listaSubCategoria/'+idSubCategoria);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseProductoJOINCategoriaJOINImagen, response.body);

}

Future<List<ProductoJOINCategoriaJOINImagenModel>> fetchBusquedaProducto(http.Client client,String palabraClave) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/productoJOINImagen/listaByTexto/'+palabraClave);
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  return compute(parseProductoJOINCategoriaJOINImagen, response.body);

}


Future<List<String>> fetchLista(http.Client client) async {
  final response = await client.get('https://backend-tienda-app.herokuapp.com/productoJOINImagen/lista');
  // Usa la función compute para ejecutar parsePhotos en un isolate separado
  List<String> list=new List<String>();
  List<ProductoJOINCategoriaJOINImagenModel> lista=   parseProductoJOINCategoriaJOINImagen(response.body);
/*
  for(int i=0;i<lista.length;i++){
    ProductoJOINCategoriaJOINImagenModel m=lista.toList().removeAt(i);
    list.add(m.Producto_nombre);
  }


  for(int i=0;i<lista.length;i++){
    ProductoJOINCategoriaJOINImagenModel m=lista.toList().removeAt(i);
    list.add(m.producto_marca);
  }


  for(int i=0;i<lista.length;i++){
    ProductoJOINCategoriaJOINImagenModel m=lista.toList().removeAt(i);
    list.add(m.Producto_nombre+" "+m.producto_marca);
  }*/


  for(int i=0;i<lista.length;i++){
    ProductoJOINCategoriaJOINImagenModel m=lista.toList().removeAt(i);
    list.add(m.Producto_nombre+" "+m.producto_marca+" "+m.producto_detalle);
  }

  return list;

}


// Una función que convierte el body de la respuesta en un List<Photo>
List<ProductoJOINCategoriaJOINImagenModel> parseProductoJOINCategoriaJOINImagen(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<ProductoJOINCategoriaJOINImagenModel>((json) => ProductoJOINCategoriaJOINImagenModel.fromJson(json)).toList();
}
