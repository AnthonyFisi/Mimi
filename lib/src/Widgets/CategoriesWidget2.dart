/*
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/CategoriesApi.dart';
import 'package:tienda_mimi/Service/Api/SubCategoriaApi.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/ListSubcategoriesProductsScreen.dart';
import 'package:http/http.dart' as http;

Widget SubCategoriesWidget2(){
  return Container(
    height:100.0,
    color: Colors.white,
    child: FutureBuilder<List<CategoriesModel>>(
      future: fetchCategoriesModel(http.Client()),
      builder: (context,snapshot){
        if(snapshot.data!=null){
          return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    print('touch meeeeeeeeeeeeeee');
                    print( (snapshot.data[index].idCategoria).toString());

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListCategoriesScreen(
                          categoriesModel: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                  child:  Padding(
                    padding:EdgeInsets.all(4.0),
                    child: Container(
                      width: 80.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          //color: Color.fromRGBO(255,255, 11, 0.05)
                        //color: Colors.lightGreenAccent
                      ),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 10.0,
                            child:Container(
                              width: 60.0,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
color: Colors.blue,
                                  image: DecorationImage(

                                  image: NetworkImage(snapshot.data[index].categoria_imagen,
                                  ),
                                    fit: BoxFit.cover
                                )
                              ),
                            ),
                          ),

                          Positioned(
                            top: 60,
                              child:  Padding(
                                padding: EdgeInsets.all(1.0),
                                //child: Text(snapshot.data[index].categoria_nombre,style: TextStyle(fontSize: 10.0,color: Colors.black),),
                              )
                          )

                        ],
                      )
                    /*
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:1.0),
                            child: Image.network(snapshot.data[index].categoria_imagen,
                              height: 100.0,
                              width: 80.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Text(snapshot.data[index].categoria_nombre,style: TextStyle(fontSize: 10.0,color: Colors.black38),),
                          )
                        ],
                      ),*/
                    ),
                  ),
                );
              }
          );

        }else {
          return Container(
            child: Center(
                child:CircularProgressIndicator(
                  backgroundColor: Colors.cyan,
                  strokeWidth: 5,)
            ),
          );
        }

      },
    ),
  );
}*/