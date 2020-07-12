import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/FavoriteProductApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Bloc/BlocPattern.dart';
import 'package:tienda_mimi/Service/Model/PedidoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:tienda_mimi/Service/Api/RegistroPedidoApi.dart';
import 'package:tienda_mimi/Service/Api/SubCategoriaApi.dart';
import 'package:tienda_mimi/Service/Model/RegistroPedidoModel.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/Service/Model/base_model.dart';
import 'package:tienda_mimi/src/Boton.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';
import 'package:tienda_mimi/Service/Model/FavoriteProductModel.dart';

import '../ButtonAnimationWidget.dart';

enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISIBLE
}



class DetailProductScreen extends StatefulWidget {
  final ProductoJOINCategoriaJOINImagenModel productoJOINCategoriaJOINImagenModel;

  const DetailProductScreen({Key key, this.productoJOINCategoriaJOINImagenModel}) : super(key: key);



  @override
  _DetailProductScreenState createState() => _DetailProductScreenState(
      productoJOINCategoriaJOINImagenModel
  );
}

class _DetailProductScreenState extends State<DetailProductScreen> with TickerProviderStateMixin{
  final ProductoJOINCategoriaJOINImagenModel productoJOINCategoriaJOINImagenModel;
  int cantidad=1;
  _DetailProductScreenState(this.productoJOINCategoriaJOINImagenModel);

  int cantidadProducto=0;
  int cantPusher;
  int cantidadTotal=cantidadProductos;
  bool favoriteProductState=false;
  FavoriteProductApi favoriteProductApi;



  initState(){
    super.initState();
   // bindPusher2();
    cantPusher=0;
    print(productoJOINCategoriaJOINImagenModel.producto_cantidad);
    favoriteProductApi=new FavoriteProductApi();
  }




  void bindPusher2(){
    channel2.bind(eventController2.text, (x) {
      if (mounted)
        setState(() {
          lastEvent2 = x;
          Message mes=Message.fromJson(jsonDecode(lastEvent2.data));
          cantPusher=mes.message;

        });
    });
  }




  @override
  Widget build(BuildContext context) {

    MediaQueryData media=MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading:GestureDetector(
          onTap: (){

            Navigator.of(context).pop();

          },
          child:  Icon(
            Icons.arrow_back,
            color:Color.fromRGBO(5, 175, 242, 1),
            size:20,
          ),
        ),
        title: FutureBuilder<UbicacionModel>(
          future: showUbicacionActual(http.Client(),(UsuarioModel.idUsuario).toString()),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                alignment: AlignmentDirectional.center,
                height: 28.0,
                width: MediaQuery.of(context).size.width*0.6,
                decoration: new BoxDecoration(

                    borderRadius: new BorderRadius.only(
                      topLeft:  const  Radius.circular(10.0),
                      topRight: const  Radius.circular(0.0),
                      bottomLeft: const  Radius.circular(10.0),
                      bottomRight: const  Radius.circular(10.0),

                    ),
                  //color: Colors.blue,
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
                            color: Colors.black38, fontSize: 14.0,fontWeight: FontWeight.bold,),
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
              return Container(
                child: Text('nothig'),
              );
            }
          },
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
                          child: Icon(Icons.shopping_basket,color:Colors.black54,size: 25.0,),
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
                      child:_cantidadTotal2(),
                    )),
              )
              
            ],
          ),
          )

        ],
      ),

      body:CustomScrollView(
        slivers: <Widget>[
/*
         SliverToBoxAdapter(
           child: Padding(
             padding: const EdgeInsets.only(top:20.0),
             child: Container(
               height: 50.0,
               color: Colors.white,
               child: Row(
                 children: <Widget>[

                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       child: Icon(Icons.arrow_back_ios,color: Colors.black54,size:20.0),
                     ),
                   ),



                   Padding(
                     padding: const EdgeInsets.only(left:280.0),
                     child: Container(
                       child: Icon(Icons.shopping_cart,color:Colors.black54,size: 25.0,),
                     ),
                   )



                 ],
               ),
             ),
           ),
         ),
*/

          SliverToBoxAdapter(
            child: new Container(
              color:Colors.white,
              height: 400.0,
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.network(
                      productoJOINCategoriaJOINImagenModel.producto_uri_imagen,
                      height: 200,
                      width: 300,
                      //fit: BoxFit.cover,
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(productoJOINCategoriaJOINImagenModel.Producto_nombre+" "
                              +productoJOINCategoriaJOINImagenModel.producto_marca ,
                            style: TextStyle(fontSize: 25.0,color: Colors.black38),
                          ),
                        ),
                      ),

                    ],
                  ),

                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: Text(productoJOINCategoriaJOINImagenModel.producto_detalle+
                              " "+productoJOINCategoriaJOINImagenModel.producto_envase+
                              " "+productoJOINCategoriaJOINImagenModel.producto_cantidad ,
                            style: TextStyle(fontSize: 25.0,color: Colors.black38),
                          ),
                        ),
                      ),
                    ],
                  ),

                 Padding(
                     padding: EdgeInsets.only(top:.5),
                     child:  Container(
                       height: 60,
                     // color: Colors.deepOrange,
                       child: Row(
                         children: <Widget>[
                           Padding(
                             padding: const EdgeInsets.only(left:10.0),

                             child: Text("precio:",
                               style: TextStyle(color: Colors.black38,fontSize: 20.0,),
                             ),
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left:5.0),

                             child: Text('S/ '+(productoJOINCategoriaJOINImagenModel.Producto_precio).toString(),
                               style: TextStyle(color: Colors.black45,fontSize: 30.0,fontWeight:FontWeight.bold),
                             ),
                           ),
                           /*
                           Padding(
                             padding: EdgeInsets.only(left:120.0),
                             child: RaisedButton(
                               child: Container(
                                 width: MediaQuery.of(context).size.width*0.12,
                                 height: 40,
                                 decoration: BoxDecoration(
                                   border: Border.all(color: Colors.amberAccent[400],width: 2.0),
                                   borderRadius: BorderRadius.circular(15.0),
                                   color: Colors.white,
                                 ),
                                 child: favoriteProductState == true ?
                                 Icon(Icons.favorite_border,color:Colors.amberAccent[400],size: 30,)
                                 :Icon(Icons.favorite,color:Colors.amberAccent[400],size: 30,),
                               ),
                                 onPressed: (){
                                 setState(() {

                                 });
                                 }
                             )
                           ),*/

                           FutureBuilder<FavoriteProductModel>(
                               future: favoriteProductApi.findByFavoriteProduct(
                                   http.Client(),
                                   UsuarioModel.idUsuario,
                                   productoJOINCategoriaJOINImagenModel.idProducto),
                               builder: (context,snapshot){
                                 if(snapshot.data !=null){
                                   return Padding(
                                       padding: EdgeInsets.only(left:100.0),
                                       child:Container(
                                           width: MediaQuery.of(context).size.width*0.15,
                                           height: 40,
                                           child: RaisedButton(
                                           color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                           borderRadius: new BorderRadius.circular(10.0),
                                         side: BorderSide(color: Colors.amberAccent[400],width: 2.0),
                                       ),
                                           child: Container(
                                             child: Padding(
                                               padding: EdgeInsets.only(top:0),
                                               child: favoriteProductState ==snapshot.data.activo ?
                                               Icon(Icons.favorite_border,color:Colors.amberAccent[400],size: 30,)
                                                   :Icon(Icons.favorite,color:Colors.amberAccent[400],size: 30,),
                                             )
                                           ),
                                           onPressed: ()async {

                                             if(snapshot.data.activo){
                                               bool respuesta=await favoriteProductApi.updateFavoriteProduct(snapshot.data.idFavorite,false);
                                               print('FALSEEEEEEEEEEEEEE');
                                             }else{
                                               bool respuesta=await favoriteProductApi.updateFavoriteProduct(snapshot.data.idFavorite,true);
                                               print('TRUEEEEEEEEEEEEEEEEEEEEE');
                                             }

                                             setState(() {


                                             });
                                           }
                                       )

                                       ),

                                   );
                                 }else{

                                   return Padding(
                                       padding: EdgeInsets.only(left:100.0),
                                       child: RaisedButton(
                                           color: Colors.white,
                                           child: Container(
                                               width: MediaQuery.of(context).size.width*0.12,
                                               height: 40,
                                               decoration: BoxDecoration(
                                                 border: Border.all(color: Colors.amberAccent[400],width: 2.0),
                                                 borderRadius: BorderRadius.circular(15.0),
                                                 color: Colors.white,
                                               ),
                                               child:
                                               Icon(Icons.favorite_border,color:Colors.amberAccent[400],size: 30,)

                                           ),
                                           onPressed: ()async {
                                             FavoriteProductModel favorite= new FavoriteProductModel(
                                               idFavorite: 0,
                                               idUsuario: UsuarioModel.idUsuario,
                                               idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                                               activo: true,
                                               fecha:null,
                                             );
                                             bool respuesta= await favoriteProductApi.createFavoriteProduct(favorite);
                                             setState(() {

                                             });
                                           }
                                       )
                                   );

                                 }
                               }
                           ),





                           /* Padding(

                        padding: const EdgeInsets.only(left:200.0),
                        child: Icon(Icons.favorite_border,color: Colors.black,size: 30.0,),
                      )*/
                         ],)
                     )

                 ),

                  /*Padding(
                    padding: EdgeInsets.only(left:30.0,right: 30.0),
                    child: Divider(
                      height: 10.0,
                      color: Colors.black38,
                    ),
                  )*/
                ],
              ),
            ),
          ),
/*
          SliverToBoxAdapter(
              child: Container(
                  height://MediaQuery.of(context).size.height*0.25,

                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.4,

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
                    showIndicator: false,
                  ))
          ),
*/
          SliverToBoxAdapter(
            child:SizedBox(
              height: 20.0,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),


/*
          SliverToBoxAdapter(
            child: Container(

              color: Colors.white,
              child: Padding(
                padding:  EdgeInsets.only(left:10.0,right: 120.0),
                child: Text("Sugerencias de compra",
                  style:TextStyle(
                    color: Colors.black38,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ) ,
                ),
              ),
            )
          ),

          SliverToBoxAdapter(
            child:SizedBox(
              height: 10.0,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          */
          FutureBuilder<List<SubCategoriaModel>>(
               future: fetchSubCategoriaModel(
                   http.Client(), productoJOINCategoriaJOINImagenModel.idCategoria),
               builder: (context, snapshot) {
                 if (snapshot.data != null) {
                   return SliverList(
                     delegate: SliverChildBuilderDelegate(
                           (BuildContext context, int index) {
                         return Container(
                           height: 350.0,
                           //                                        color: Colors.redAccent,
                           child: Column(
                             children: <Widget>[
                              /*
                               Container(
                                 color: Colors.white,
                                 child: Row(
                                   children: <Widget>[
                                     /*Padding(
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
                                           color: Colors.black38,
                                             fontSize: 20.0,
                                             fontWeight: FontWeight.bold),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                              */

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
                                                       /*Positioned(
                                                      right: 10.0,
                                                      top: 50,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            print('');
                                                          });
                                                        },
                                                        child: ButtonAnimationWidget(
                                                          idProducto: snapshot
                                                              .data[index]
                                                              .idProducto,
                                                          cantidad: 1,
                                                          precio: (snapshot
                                                                  .data[index]
                                                                  .Producto_precio)
                                                              .toDouble(),
                                                          idUsuario: 1,
                                                        ),
                                                      ),
                                                    ),*/

                                                       Positioned(

                                                         right: 10.0,
                                                         top: 200,
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

                                                                                           bool rpta= await eliminarProducto(1,snapshot.data[index].idProducto);

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


                                                                                         PedidoModel pedido= new PedidoModel(
                                                                                             idProducto: snapshot.data[index].idProducto,
                                                                                             cantidad: 1,
                                                                                             precio: (snapshot.data[index].Producto_precio).toDouble(),
                                                                                             idUsuario: UsuarioModel.idUsuario
                                                                                         );

                                                                                         bool rpta= await createPedidoAumentar(pedido);
                                                                                         print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());


                                                                                         setState((){
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
               }),



        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left:5.0,right: 5.0),
        child: Container(

          height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color:Color.fromRGBO(5, 175, 242, 1),
            ),
          //BUTTOM CARRITO

            child:Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:0.0),
                child:Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: FutureBuilder<RegistroPedidoModel>(
                      future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                      builder:(context,snapshot2){
                        if(snapshot2.data != null){
                          print('hola');
                          return
                            ButtonAnimationWidget2(
                              idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                              cantidadAnimation: snapshot2.data.registropedido_cantidad,
                              precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                                  .toDouble(),
                              idUsuario: UsuarioModel.idUsuario,
                              changeSize: true,

                            );

                        }
                        else{
                          print('adios');
                          return   ButtonAnimationWidget(
                            idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                            cantidadAnimation: 0,
                            precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                                .toDouble(),
                            idUsuario: UsuarioModel.idUsuario,
                            changeSize: true,
                          );
                        }
                      }
                  ),
                ),
              ),


              /*
              Container(
                width: MediaQuery.of(context).size.width*0.4,
                child: FutureBuilder<RegistroPedidoModel>(
                    future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                    builder:(context,snapshot2){
                      if(snapshot2.data != null){
                        print('hola');
                        return
                          ButtonAnimationWidget2(
                            idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                            cantidadAnimation: snapshot2.data.registropedido_cantidad,
                            precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                                .toDouble(),
                            idUsuario: UsuarioModel.idUsuario,
                            changeSize: true,

                          );

                      }
                      else{
                        print('adios');
                        return   ButtonAnimationWidget(
                          idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                          cantidadAnimation: 0,
                          precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                              .toDouble(),
                          idUsuario: UsuarioModel.idUsuario,
                          changeSize: true,
                        );
                      }
                    }
                ),
              ),
              */
              /*
              Padding(
                padding: EdgeInsets.only(left:1.0),
                child: Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        child:  Padding(
                          padding: EdgeInsets.only(left:1.0),
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color:GREENCART)

                            ),
                            child: Icon(Icons.remove,size: 30.0,color: GREENCART,),
                          ),
                        ),
                        onTap: () async {

                          setState(() {
                            cantidadProducto=cantidadProducto-1;
                            //print('hola'+(cantidadProducto).toString());

                          });

                          if (cantidadProducto <
                              2) {
                            bool rpta =
                            await eliminarProducto(
                                1,
                                productoJOINCategoriaJOINImagenModel
                                    .idProducto);

                          } else {
                            PedidoModel pedido =
                            new PedidoModel(
                                idProducto: productoJOINCategoriaJOINImagenModel
                                    .idProducto,
                                cantidad: cantidad,
                                precio: (productoJOINCategoriaJOINImagenModel
                                    .Producto_precio)
                                    .toDouble(),
                                idUsuario: (UsuarioModel.idUsuario));

                            bool rpta =
                            await createPedidoDisminuir(
                                pedido);

                          }




                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10.0),
                        child: Container(
                            child:/* Center(
                                child:Text((snapshot2.data.registropedido_cantidad).toString(),style: TextStyle(fontSize: 30.0),)
                            )*/
                          FutureBuilder<RegistroPedidoModel>(
                                        future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                                        builder:(context,snapshot2){

                                          if(snapshot2.data !=null){
                                            cantidadProducto=snapshot2.data.registropedido_cantidad;
                                            return Text((cantidadProducto).toString(),style: TextStyle(fontSize: 30.0),);
                                           // return _cantidadProducto(snapshot2.data.registropedido_cantidad);
                                           // return Text(cantidadProducto.toString());
                                          }else{
                                            return Text('0',style: TextStyle(fontSize: 30.0),);
                                          }

                                        }
                                    )
/*

                          child: Center(
                            child: Text('1',style: TextStyle(fontSize: 30.0),),
                          )*/

                        ),
                      ),
                      GestureDetector(
                        child:Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child: Container(
                            height: 50.0,
                            width: 50.0,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color:GREENCART)

                            ),
                            child: Icon(Icons.add,size: 30.0,color: GREENCART,),

                          ),



                        ),
                        onTap: () async {
                          setState(() {
                            cantidadProducto++;
                          });
                          PedidoModel pedido= new PedidoModel(
                              idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                              cantidad: cantidad,
                              precio: (productoJOINCategoriaJOINImagenModel.Producto_precio).toDouble(),
                              idUsuario: UsuarioModel.idUsuario
                          );
                          bool rpta =
                          await createPedidoAumentar(
                              pedido);
                          print((rpta).toString());

                          if(!rpta){
                            bool rpta= await createPedido(pedido);
                          }


                        },
                      )
                    ],
                  ),
                ),

              ),
              */
              Padding(
                  padding: EdgeInsets.only(left:10.0),
                  child:Container(
                    width: MediaQuery.of(context).size.width*0.52  ,
                    height: 50.0,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          side: BorderSide(color: Colors.white)
                        ),
                        onPressed: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShoppingCartScreen(
                                  idUsuario: UsuarioModel.idUsuario,
                                ),
                              ));

                        },
                        color:Color.fromRGBO(5, 175, 242, 1),
                        //color: Colors.amberAccent[400],
                        child: Row(
                          children: <Widget>[

                           Padding(
                              padding: EdgeInsets.only(left:0.0),
                              child: Icon(Icons.shopping_basket,color: Colors.white,size: 20,),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left:10.0),

                              child: Text('Carrito ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold
                                ),),
                            )

                          ],
                        )
                    ),
                  )

              ),


              /*FutureBuilder<RegistroPedidoModel>(
              future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
              builder:(context,snapshot2){

                if(snapshot2.data !=null){
                  cantidadProducto=snapshot2.data.registropedido_cantidad;
                  return    Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left:1.0),
                        child: Container(
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child:  Padding(
                                  padding: EdgeInsets.only(left:1.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.remove,size: 30.0,color: GREENCART,),
                                  ),
                                ),
                                onTap: () async {

                                  setState(() {
                                    cantidadProducto=cantidadProducto-1;
                                    //print('hola'+(cantidadProducto).toString());

                                  });

                                  if (cantidadProducto <
                                      2) {
                                    bool rpta =
                                        await eliminarProducto(
                                        1,
                                        productoJOINCategoriaJOINImagenModel
                                            .idProducto);

                                  } else {
                                    PedidoModel pedido =
                                    new PedidoModel(
                                        idProducto: productoJOINCategoriaJOINImagenModel
                                            .idProducto,
                                        cantidad: cantidad,
                                        precio: (productoJOINCategoriaJOINImagenModel
                                            .Producto_precio)
                                            .toDouble(),
                                        idUsuario: (UsuarioModel.idUsuario));

                                    bool rpta =
                                        await createPedidoDisminuir(
                                        pedido);

                                  }




                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:10.0),
                                child: Container(
                                    child: Center(
                                      child:Text((snapshot2.data.registropedido_cantidad).toString(),style: TextStyle(fontSize: 30.0),)
                                    )
                                    /*FutureBuilder<RegistroPedidoModel>(
                                        future:fetchRegistroPedido(http.Client(),(1).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                                        builder:(context,snapshot2){

                                          if(snapshot2.data !=null){
                                            cantidadProducto=snapshot2.data.registropedido_cantidad;
                                            return Text((cantidadProducto).toString(),style: TextStyle(fontSize: 30.0),);
                                          }else{
                                            return Text('0',style: TextStyle(fontSize: 30.0),);
                                          }

                                        }
                                    )*/
/*

                          child: Center(
                            child: Text('1',style: TextStyle(fontSize: 30.0),),
                          )*/

                                ),
                              ),
                              GestureDetector(
                                child:Padding(
                                  padding: EdgeInsets.only(left:10.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.add,size: 30.0,color: GREENCART,),

                                  ),



                                ),
                                onTap: () async {
                                  setState(() {
                                    cantidadProducto++;
                                  });
                                  PedidoModel pedido= new PedidoModel(
                                      idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                                      cantidad: cantidad,
                                      precio: (productoJOINCategoriaJOINImagenModel.Producto_precio).toDouble(),
                                      idUsuario: UsuarioModel.idUsuario
                                  );
                                  bool rpta =
                                  await createPedidoAumentar(
                                      pedido);
                                  print((rpta).toString());

                                  if(!rpta){
                                    bool rpta= await createPedido(pedido);
                                  }


                                },
                              )
                            ],
                          ),
                        ),

                      ),

                      Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child:Container(
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShoppingCartScreen(
                                          idUsuario: UsuarioModel.idUsuario,
                                        ),
                                      ));

                                },
                                color: GREENCART,
                                child: Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),
                                      child: Icon(Icons.shopping_cart,color: Colors.white,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),

                                      child: Text('Comprar ahora ',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                    )

                                  ],
                                )
                            ),
                          )

                      )
                    ],
                  );
                }else{
                  cantidadProducto=0;
                  return    Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left:1.0),
                        child: Container(
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child:  Padding(
                                  padding: EdgeInsets.only(left:1.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.remove,size: 30.0,color: GREENCART,),
                                  ),
                                ),
                                onTap: (){

                                  setState(() {
                                    cantidadProducto--;
                                  });


                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:10.0),
                                child: Container(
                                    child:Text((snapshot2.data.registropedido_cantidad).toString(),style: TextStyle(fontSize: 30.0),),


/*
                          child: Center(
                            child: Text('1',style: TextStyle(fontSize: 30.0),),
                          )*/

                                ),
                              ),
                              GestureDetector(
                                child:Padding(
                                  padding: EdgeInsets.only(left:10.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.add,size: 30.0,color: GREENCART,),

                                  ),



                                ),
                                onTap: () async {

                                  PedidoModel pedido= new PedidoModel(
                                      idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                                      cantidad: cantidad,
                                      precio: (productoJOINCategoriaJOINImagenModel.Producto_precio).toDouble(),
                                      idUsuario: 1
                                  );
                                  bool rpta =
                                  await createPedidoAumentar(
                                      pedido);

                                  if(!rpta){
                                    bool rpta= await createPedido(pedido);
                                  }

                                  setState(() {
                                    cantidadProducto++;
                                  });
                                },
                              )
                            ],
                          ),
                        ),

                      ),

                      Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child:Container(
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShoppingCartScreen(
                                          idUsuario: UsuarioModel.idUsuario,
                                        ),
                                      ));

                                },
                                color: GREENCART,
                                child: Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),
                                      child: Icon(Icons.shopping_cart,color: Colors.white,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),

                                      child: Text('Comprar ahora ',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                    )

                                  ],
                                )
                            ),
                          )

                      )
                    ],
                  );
                }

              }
          )
*/
            ],
          )


        ),
      ),


/*
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top:40.0,left: 200),
        child: Container(
            width: 350,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color:Color.fromRGBO(5, 175, 242, 1),
            ),
            //BUTTOM CARRITO

            child:Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child:Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    child: FutureBuilder<RegistroPedidoModel>(
                        future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                        builder:(context,snapshot2){
                          if(snapshot2.data != null){
                            print('hola');
                            return
                              ButtonAnimationWidget2(
                                idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                                cantidadAnimation: snapshot2.data.registropedido_cantidad,
                                precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                                    .toDouble(),
                                idUsuario: UsuarioModel.idUsuario,
                                changeSize: true,

                              );

                          }
                          else{
                            print('adios');
                            return   ButtonAnimationWidget(
                              idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                              cantidadAnimation: 0,
                              precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                                  .toDouble(),
                              idUsuario: UsuarioModel.idUsuario,
                              changeSize: true,
                            );
                          }
                        }
                    ),
                  ),
                ),


                /*
              Container(
                width: MediaQuery.of(context).size.width*0.4,
                child: FutureBuilder<RegistroPedidoModel>(
                    future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                    builder:(context,snapshot2){
                      if(snapshot2.data != null){
                        print('hola');
                        return
                          ButtonAnimationWidget2(
                            idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                            cantidadAnimation: snapshot2.data.registropedido_cantidad,
                            precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                                .toDouble(),
                            idUsuario: UsuarioModel.idUsuario,
                            changeSize: true,

                          );

                      }
                      else{
                        print('adios');
                        return   ButtonAnimationWidget(
                          idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                          cantidadAnimation: 0,
                          precio: (productoJOINCategoriaJOINImagenModel.Producto_precio)
                              .toDouble(),
                          idUsuario: UsuarioModel.idUsuario,
                          changeSize: true,
                        );
                      }
                    }
                ),
              ),
              */
                /*
              Padding(
                padding: EdgeInsets.only(left:1.0),
                child: Container(
                  height: 50.0,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        child:  Padding(
                          padding: EdgeInsets.only(left:1.0),
                          child: Container(
                            height: 50.0,
                            width: 50.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color:GREENCART)

                            ),
                            child: Icon(Icons.remove,size: 30.0,color: GREENCART,),
                          ),
                        ),
                        onTap: () async {

                          setState(() {
                            cantidadProducto=cantidadProducto-1;
                            //print('hola'+(cantidadProducto).toString());

                          });

                          if (cantidadProducto <
                              2) {
                            bool rpta =
                            await eliminarProducto(
                                1,
                                productoJOINCategoriaJOINImagenModel
                                    .idProducto);

                          } else {
                            PedidoModel pedido =
                            new PedidoModel(
                                idProducto: productoJOINCategoriaJOINImagenModel
                                    .idProducto,
                                cantidad: cantidad,
                                precio: (productoJOINCategoriaJOINImagenModel
                                    .Producto_precio)
                                    .toDouble(),
                                idUsuario: (UsuarioModel.idUsuario));

                            bool rpta =
                            await createPedidoDisminuir(
                                pedido);

                          }




                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10.0),
                        child: Container(
                            child:/* Center(
                                child:Text((snapshot2.data.registropedido_cantidad).toString(),style: TextStyle(fontSize: 30.0),)
                            )*/
                          FutureBuilder<RegistroPedidoModel>(
                                        future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                                        builder:(context,snapshot2){

                                          if(snapshot2.data !=null){
                                            cantidadProducto=snapshot2.data.registropedido_cantidad;
                                            return Text((cantidadProducto).toString(),style: TextStyle(fontSize: 30.0),);
                                           // return _cantidadProducto(snapshot2.data.registropedido_cantidad);
                                           // return Text(cantidadProducto.toString());
                                          }else{
                                            return Text('0',style: TextStyle(fontSize: 30.0),);
                                          }

                                        }
                                    )
/*

                          child: Center(
                            child: Text('1',style: TextStyle(fontSize: 30.0),),
                          )*/

                        ),
                      ),
                      GestureDetector(
                        child:Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child: Container(
                            height: 50.0,
                            width: 50.0,

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color:GREENCART)

                            ),
                            child: Icon(Icons.add,size: 30.0,color: GREENCART,),

                          ),



                        ),
                        onTap: () async {
                          setState(() {
                            cantidadProducto++;
                          });
                          PedidoModel pedido= new PedidoModel(
                              idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                              cantidad: cantidad,
                              precio: (productoJOINCategoriaJOINImagenModel.Producto_precio).toDouble(),
                              idUsuario: UsuarioModel.idUsuario
                          );
                          bool rpta =
                          await createPedidoAumentar(
                              pedido);
                          print((rpta).toString());

                          if(!rpta){
                            bool rpta= await createPedido(pedido);
                          }


                        },
                      )
                    ],
                  ),
                ),

              ),
              */
                Padding(
                    padding: EdgeInsets.only(left:10.0),
                    child:Container(
                      width: MediaQuery.of(context).size.width*0.4  ,
                      height: 50.0,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red)
                          ),
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShoppingCartScreen(
                                    idUsuario: UsuarioModel.idUsuario,
                                  ),
                                ));

                          },
                          //   color:Color.fromRGBO(5, 175, 242, 1),
                          color: Colors.amberAccent[400],
                          child: Row(
                            children: <Widget>[

                              /* Padding(
                              padding: EdgeInsets.only(left:0.0),
                              child: Icon(Icons.shopping_basket,color: Colors.white,size: 20,),
                            ),*/
                              Padding(
                                padding: EdgeInsets.only(left:10.0),

                                child: Text('Carrito ',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                              )

                            ],
                          )
                      ),
                    )

                ),


                /*FutureBuilder<RegistroPedidoModel>(
              future:fetchRegistroPedido(http.Client(),(UsuarioModel.idUsuario).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
              builder:(context,snapshot2){

                if(snapshot2.data !=null){
                  cantidadProducto=snapshot2.data.registropedido_cantidad;
                  return    Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left:1.0),
                        child: Container(
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child:  Padding(
                                  padding: EdgeInsets.only(left:1.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.remove,size: 30.0,color: GREENCART,),
                                  ),
                                ),
                                onTap: () async {

                                  setState(() {
                                    cantidadProducto=cantidadProducto-1;
                                    //print('hola'+(cantidadProducto).toString());

                                  });

                                  if (cantidadProducto <
                                      2) {
                                    bool rpta =
                                        await eliminarProducto(
                                        1,
                                        productoJOINCategoriaJOINImagenModel
                                            .idProducto);

                                  } else {
                                    PedidoModel pedido =
                                    new PedidoModel(
                                        idProducto: productoJOINCategoriaJOINImagenModel
                                            .idProducto,
                                        cantidad: cantidad,
                                        precio: (productoJOINCategoriaJOINImagenModel
                                            .Producto_precio)
                                            .toDouble(),
                                        idUsuario: (UsuarioModel.idUsuario));

                                    bool rpta =
                                        await createPedidoDisminuir(
                                        pedido);

                                  }




                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:10.0),
                                child: Container(
                                    child: Center(
                                      child:Text((snapshot2.data.registropedido_cantidad).toString(),style: TextStyle(fontSize: 30.0),)
                                    )
                                    /*FutureBuilder<RegistroPedidoModel>(
                                        future:fetchRegistroPedido(http.Client(),(1).toString(),(productoJOINCategoriaJOINImagenModel.idProducto).toString()),
                                        builder:(context,snapshot2){

                                          if(snapshot2.data !=null){
                                            cantidadProducto=snapshot2.data.registropedido_cantidad;
                                            return Text((cantidadProducto).toString(),style: TextStyle(fontSize: 30.0),);
                                          }else{
                                            return Text('0',style: TextStyle(fontSize: 30.0),);
                                          }

                                        }
                                    )*/
/*

                          child: Center(
                            child: Text('1',style: TextStyle(fontSize: 30.0),),
                          )*/

                                ),
                              ),
                              GestureDetector(
                                child:Padding(
                                  padding: EdgeInsets.only(left:10.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.add,size: 30.0,color: GREENCART,),

                                  ),



                                ),
                                onTap: () async {
                                  setState(() {
                                    cantidadProducto++;
                                  });
                                  PedidoModel pedido= new PedidoModel(
                                      idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                                      cantidad: cantidad,
                                      precio: (productoJOINCategoriaJOINImagenModel.Producto_precio).toDouble(),
                                      idUsuario: UsuarioModel.idUsuario
                                  );
                                  bool rpta =
                                  await createPedidoAumentar(
                                      pedido);
                                  print((rpta).toString());

                                  if(!rpta){
                                    bool rpta= await createPedido(pedido);
                                  }


                                },
                              )
                            ],
                          ),
                        ),

                      ),

                      Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child:Container(
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShoppingCartScreen(
                                          idUsuario: UsuarioModel.idUsuario,
                                        ),
                                      ));

                                },
                                color: GREENCART,
                                child: Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),
                                      child: Icon(Icons.shopping_cart,color: Colors.white,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),

                                      child: Text('Comprar ahora ',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                    )

                                  ],
                                )
                            ),
                          )

                      )
                    ],
                  );
                }else{
                  cantidadProducto=0;
                  return    Row(
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(left:1.0),
                        child: Container(
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              GestureDetector(
                                child:  Padding(
                                  padding: EdgeInsets.only(left:1.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.remove,size: 30.0,color: GREENCART,),
                                  ),
                                ),
                                onTap: (){

                                  setState(() {
                                    cantidadProducto--;
                                  });


                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:10.0),
                                child: Container(
                                    child:Text((snapshot2.data.registropedido_cantidad).toString(),style: TextStyle(fontSize: 30.0),),


/*
                          child: Center(
                            child: Text('1',style: TextStyle(fontSize: 30.0),),
                          )*/

                                ),
                              ),
                              GestureDetector(
                                child:Padding(
                                  padding: EdgeInsets.only(left:10.0),
                                  child: Container(
                                    height: 50.0,
                                    width: 50.0,

                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color:GREENCART)

                                    ),
                                    child: Icon(Icons.add,size: 30.0,color: GREENCART,),

                                  ),



                                ),
                                onTap: () async {

                                  PedidoModel pedido= new PedidoModel(
                                      idProducto: productoJOINCategoriaJOINImagenModel.idProducto,
                                      cantidad: cantidad,
                                      precio: (productoJOINCategoriaJOINImagenModel.Producto_precio).toDouble(),
                                      idUsuario: 1
                                  );
                                  bool rpta =
                                  await createPedidoAumentar(
                                      pedido);

                                  if(!rpta){
                                    bool rpta= await createPedido(pedido);
                                  }

                                  setState(() {
                                    cantidadProducto++;
                                  });
                                },
                              )
                            ],
                          ),
                        ),

                      ),

                      Padding(
                          padding: EdgeInsets.only(left:10.0),
                          child:Container(
                            height: 50.0,
                            child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShoppingCartScreen(
                                          idUsuario: UsuarioModel.idUsuario,
                                        ),
                                      ));

                                },
                                color: GREENCART,
                                child: Row(
                                  children: <Widget>[

                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),
                                      child: Icon(Icons.shopping_cart,color: Colors.white,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:1.0),

                                      child: Text('Comprar ahora ',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                    )

                                  ],
                                )
                            ),
                          )

                      )
                    ],
                  );
                }

              }
          )
*/
              ],
            )


        ),
      ),
*/



    );
  }


  Widget _cantidadTotal2(){

    if(amountProduct>0){

      return Text(
        '+' +
            (amountProduct).toString(),
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


