import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/PedidoApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:tienda_mimi/Service/Api/RegistroPedidoApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/PedidoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:tienda_mimi/Service/Model/RegistroPedidoModel.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Boton.dart';
import 'package:tienda_mimi/src/ButtonAnimationWidget.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:tienda_mimi/src/Screen/SearchScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Screen/DetailProductScreen.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';
import 'package:tienda_mimi/src/Widgets/canasta.dart';

class SearchResult1Screen extends StatefulWidget {
  final String palabraClave;

  const SearchResult1Screen({Key key, this.palabraClave}) : super(key: key);
  @override
  _SearchResult1ScreenState createState() =>
      _SearchResult1ScreenState(palabraClave);
}

class _SearchResult1ScreenState extends State<SearchResult1Screen> {
  final String palabraClave;
  String subCategoria="";
  int currentTab = 0; // to keep track of active tab index

  _SearchResult1ScreenState(this.palabraClave);

  initState(){
    super.initState();
   // bindPusher();
  }

  void bindPusher(){
    channel.bind(eventController.text, (x) {
      if (mounted)
        setState(() {
          lastEvent = x;
          Message mes=Message.fromJson(jsonDecode(lastEvent.data));
          //cantTotal=mes.message;
          amountProduct=mes.message;
          //cantidadProductos=cantTotal;


        });
    });
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData media=MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black54,
          ),
        ),
        backgroundColor: Colors.white,
        title: Padding(
          padding: EdgeInsets.only(left: 1.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationScreen(),
                  ));
            },
            child: FutureBuilder<UbicacionModel>(
              future: showUbicacionActual(
                  http.Client(), (UsuarioModel.idUsuario).toString()),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    height: 28.0,
                    width: //200,
                    media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.6 :MediaQuery.of(context).size.width * 0.8,
                    decoration: new BoxDecoration(
                        //color:Colors.white,
                        /*image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:AssetImage('assets/fondoShoppingCart3.png')
                              ),*/
                        borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(0.0),
                      bottomLeft: const Radius.circular(10.0),
                      bottomRight: const Radius.circular(10.0),
                    )),
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 5.0,
                            top: 5.0,
                            child: Text(
                              snapshot.data.ubicacion_nombre,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            ),
                          ),
                          Positioned(
                            bottom: 2.0,
                            child: Divider(
                              height: 4.0,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
        actions: <Widget>[
          FutureBuilder<List<String>>(
              future: fetchLista(http.Client()),
              builder: (context, snapshot) {
                return IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: DataSearch(snapshot.data));
                    }
                    );
              }),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
             // color: Colors.deepOrange,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  children: <Widget>[
                    Container(
                     //  color: Colors.purpleAccent,
                      width:MediaQuery.of(context).size.width*0.7,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                      Padding(
                      padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                             "Resultados de " + subCategoria,
                             style: TextStyle(
                                 fontSize: 15.0 ),
                           ),
                      )

                         ],
                        )

                    ),
                    Container(
                    // color: Colors.lightGreenAccent,
                      width:MediaQuery.of(context).size.width*0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(left: 0.0),
                              child: FutureBuilder<
                                  List<ProductoJOINCategoriaJOINImagenModel>>(
                                  future: fetchBusquedaProducto(
                                      http.Client(), palabraClave),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return Text('('+(snapshot.data.length).toString() +
                                          ' productos'+')',
                                        style: TextStyle(
                                            fontSize: 15.0),);
                                    } else {
                                      return Text('0 productos',
                                        style: TextStyle(
                                            fontSize: 15.0),);
                                    }
                                  }))
                        ],
                      ),
                    ),

                  ],
                )),
          ),

          SliverToBoxAdapter(
            child: FutureBuilder<List<ProductoJOINCategoriaJOINImagenModel>>(
              future: fetchBusquedaProducto(http.Client(), palabraClave),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  subCategoria=snapshot.data.toList().removeAt(0).nombresubcategoria;
                  print('ACTUAL    '+ subCategoria);
                  return Container(

                    height://MediaQuery.of(context).size.height*0.42,
                    media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.42 :MediaQuery.of(context).size.height * 0.8,

                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return new Container(
                              margin: EdgeInsets.all(5.0),
                              //color: Colors.blue,
                              width: 210.0,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    left: 50.0,
                                    top: 10.0,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailProductScreen(
                                                    productoJOINCategoriaJOINImagenModel:
                                                        snapshot.data[index]),
                                          ),
                                        );
                                      },
                                      child: Image.network(
                                        snapshot
                                            .data[index].producto_uri_imagen,
                                        height: 150.0,
                                        width: 120.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    top: 170,
                                    left: 30.0,
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[
                                          Text(snapshot
                                                  .data[index].Producto_nombre +
                                              " " +
                                              snapshot
                                                  .data[index].producto_marca),
                                          Text("S/. " +
                                              (snapshot.data[index]
                                                      .Producto_precio)
                                                  .toString())
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 20.0,
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
                                                future: fetchRegistroPedido(
                                                    http.Client(),
                                                    (UsuarioModel.idUsuario)
                                                        .toString(),
                                                    (snapshot.data[index]
                                                            .idProducto)
                                                        .toString()),
                                                builder: (context, snapshot2) {
                                                  if (snapshot2.data != null) {
/*
                                                                    print('El codigo del producto es '+
                                                                        (snapshot2.data.idproducto).toString() +
                                                                        ' y la cantidad es :'+
                                                                        (snapshot2.data.registropedido_cantidad).toString());
*/
                                                    if (snapshot2.data
                                                            .registropedido_cantidad >
                                                        0) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 150.0,
                                                                right: 10.0),
                                                        child: Card(
                                                          color: Colors.white,
                                                          child: Container(
                                                            //color: Colors.deepPurpleAccent,
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            15.0),
                                                                    child:
                                                                        IconButton(
                                                                      icon:
                                                                          Icon(
                                                                        Icons.remove,
                                                                        size:
                                                                            30.0,
                                                                        color: Colors
                                                                            .green,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        if (snapshot2.data.registropedido_cantidad >
                                                                            1) {
                                                                          PedidoModel
                                                                              pedido =
                                                                              new PedidoModel(
                                                                            idProducto:
                                                                                snapshot.data[index].idProducto,
                                                                            cantidad:
                                                                                1,
                                                                            precio:
                                                                                (snapshot.data[index].Producto_precio).toDouble(),
                                                                            idUsuario:
                                                                                UsuarioModel.idUsuario,
                                                                          );

                                                                          bool
                                                                              rpta =
                                                                              await createPedidoDisminuir(pedido);
                                                                          print((rpta).toString() +
                                                                              " - " +
                                                                              (pedido.idUsuario).toString() +
                                                                              " -  " +
                                                                              (pedido.idProducto).toString());
                                                                        } else {
                                                                          bool rpta = await eliminarProducto(
                                                                              1,
                                                                              snapshot.data[index].idProducto);

                                                                          if (rpta) {
                                                                            print('ELIMINADO');
                                                                          } else {
                                                                            print('NOOOOOOOOOOOOOOOOOOOOOOOO');
                                                                          }
                                                                        }

                                                                        setState(
                                                                            () {
                                                                          //cant=cant-1;
                                                                        });
                                                                      },
                                                                    )),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          12.0),
                                                                  child: Center(
                                                                      child: Text((snapshot2
                                                                              .data
                                                                              .registropedido_cantidad)
                                                                          .toString())),
                                                                ),
                                                                Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            1.0),
                                                                    child:
                                                                        IconButton(
                                                                      icon: Icon(
                                                                          Icons
                                                                              .add,
                                                                          size:
                                                                              30.0,
                                                                          color:
                                                                              Colors.green),
                                                                      onPressed:
                                                                          () async {
                                                                        PedidoModel pedido = new PedidoModel(
                                                                            idProducto:
                                                                                snapshot.data[index].idProducto,
                                                                            cantidad: 1,
                                                                            precio: (snapshot.data[index].Producto_precio).toDouble(),
                                                                            idUsuario: UsuarioModel.idUsuario);
                                                                        bool
                                                                            rpta =
                                                                            await createPedidoAumentar(pedido);
                                                                        print((rpta).toString() +
                                                                            " - " +
                                                                            (pedido.idUsuario).toString() +
                                                                            " -  " +
                                                                            (pedido.idProducto).toString());
                                                                        setState(
                                                                            () {
                                                                        //  UsuarioModel
                                                                          //    .cantidadTotal++;

                                                                          //  cant=cant+1;
                                                                        });
                                                                      },
                                                                    )),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return ButtonAnimationWidget(
                                                        idProducto: snapshot
                                                            .data[index]
                                                            .idProducto,
                                                        cantidadAnimation: 1,
                                                        precio: (snapshot
                                                                .data[index]
                                                                .Producto_precio)
                                                            .toDouble(),
                                                        idUsuario: UsuarioModel
                                                            .idUsuario,
                                                      );
                                                    }
                                                  } else {
                                                    return Container(
                                                      color: Colors.blue,
                                                      height: 10.0,
                                                    );
                                                  }
                                                })
                                    */


                                    ),


                                  ),
                                ],
                              ));
                        }),
                  );
                } else {
                  return Container(
                      height: 280.0,
                      color: Colors.white,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Skeleton(type:  'boxListCategories',),
                            );
                          }

                      )
                  );
                }
              },
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                  height://MediaQuery.of(context).size.height*0.25,
                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.20 :MediaQuery.of(context).size.height * 0.4,

                  // color: Colors.redAccent,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.black26,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                    autoplay: true,
                    dotBgColor: Colors.black.withOpacity(0.0),
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                  ))
          ),

        ],
      ),

      bottomNavigationBar:

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
              width: MediaQuery.of(context).size.width*0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(10.0),topRight: Radius.circular(10.0)),
                //color: Color.fromRGBO(217, 4, 82, 1),
                color:GREENCART,
              ),
              child:Row(
                children: <Widget>[
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
                              stream: mainPusher.eventStream3,
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
                          padding: EdgeInsets.only(left: 10.0),
                          child: Icon(Icons.shopping_cart,color: Colors.white,size: 20.0,),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left:10.0),
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
      //canasta(),
    );
  }


/*
  Widget _bottomNavigationNext(){
    final media=MediaQuery.of(context);
    if(cantidadProductos>0){
      return Container(
        height:
        media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.18,

        //color: Colors.orangeAccent,
        child: Row(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(left:media.size.width*0.07,bottom:10.0),
              child: Container(
                  height: 60.0,
                  width:// 100.0,
                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.25 :MediaQuery.of(context).size.width * 0.3,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color:Color.fromRGBO(5, 175, 242, 1)),
                    color:Colors.white,
                  ),
                  child: FutureBuilder<PedidoRealModel>(
                      future: fetchPedidoReal(http.Client(),(UsuarioModel.idUsuario).toString()),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          if(snapshot.data.pedido_estado !='Atendido'){
                            UsuarioModel.cantidadTotal=snapshot.data.pedido_cantidadtotal;
                            return Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text('S/. '+(snapshot.data.pedido_montototal).toStringAsFixed(1)
                                    ,style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
                                )
                            );
                          }else{
                            return Container(
                            );
                          }
                        } else {
                          return Container(
                          );
                        }
                      }
                  )
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left:10.0,bottom:10.0),
              child:Container(
                  height: 60.0,
                  width:media.size.width*0.6,
                  //  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.6 :MediaQuery.of(context).size.width * 0.6,

                  child:RaisedButton(

                    onPressed:(){
                      Navigator.of(context).pushNamed('/ScheduleScreen');

                    },
                    color: Color.fromRGBO(5, 175, 242, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        width: 180.0,
                        child: Center(
                          child: Text('Siguiente',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                        )
                    ),
                  )
              ),
            )

          ],
        ),
      );
    }else{
      return Container(
        height:
        media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.18,

        //color: Colors.orangeAccent,
        child: Row(
          children: <Widget>[

            Padding(
              padding: EdgeInsets.only(left:media.size.width*0.07,bottom:10.0),
              child: Container(
                  height: 60.0,
                  width:// 100.0,
                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.25 :MediaQuery.of(context).size.width * 0.3,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all( color: Color.fromRGBO(5, 175, 242, 1),
                    ),
                    color:Colors.white,
                  ),
                  child:Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Center(
                          child: Icon(Icons.home)
                      )
                  )
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left:10.0,bottom:10.0),
              child:Container(
                  height: 60.0,
                  width:media.size.width*0.6,
                  //  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.6 :MediaQuery.of(context).size.width * 0.6,

                  child:RaisedButton(

                    onPressed:(){
                      //Navigator.of(context).pushNamed('/ScheduleScreen');
                      Navigator.of(context).pop();


                    },
                    color: Color.fromRGBO(5, 175, 242, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Container(
                        width: 180.0,
                        child: Center(
                          child: Text('Inicio',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                        )
                    ),
                  )
              ),
            )

          ],
        ),
      );
    }
  }
*/
}
