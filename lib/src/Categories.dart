import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/CategoriesApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';

import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';

/*

class Categories extends StatefulWidget {

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with WidgetsBindingObserver {

  static  int incremento;




  Future<PedidoRealModel> _PedidoFuture;


  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 5000), (timer) {
      setState(() {
        _PedidoFuture = fetchPedidoReal(http.Client(),(UsuarioModel.idUsuario).toString());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpTimedFetch();
    //_PedidoFuture = fetchPedidoReal(http.Client(),(UsuarioModel.idUsuario).toString());
    // _PedidoFuture.asStream().

  }


  @override
  Widget build(BuildContext context) {
        return
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartScreen(
                      idUsuario: UsuarioModel.idUsuario,
                    ),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0),
              child: Container(
                  height: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),topRight: Radius.circular(10.0)),
                    // color: Color.fromRGBO(217, 4, 82, 1),
                    color:GREENCART,
                  ),
                  child:Row(
                    children: <Widget>[
                      FutureBuilder<PedidoRealModel>(
                          future: _PedidoFuture,
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {



                              if(snapshot.data.pedido_estado !='Atendido'){
                             //   UsuarioModel.cantidadTotal=snapshot.data.pedido_cantidadtotal;
                                return Container(
                                  width: 150,
                                  //color: Colors.black12,
                                  child: Column(
                                    children: <Widget>[

                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text((UsuarioModel.cantidadTotal).toString()+ ' PRODUCTOS'
                                          ,style: TextStyle(color: Colors.white,fontSize: 12.0),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text('S/.'+(snapshot.data.pedido_montototal).toString() + ' soles ' ,style: TextStyle(color: Colors.white,fontSize: 15.0),),
                                      ),
                                      Text((incremento).toString())

                                    ],
                                  ),
                                );
                              }else{
                                return Container(
                                  width: 150,
                                  //color: Colors.black12,
                                  child: Column(
                                    children: <Widget>[

                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(' 0  PRODUCTOS'
                                          ,style: TextStyle(color: Colors.white,fontSize: 12.0),),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(1.0),
                                        child: Text('S/. 0  soles ' ,style: TextStyle(color: Colors.white,fontSize: 15.0),),
                                      )

                                    ],
                                  ),
                                );

                              }

                            } else {
                              return Container(
                                width: 150,
                                // color: Colors.black12,
                                child: Column(
                                  children: <Widget>[

                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text((0).toString()+ '  productos'
                                          ,style: TextStyle(color: Colors.white)
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text('S/.'+(0).toString() + ' soles '
                                          ,style: TextStyle(color: Colors.white)
                                      ),
                                    )

                                  ],
                                ),
                              );
                            }
                          }
                      ),

                      Container(
                        width: 180.0,
                        height: 50.0,
                        //color: Colors.lightGreenAccent,
                        child: Row(
                          children: <Widget>[
                            /* Padding(
                      padding: EdgeInsets.only(left: 1.0),
                    child: Icon(Icons.shopping_cart,color: Colors.white,size: 20.0,),
                  ),*/
                            Padding(
                              padding: EdgeInsets.only(left:1.0),
                              child: Text('Comprar ahora',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 1.0),
                              child: Icon(Icons.play_arrow,color: Colors.white,size: 20.0,),
                            )

                          ],
                        ),
                      )

                    ],
                  )
              ),
            ),
          );

         /* FutureBuilder<List<CategoriesModel>>(
            future: fetchCategoriesModel(http.Client()),
            builder: (context,snapshot){
              if(snapshot.data != null){
                return   SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  ///Lazy building of list
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return Container(
                         color: Colors.lightGreenAccent,
                        margin: EdgeInsets.all(10.0),
                        height: 20.0,
                        width: 30.0,
                        child:
                        GestureDetector(
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
                          child: Column(
                            children: <Widget>[
                              Image.network(snapshot.data[index].categoria_imagen,
                                height: 30.0,
                                width: 30.0,
                                fit: BoxFit.cover,
                              ),
                            //  Center(child: Text(snapshot.data[index].categoria_nombre,style: TextStyle(fontSize: 11.5,fontWeight:FontWeight.bold),)),
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

                return SliverToBoxAdapter(
                  child: Center(
                    child:CircularProgressIndicator(
                    backgroundColor: Colors.cyan,
                    strokeWidth: 5,)
                  ),
                );
              }


            },
          );*/

          /*Column(
          children: <Widget>[
              Container(
                height: 270.0,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular(1.0)), // set rounded corner radius
            ),
                child: FutureBuilder<List<CategoriesModel>>(
                  future: fetchCategoriesModel(http.Client()),
                  builder: ( context,  snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                          itemCount: snapshot.data.length,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                             // color: Colors.lightGreenAccent,
                              margin: EdgeInsets.all(10.0),
                              height: 30.0,
                              width: 30.0,
                              child:
                             GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ListaProductosByCategoria(
                                        idCategoria: snapshot.data[index].idCategoria,
                                        categoria_nombre: snapshot.data[index].categoria_nombre,
                                        categoria_uri_post: snapshot.data[index].categoria_uri_post,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Image.network(snapshot.data[index].categoria_imagen,
                                      height: 30.0,
                                      width: 30.0,
                                      fit: BoxFit.cover,
                                    ),
                                    Center(child: Text(snapshot.data[index].categoria_nombre,style: TextStyle(fontSize: 11.5,fontWeight:FontWeight.bold),)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: Text("Loading"),
                        ),
                      );
                    }
                  },
                ),
              ),
          ],
        );
*/

  }
}
*/
