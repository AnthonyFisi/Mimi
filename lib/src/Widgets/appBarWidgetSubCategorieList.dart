import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:tienda_mimi/src/Screen/SearchScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:http/http.dart' as http;

Widget appSliverBarWidgetSubCategorieList(context,String nombre) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Icon(
        Icons.arrow_back_ios,
        color: Colors.black54,
      ),
    ),
    title: Text(nombre,style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold),),

    actions: <Widget>[

      Container(
        width: MediaQuery.of(context).size.width*0.2,

        child: Stack(
          children: <Widget>[


            Positioned(
                top:20.0,
                right: 15.0,
                //left: 20.0,
                child:GestureDetector(
                    onTap: (){

                      Navigator.of(context).pushReplacementNamed('/ShoppingCartScreen',arguments: UsuarioModel.idUsuario);
                    },
                    child:  Padding(
                      padding: const EdgeInsets.only(right:20.0),
                      child: Container(
                        child: Icon(Icons.shopping_cart,color:Colors.black54,size: 25.0,),
                      ),
                    )
                )
            ),
            Positioned(
              top:5.0,
              left: 25,
              child:  Container(
                  height: 20.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius:
                      BorderRadius.circular(
                          40.0)),
                  child: Center(
                    child:_cantidadTotal(),
                  )),
            )

          ],
        ),
      )

    ],
  );
}


Widget _cantidadTotal(){

  if(cantTotal>0){

    return Text(
      '+' +
          (cantTotal).toString(),
      style: TextStyle(
          color: Colors.white,
          fontWeight:
          FontWeight.bold),
    );
  }else{
    return Text('',style: TextStyle(fontSize: 30.0));
  }


}
