import 'dart:convert';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/PedidoApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:tienda_mimi/Service/Api/RegistroPedidoApi.dart';
import 'package:tienda_mimi/Service/Model/PedidoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:tienda_mimi/Service/Model/RegistroPedidoModel.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Boton.dart';
import 'package:tienda_mimi/src/ButtonAnimationWidget.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/CartBottomNavigatorWidget.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';
import 'package:tienda_mimi/src/Widgets/appBarWidgetSubCategorieList.dart';
import 'package:tienda_mimi/src/Widgets/canasta.dart';

import 'DetailProductScreen.dart';


int cantidadTotal=cantTotal;

class ListSubCategoriesProductsScreen extends StatefulWidget {

  final SubCategoriaModel subCategoriaModel;

  const ListSubCategoriesProductsScreen({Key key,@required this.subCategoriaModel}) : super(key: key);



  @override
  _ListSubCategoriesProductsScreenState createState() => _ListSubCategoriesProductsScreenState(subCategoriaModel);
}

class _ListSubCategoriesProductsScreenState extends State<ListSubCategoriesProductsScreen> {
  final SubCategoriaModel subCategoriaModel;
  _ListSubCategoriesProductsScreenState(this.subCategoriaModel);
  AudioCache _audioCache;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // bindPusher();
    _audioCache = AudioCache(prefix: "audio/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));


  }


  void bindPusher(){
    channel.bind(eventController.text, (x) {
      if (mounted)
        setState(() {
          lastEvent = x;
          Message mes=Message.fromJson(jsonDecode(lastEvent.data));
          amountProduct=mes.message;
        });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

     // appBar: appSliverBarWidgetSubCategorieList(context,subCategoriaModel.nombresubcategoria),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        title: Container(
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width*0.6,
          child: Text(subCategoriaModel.nombresubcategoria,style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold),),
        ),

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
                       // child:_cantidadTotal(),
                        child:  Text(
                          '+' +
                              (amountProduct).toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                              FontWeight.bold),
                        )
                      )),
                )

              ],
            ),
          )

        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*0.79,
              child: ListView(

                children: <Widget>[
                  FutureBuilder<List<ProductoJOINCategoriaJOINImagenModel>>(
                    future: fetchProductoSubCategoria(http.Client(),(subCategoriaModel.idsubcategoria).toString()),
                    builder: (context,snapshot){
                      if(snapshot.data!=null){
                        return Container(
                        //  color: Colors.blue,
                          child: GridView.count(
                              primary: false,
                              crossAxisCount: 2,
                              crossAxisSpacing: 2,
                              controller: new ScrollController(keepScrollOffset: false),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              childAspectRatio: 0.6,
                              children:List.generate(snapshot.data.length, (index){
                                return new Container(
                                    margin: EdgeInsets.all(5.0),
                                    color: Colors.white,
                                    width: 210.0,
                                    child: Stack(
                                      children: <Widget>[


                                        Positioned(
                                          left: 30.0,
                                          top:50.0,
                                          child: GestureDetector(
                                            onTap:(){
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => DetailProductScreen(
                                                      productoJOINCategoriaJOINImagenModel:snapshot.data[index]
                                                  ),
                                                ),
                                              );
                                            },

                                            child: Image.network(snapshot.data[index].producto_uri_imagen,
                                              height: 100.0,
                                              width: 100.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),


                                        Positioned(

                                          right: 10.0,
                                          top: 210,
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  print('');
                                                });
                                              },
                                              child:FutureBuilder<RegistroPedidoModel>(
                                                  future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(snapshot.data[index].idProducto).toString()),
                                                  builder:(context,snapshot2){
                                                    if(snapshot2.data != null){
                                                      return
                                                        ButtonAnimationWidget2(
                                                          idProducto: snapshot
                                                              .data[index].idProducto,
                                                          cantidadAnimation: snapshot2.data.registropedido_cantidad,
                                                          precio: (snapshot
                                                              .data[index]
                                                              .Producto_precio)
                                                              .toDouble(),
                                                          idUsuario: UsuarioModel.idUsuario,
                                                          changeSize: false,
                                                        );

                                                      /*
                                                                      Padding(padding: const EdgeInsets.only(top:150.0,right: 10.0),
                                                                        child: Card(
                                                                          color: Colors.white,
                                                                          child: Container(
                                                                            //color: Colors.deepPurpleAccent,
                                                                            child: Row(
                                                                              children: <Widget>[
                                                                                Padding(
                                                                                    padding: const EdgeInsets.only(right: 15.0),
                                                                                    child: IconButton(
                                                                                      icon: Icon(Icons.remove ,size: 30.0,color: Colors.green,),
                                                                                      onPressed:()async {
                                                                                        if(snapshot2.data.registropedido_cantidad > 1){
                                                                                          PedidoModel pedido= new PedidoModel(
                                                                                            idProducto: snapshot.data[index].idProducto,
                                                                                            cantidad: 1,
                                                                                            precio: (snapshot.data[index].Producto_precio).toDouble(),
                                                                                            idUsuario: UsuarioModel.idUsuario,
                                                                                          );

                                                                                          bool rpta= await createPedidoDisminuir(pedido);
                                                                                          print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());


                                                                                        }else{

                                                                                          bool rpta= await eliminarProducto(UsuarioModel.idUsuario,snapshot.data[index].idProducto);

                                                                                          if(rpta){
                                                                                            print('ELIMINADO');
                                                                                            //amountProduct=0;

                                                                                          }else{
                                                                                            print('NOOOOOOOOOOOOOOOOOOOOOOOO');
                                                                                          }

                                                                                        }



                                                                                        setState((){
                                                                                          //cant=cant-1;
                                                                                        });
                                                                                      },

                                                                                    )


                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.only(right: 12.0),
                                                                                  child: Center(
                                                                                      child: Text((snapshot2.data.registropedido_cantidad).toString())
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                    padding: const EdgeInsets.only(left: 1.0),
                                                                                    child:
                                                                                    IconButton(
                                                                                      icon: Icon(Icons.add ,size: 30.0,color:Colors.green),
                                                                                      onPressed:() async{

                                                                                        PedidoModel pedido= new PedidoModel(
                                                                                            idProducto: snapshot.data[index].idProducto,
                                                                                            cantidad: 1,
                                                                                            precio: (snapshot.data[index].Producto_precio).toDouble(),
                                                                                            idUsuario: UsuarioModel.idUsuario
                                                                                        );
                                                                                        bool rpta= await createPedidoAumentar(pedido);
                                                                                        print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());
                                                                                        print('AUDIOOOOOOOOOOOOOOOOO');

                                                                                        _audioCache.play('cartSound.mp3');

                                                                                        setState((){

                                                                                          //  UsuarioModel.cantidadTotal++;

                                                                                          //  cant=cant+1;
                                                                                        });
                                                                                      },
                                                                                    )
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    */

                                                    }
                                                    else{
                                                      return   ButtonAnimationWidget(
                                                        idProducto: snapshot
                                                            .data[index].idProducto,
                                                        cantidadAnimation: 0,
                                                        precio: (snapshot
                                                            .data[index]
                                                            .Producto_precio)
                                                            .toDouble(),
                                                        idUsuario: UsuarioModel.idUsuario,
                                                        changeSize: false,
                                                      );
                                                    }
                                                  }
                                              )

                                              /*
                                              FutureBuilder<RegistroPedidoModel>(
                                                  future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(snapshot.data[index].idProducto).toString()),
                                                  builder:(context,snapshot2){
                                                    if(snapshot2.data != null){


                                                      if(snapshot2.data.registropedido_cantidad > 0){
                                                        return Padding(
                                                          padding: const EdgeInsets.only(top:150.0,right: 10.0),
                                                          child: Card(
                                                            color: Colors.white,
                                                            child: Container(
                                                              //color: Colors.deepPurpleAccent,
                                                              child: Row(

                                                                children: <Widget>[



                                                                  Padding(
                                                                      padding: const EdgeInsets.only(right: 15.0),
                                                                      child:

                                                                      IconButton(
                                                                        icon: Icon(Icons.remove ,size: 30.0,color: Colors.green,),
                                                                        onPressed:()async {
                                                                          if(snapshot2.data.registropedido_cantidad > 1){
                                                                            PedidoModel pedido= new PedidoModel(
                                                                                idProducto: snapshot.data[index].idProducto,
                                                                                cantidad: 1,
                                                                                precio: (snapshot.data[index].Producto_precio).toDouble(),
                                                                                idUsuario: UsuarioModel.idUsuario
                                                                            );

                                                                            bool rpta= await createPedidoDisminuir(pedido);
                                                                            print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());


                                                                          }else{

                                                                            bool rpta= await eliminarProducto(UsuarioModel.idUsuario,snapshot.data[index].idProducto);

                                                                            if(rpta){
                                                                              print('ELIMINADO');

                                                                            }else{
                                                                              print('NOOOOOOOOOOOOOOOOOOOOOOOO');
                                                                            }

                                                                          }
                                                                          setState((){
                                                                            //cant=cant-1;
                                                                          });
                                                                        },

                                                                      )


                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right: 12.0),
                                                                    child: Center(
                                                                        child: Text((snapshot2.data.registropedido_cantidad).toString())
                                                                    ),

                                                                  ),
                                                                  Padding(
                                                                      padding: const EdgeInsets.only(left: 1.0),
                                                                      child:
                                                                      IconButton(

                                                                        icon: Icon(Icons.add ,size: 30.0,color:Colors.green),
                                                                        onPressed:() async{
                                                                          setState(() {

                                                                          });


                                                                          PedidoModel pedido= new PedidoModel(
                                                                              idProducto: snapshot.data[index].idProducto,
                                                                              cantidad: 1,
                                                                              precio: (snapshot.data[index].Producto_precio).toDouble(),
                                                                              idUsuario: UsuarioModel.idUsuario
                                                                          );

                                                                          bool rpta= await createPedidoAumentar(pedido);
                                                                          print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());
                                                                          _audioCache.play('my_audio.mp3');


                                                                        },

                                                                      )


                                                                  ),

                                                                ],
                                                              ),

                                                            ),
                                                          ),
                                                        );
                                                      }else{

                                                        return   ButtonAnimationWidget(
                                                          idProducto: snapshot
                                                              .data[index].idProducto,
                                                          cantidadAnimation: 1,
                                                          precio: (snapshot
                                                              .data[index]
                                                              .Producto_precio)
                                                              .toDouble(),
                                                          idUsuario: UsuarioModel.idUsuario,
                                                        );
                                                      }



                                                    }else{
                                                      return Container(
                                                        color: Colors.red,
                                                        height: 10.0,
                                                      );
                                                    }
                                                  }
                                              )
                                            */

                                            /*
                                                  ButtonAnimationWidget(
                                                    idProducto: snapshot
                                                        .data[index].idProducto,
                                                    cantidad: 1,
                                                    precio: (snapshot
                                                            .data[index]
                                                            .Producto_precio)
                                                        .toDouble(),
                                                    idUsuario: 1,
                                                  ),*/



                                          ),
                                        ),




                                        Positioned(
                                          top:180,
                                          left: 20.0,
                                          child:Center(
                                            child: Column(

                                              children: <Widget>[
                                                Text(snapshot.data[index].Producto_nombre + " "+ snapshot.data[index].producto_marca),
                                                Text( (snapshot.data[index].Producto_precio).toString())
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                );
                              })
                          ),
                        );
                      }else{
                        return Container(
                         //color: Colors.redAccent,
                          child:  GridView.count(
                            crossAxisCount:2,
                            primary: false,
                            crossAxisSpacing: 2,
                            controller: new ScrollController(keepScrollOffset: false),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            childAspectRatio: 0.6,
                            children: List.generate(20, (index) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Skeleton(type:'boxListCategories',),
                              );
                            }),
                          )
                        );
                        /*
                          SliverGrid(
                          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

                          delegate: SliverChildBuilderDelegate( (BuildContext context ,int index){
                            return Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Skeleton(type:'boxListCategories',),
                            );
                          },childCount: 20,
                          ),

                        );
                      */

                      }

                    },
                  ),



                ],

              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar:
      //canasta()

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
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),topRight: Radius.circular(10.0)),
                // color: Color.fromRGBO(217, 4, 82, 1),
                color:GREENCART,
              ),
              child:Row(
                children: <Widget>[

                 /* Container(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Center(
                      child:  Text(
                       amountProduct.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(left: 5.0,top: 2.0,bottom: 2.0),
                    child:Container(
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          //border:Border.all(color: Colors.white,width: 1.5),
                          //color: Colors.yellowAccent,

                        ),
                        width: MediaQuery.of(context).size.width*0.3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[


                            StreamBuilder(
                              stream: mainPusher.eventStream2,
                              builder: (context,AsyncSnapshot snapshot){
                                if(snapshot.hasData){
                                  Message mes=Message.fromJson(jsonDecode(snapshot.data));
                                  amountProduct=mes.message;
                                  return Text(
                                    amountProduct.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }else{
                                  return Text(
                                    amountProduct.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  );
                                }

                              },
                            ),

                            /*Text(
                              amountProduct.toString(),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),*/
                            Text(
                              'productos',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                    ),
                  ),

                  Container(
                    width:MediaQuery.of(context).size.width*0.6,
                    height: 50.0,
                    //color: Colors.lightGreenAccent,
                    child: Row(
                      children: <Widget>[
                         Padding(
                      padding: EdgeInsets.only(left: 1.0),
                    child: Icon(Icons.shopping_cart,color: Colors.white,size: 20.0,),
                  ),
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
      ),

    );
  }


  Widget _cantidadTotal(){

    if(cantidadTotal>0){

      return Text(
        '+' +
            (cantidadTotal).toString(),
        style: TextStyle(
            color: Colors.white,
            fontWeight:
            FontWeight.bold),
      );
    }else{
      return Text('',style: TextStyle(fontSize: 30.0));
    }


  }
}
