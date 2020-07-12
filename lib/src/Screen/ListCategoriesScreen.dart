import 'dart:convert';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:tienda_mimi/Service/Api/RegistroPedidoApi.dart';
import 'package:tienda_mimi/Service/Api/SubCategoriaApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Bloc/BlocPattern.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:tienda_mimi/Service/Model/RegistroPedidoModel.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';
import 'package:tienda_mimi/Service/Pusher/mainPusher.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Boton.dart';
import 'package:tienda_mimi/src/ButtonAnimationWidget.dart';
import 'package:tienda_mimi/src/Screen/DetailProductScreen.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:tienda_mimi/src/Screen/SearchScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';
import 'package:tienda_mimi/src/Widgets/SubCategoriesWidget.dart';
import 'package:http/http.dart' as http;

int cantTotal=cantidadProductos;


class ListCategoriesScreen extends StatefulWidget {
  final CategoriesModel categoriesModel;

  const ListCategoriesScreen({Key key, this.categoriesModel}) : super(key: key);

  @override
  _ListCategoriesScreenState createState() => _ListCategoriesScreenState(categoriesModel);
}

class _ListCategoriesScreenState extends State<ListCategoriesScreen>  with WidgetsBindingObserver {
  final CategoriesModel categoriesModel;


  _ListCategoriesScreenState(this.categoriesModel);
  AudioCache _audioCache;
  //MainPusher mainPusher=new MainPusher();


  @override
  void initState() {
    super.initState();
    rxPedidoReal.fetchTodo(http.Client(),UsuarioModel.idUsuario.toString());
    print('holi');
   //bindPusher();
    mainPusher.bindPusher();
    WidgetsBinding.instance.addObserver(this);

    // bindPusher1();
    _audioCache = AudioCache(prefix: "audio/", fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP));


  }

  @override
  void dispose() {
    super.dispose();
    //mainPusher.closeStream;
    print('sali de LIST CATEGORIRES');

   // WidgetsBinding.instance.removeObserver(this);

  //  mainPusher.eventStream.isEmpty;

  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('ESTAMOS EN PAUSE LISTCATEGORIES SCREENN');
      channel.unbind(eventController.text);

      // went to Background
    }
    if (state == AppLifecycleState.resumed) {
      print('ESTAMOS EN RESUMEN LISTCATEGORIES SCREENN');
      // came back to Foreground
    }
    if (state == AppLifecycleState.inactive) {
      print('ESTAMOS EN INACTIVE LISTCATEGORIES SCREENN');
      // came back to Foreground
    }
    if (state == AppLifecycleState.values) {
      print('ESTAMOS EN VALUES LISTCATEGORIES SCREENN');
      // came back to Foreground
    }
  }




  void bindPusher(){
    channel.bind(eventController.text, (x) {
      if (mounted){
        _audioCache.play('cartSound.mp3');

        setState(() {
          lastEvent = x;
          Message mes=Message.fromJson(jsonDecode(lastEvent.data));
          cantTotal=mes.message;
          cantidadProductos=cantTotal;
          amountProduct=mes.message;

        });
      }

    });
  }


  void bindPusher1(){
    channel1.bind(eventController1.text, (x) {
      if (mounted)
        setState(() {
          lastEvent1 = x;
        });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[

          SliverAppBar(
            elevation: 5,
            floating: false,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height*0.301,//0.26
            backgroundColor: Colors.white,
            title:
            Padding(
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
                  future: showUbicacionActual(http.Client(),(UsuarioModel.idUsuario).toString()),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        alignment: AlignmentDirectional.center,
                        height: 28.0,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: new BoxDecoration(
                          //color:Colors.white,
                          /*image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:AssetImage('assets/fondoShoppingCart3.png')
                              ),*/
                            borderRadius: new BorderRadius.only(
                              topLeft:  const  Radius.circular(10.0),
                              topRight: const  Radius.circular(0.0),
                              bottomLeft: const  Radius.circular(10.0),
                              bottomRight: const  Radius.circular(10.0),

                            )

                        ),
                        child: Container(
                          child: Stack(

                            children: <Widget>[


                              Positioned(
                                left: 5.0,
                                top:5.0,
                                child:  Text(
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
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black54,
              ),
            ),
           // backgroundColor: Colors.orangeAccent,
            flexibleSpace:FlexibleSpaceBar(
              //title: Text('holaaaaaaaa'),
             background: Stack(
               children: <Widget>[
                Positioned(
                     child: Image.network(categoriesModel.categoria_uri_post,
                     fit: BoxFit.cover,
                       height: 170.0,
                     )

                 ),
                 Positioned(
                     right: 130.0,
                     top: 60.0,
                     child:  Padding(
                       padding: EdgeInsets.only(left:1.0),
                       child: Container(
                         width: 200.0,
                        // color: Colors.blue,
                         height: 80.0,
                         child: Text(categoriesModel.categoria_nombre,style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),),
                       ),
                     ),

                 ),
                 Positioned(
                     //right: 10.0,
                     top: 120.0,
                     child:  Padding(
                       padding: EdgeInsets.only(left:5.0),
                       child: Container(
                         width: 350.0,
                         //color: Colors.teal,
                         height:100.0,
                         child:Card(
                             child:Column(
                               children: <Widget>[

                                 Row(
                                   children: <Widget>[

                                     Padding(
                                         padding: EdgeInsets.only(left:100.0),
                                         child: Text('Categorias')
                                     ),

                                     Padding(
                                         padding: EdgeInsets.only(left:70.0),

                                           child: Container(
                                             height: 20.0,
                                             width: 50.0,
                                             color: Colors.blue,
                                             child: Center(
                                               child: Text('Mas +',style:TextStyle(color: Colors.white)),
                                             )
                                           )

                                     ),
                                   ],
                                 ),

                                 Container(
                                   color:Colors.white,
                                   height: 70.0,
                                   child: SubCategoriesWidget(categoriesModel.idCategoria),
                                 )

                               ],
                             )
                         )
                       ),
                     )
                 )


               ],
             ),
             // background: FutureBuilder(builder: null),
            ),


            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: IconButton(
                    icon:Icon(Icons.search,color: Colors.black54,),
                    onPressed: (){
                      showSearch(context: context, delegate: DataSearch(buscadorString));
                    }
                )
              )
            ],
          ),


          SliverToBoxAdapter(
            child: Container(
                height: 120,
                color: Colors.white,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  images: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.black38,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                  autoplay: true,
                  dotBgColor: Colors.black.withOpacity(0.0),
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                )),
          ),



          FutureBuilder<List<SubCategoriaModel>>(
              future: fetchSubCategoriaModel(
                  http.Client(), categoriesModel.idCategoria),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(
                          height: 320.0,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.025),
                                child: Container(
                                  child: Text(
                                    snapshot.data[index].nombresubcategoria,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,color: Colors.black38),
                                  ),
                                  alignment: AlignmentDirectional.topStart,
                                  /*
                                Row(
                                  children: <Widget>[
                                   /* Padding(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Image.network(
                                        snapshot.data[index].urisubcategoria,
                                        height: 30.0,
                                        width: 30.0,
                                      ),
                                    ),*/
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 180.0),
                                      child: Text(
                                        snapshot.data[index].nombresubcategoria,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                */
                                ),
                              ),
                              FutureBuilder<
                                  List<ProductoJOINCategoriaJOINImagenModel>>(
                                  future: fetchProductoSubCategoria(
                                      http.Client(),
                                      (snapshot.data[index].idsubcategoria)
                                          .toString()),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null) {
                                      return Container(
                                        height: 280.0,
                                        color: Colors.white,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return new Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  color: Colors.white,
                                                  width: 150.0,
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Positioned(
                                                        left: 1.0,
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DetailProductScreen(
                                                                        productoJOINCategoriaJOINImagenModel:
                                                                        snapshot
                                                                            .data[index]),
                                                              ),
                                                            );
                                                          },
                                                          child: Image.network(
                                                            snapshot.data[index]
                                                                .producto_uri_imagen,
                                                            height: 130.0,
                                                            width: 130.0,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),



                                                      Positioned(

                                                        right: 10.0,
                                                        top: 200,
                                                        child: GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                print('');
                                                              });
                                                            },
                                                            child:

                                                            FutureBuilder<RegistroPedidoModel>(
                                                                future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(snapshot.data[index].idProducto).toString()),
                                                                builder:(context,snapshot2){
                                                                  if(snapshot2.data != null){
                                                                    return ButtonAnimationWidget2(
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

                                                        ),
                                                      ),




                                                      Positioned(
                                                        top: 150,
                                                        left: 10.0,
                                                        child: Center(
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                'S./ ' +
                                                                    (snapshot
                                                                        .data[
                                                                    index]
                                                                        .Producto_precio)
                                                                        .toString(),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                    15.0),
                                                              ),
                                                              SizedBox(
                                                                height: 5.0,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .Producto_nombre,
                                                                style: TextStyle(
                                                                  // fontWeight: FontWeight.bold,
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                    15.0),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data[index]
                                                                    .producto_marca,
                                                                style: TextStyle(
                                                                  // fontWeight: FontWeight.bold,
                                                                    color: Colors
                                                                        .black38,
                                                                    fontSize:
                                                                    15.0),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
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
                                  }),
                            ],
                          ),
                        );
                      },
                      childCount: snapshot.data.length,
                    ),
                  );
                } else {
                  return

                    SliverList(
                  delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
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
                  },
                    childCount: 10,

                  )
                  );

                }
              }
              ),
        ],
      ),

      bottomNavigationBar: GestureDetector(
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
                color:Color.fromRGBO(5, 175, 242, 1),
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
                         stream: mainPusher.eventStream,
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
/*

Row(
                      children: <Widget>[

                        Padding(
                            padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),

                        Padding(
                          padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),

                        Padding(
                          padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),

                        Padding(
                          padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),

                        Padding(
                          padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),

                        Padding(
                          padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),

                        Padding(
                          padding:EdgeInsets.all(10.0),
                          child:  Skeleton(type: 'boxListCategories',),
                        ),


                      ],
                    );
* */

    );
  }



}
