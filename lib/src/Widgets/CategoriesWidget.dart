

import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/CategoriesApi.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';

Widget  CategoriesGridViewWidget(){

  return
    FutureBuilder<List<CategoriesModel>>(
      future: fetchCategoriesModel(http.Client()),
      builder: (context,snapshot){
        if(snapshot.data != null){
          return   SliverGrid(
            gridDelegate:
            new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 80.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 0.7,
            ),
            ///Lazy building of list
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){



                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListCategoriesScreen(
                          categoriesModel: snapshot.data[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    // color: Colors.orangeAccent,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top:1.0),
                          child:Image.network(
                            snapshot.data[index].categoria_descripcion,
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:10.0,top:10.0),
                          child:Text(snapshot.data[index].categoria_nombre,style: TextStyle(fontSize: 11.0),),
                        ),

                      ],
                    ),
                  ),
                );
              },
              /// Set childCount to limit no.of items
              childCount: snapshot.data.length,
            ),
          );
        }else{

          return SliverGrid(
            gridDelegate:
            new SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 80.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 2.0,
            ),
            ///Lazy building of list
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(
                  color: Colors.black12
                );
              },
              /// Set childCount to limit no.of items
              childCount: 10,
            ),
          );

        }


      },
    );


}
