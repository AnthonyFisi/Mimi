
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/SubCategoriaApi.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ListSubcategoriesProductsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';

Widget SubCategoriesWidget(int idCategoria){
  return Container(

      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
    child: FutureBuilder<List<SubCategoriaModel>>(
      future: fetchSubCategoriaModel(http.Client(),idCategoria),
      builder: (context,snapshot){
        if(snapshot.data!=null){
          return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: (){

                      //channel.unbind(eventController.text);

                      Navigator.push(context,MaterialPageRoute(
                          builder: (context)=> ListSubCategoriesProductsScreen(
                            subCategoriaModel: snapshot.data[index],
                          )
                      ));

                    },
                    child:  Padding(
                      padding:EdgeInsets.all(1.0),
                      child: Container(
                        width: 60.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            //color: Color.fromRGBO(255,255, 11, 1)
                        ),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Image.network(snapshot.data[index].urisubcategoria,
                                height: 30.0,
                                width: 30.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(1.0),
                              child: Text(snapshot.data[index].nombresubcategoria,style: TextStyle(fontSize: 10.0,color: Colors.black38),),
                            )
                          ],
                        ),
                      ),
                    ),
                );
              }
          );

        }else {
          return  ListView.builder(
              itemCount:10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.all(5.0),
                  child: Skeleton(type: 'boxListSubcategoriesIcon',),
                );
              }
              );
        }

      },
    ),
  );
}