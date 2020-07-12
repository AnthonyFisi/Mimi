import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/CarritoApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/CarritoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';
import 'ScheduleScreen.dart';

class ShoppingCartScreen extends StatefulWidget {
  final int idUsuario;

  const ShoppingCartScreen({Key key, this.idUsuario}) : super(key: key);

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState(idUsuario);
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final int idUsuario;
  double total = 0;
  bool changeState=false;
  ScrollController controller = ScrollController();

  _ShoppingCartScreenState(this.idUsuario);

  @override
  Widget build(BuildContext context) {
    print('amount inicial ' + amountProduct.toString());
    final media = MediaQuery.of(context);
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: Color.fromRGBO(5, 175, 242, 1),
            ),
            onPressed: (){
              Navigator.of(context).pop();

            }
        ),
        title: Container(
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width*0.7,
          child: Text(' Carrito de compra',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        actions: <Widget>[
         /* Padding(
            padding: EdgeInsets.only(
              right: 20.0,
            ),
            child:  Icon(
              Icons.shopping_basket,
              size: 25,
              color: Colors.black38,
            ),
          )*/
        ],

      ),


      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: amountProduct > 0 ?  Padding(
              padding: EdgeInsets.only(top:0.0),
              child: Container(
                width: 360,
                child:  Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        //color:Colors.deepOrange,
                          height: 50.0,
                          child: Row(
                            children: <Widget>[
                              /* Padding(
                                  padding: const EdgeInsets.only(right:260.0),
                                  child: Text('direccion ',style: TextStyle(fontSize: 12.0,color: RED),),
                                ),*/
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'ENVIAR A ',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              FutureBuilder<UbicacionModel>(
                                future: showUbicacionActual(http.Client(),
                                    (UsuarioModel.idUsuario).toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
                                      height: 40,
                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            child: Text(
                                              snapshot.data.ubicacion_nombre,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );

                                    /* Padding(
                                  padding: const EdgeInsets.only(left:20.0),
                                  child: Text(
                                      (snapshot.data.ubicacion_nombre).toString(),
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.black,fontWeight: FontWeight.bold)
                                  ),
                                );*/
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 1.0),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 18.0,
                                    color: Colors.black54,
                                  )),
                              /*
                                Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                    //media.size.width*0.18
                                    media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.05 :MediaQuery.of(context).size.width * 0.2,

                                  ),
                                  child: Container(
                                    height: 20.0,
                                    width: 55.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border:Border.all(color: Colors.black,width: 0.5),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.timer,size: 12.0,),
                                        Text('60 min',style: TextStyle(fontSize: 12.0),)
                                      ],
                                    ),
                                  ),
                                )
                                */
                            ],
                          )),
                    ),
                    Container(
                      height: 30.0,
                      //  color: Colors.lightGreenAccent,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Text('DESDE',
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 0.0),
                            child: Text('PARADERO 8 - NUEVA ESPERANZA',
                                style: TextStyle(
                                    fontSize: 10.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ),
                          /*
                            Padding(
                                padding:EdgeInsets.only(
                                  left:
                                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.15 :MediaQuery.of(context).size.width * 0.5,

                                ),
                                child:Text('('+amountProduct.toString()+' productos '+')',style: TextStyle(fontSize: 10.0,color: RED,fontWeight: FontWeight.bold))
                            )*/
                        ],
                      ),
                    ),
                    Container(
                      height: 30.0,
                      //color: Colors.yellowAccent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 0.0,
                              //media.size.width*0.18
                              // media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.05 :MediaQuery.of(context).size.width * 0.2,
                            ),
                            child: Container(
                              height: 20.0,
                              width: 55.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                border:
                                Border.all(color: Colors.black, width: 0.5),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    size: 12.0,
                                  ),
                                  Text(
                                    '60 min',
                                    style: TextStyle(fontSize: 12.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                left: 5.0,
                                //media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.15 :MediaQuery.of(context).size.width * 0.5,
                              ),
                              child: Text(
                                  '(' +
                                      amountProduct.toString() +
                                      ' productos ' +
                                      ')',
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))),
                          GestureDetector(
                            onTap: () async {
                              bool rpta = await eliminarCarritoModel(idPedido);
                              print('repuesta de eliminado' + rpta.toString());
                              setState(() {
                                changeState=true;
                                cantidadProductos = 0;
                                cantTotal = 0;
                                amountProduct = 0;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, left: 10.0),
                              child: Text('Eliminar carrito',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ): Container()
          ),


          SliverToBoxAdapter(
            child: Container(
              height: //400,

              media.orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.54
                  : MediaQuery.of(context).size.height * 0.7,

              //color: Colors.red,
              child: FutureBuilder<List<CarritoModel>>(
                future:
                fetchCarritoModel(http.Client(), (idUsuario).toString()),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    if (snapshot.data.length > 0) {
                      return DraggableScrollbar(
                        controller: controller,
                        child: ListView.builder(
                          controller: controller,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 1.0, right: 5.0, bottom: 5.0),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:3.0),
                                          child: Image.network(
                                            snapshot.data[index]
                                                .producto_uri_imagen,
                                            height: //60.0,
                                            media.orientation ==
                                                Orientation.portrait
                                                ? MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.08
                                                : MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.25,
                                            width: //60.0,
                                            media.orientation ==
                                                Orientation.portrait
                                                ? MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.13
                                                : MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.2,
                                            fit: BoxFit.fill,
                                          ),
                                        ),

                                      ),
                                      Container(
                                        width: //media.size.width*0.5, //120,
                                        media.orientation ==
                                            Orientation.portrait
                                            ? MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.5
                                            : MediaQuery.of(context)
                                            .size
                                            .width *
                                            0.5,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                              const EdgeInsets.all(1.0),
                                              child: Text(
                                                snapshot.data[index]
                                                    .producto_nombre + ' '+ snapshot
                                                    .data[index].producto_marca,
                                                style:
                                                TextStyle(fontSize: 12.0),
                                              ),
                                            ),


                                            Padding(
                                              padding:
                                              const EdgeInsets.all(1.0),
                                              child: Text(snapshot.data[index]
                                                  .producto_detalle + ' '+ snapshot.data[index]
                                                  .producto_envase +
                                                  " " +
                                                  snapshot.data[index]
                                                      .producto_cantidad, style:
                                              TextStyle(fontSize: 12.0),),
                                            ),

                                          ],
                                        ),
                                      ),
                                      /*
                                      Container(
                                          width: 48,
                                          height: 60,
                                          child: Center(
                                            child: Text('S/.'+
                                                ( snapshot.data[index]
                                                    .registropedido_preciototal)
                                                    .toStringAsFixed(1)),
                                          )
                                      ),
                                      */
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0.0),
                                        child: Container(
                                            width: 110.0,
                                         //   color:Colors.amberAccent,
                                            child:Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(top:0.0),
                                                  child:Container(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 1.0),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          bool rpta =
                                                          await eliminarProducto(
                                                              UsuarioModel.idUsuario,
                                                              snapshot.data[index]
                                                                  .idProducto);
                                                          print((rpta).toString());
                                                          setState(() {
                                                            snapshot.data.removeAt(index);
                                                            cantidadProductos -= snapshot
                                                                .data[index]
                                                                .registropedido_cantidad;
                                                          });
                                                        },
                                                        child:Text('S/.'+
                                                            ( snapshot.data[index]
                                                                .registropedido_preciototal)
                                                                .toStringAsFixed(1)),
                                                        /*Icon(
                                                          Icons.delete_outline,
                                                          size: media.size.width *
                                                              0.06, //20.0,
                                                          // media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.55 :MediaQuery.of(context).size.height * 0.7,

                                                          color: Colors.grey,
                                                        ),*/
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Padding(
                                                  padding: EdgeInsets.only(top:1.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      IconButton(
                                                        icon: Container(
                                                          decoration:
                                                          new BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                            border: Border.all(
                                                                color:
                                                                Colors.black38,
                                                                width: 1.5),
                                                          ),
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.black38,
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          // print((snapshot.data[index].registropedido_cantidad).toString());

                                                          if (snapshot.data[index]
                                                              .registropedido_cantidad <
                                                              2) {
                                                            bool rpta =
                                                            await eliminarProducto(
                                                                idUsuario,
                                                                snapshot
                                                                    .data[index]
                                                                    .idProducto);
                                                            snapshot.data
                                                                .removeAt(index);
                                                          } else {
                                                            PedidoModel pedido =
                                                            new PedidoModel(
                                                                idProducto: snapshot
                                                                    .data[index]
                                                                    .idProducto,
                                                                cantidad: 1,
                                                                precio: (snapshot
                                                                    .data[
                                                                index]
                                                                    .Producto_precio)
                                                                    .toDouble(),
                                                                idUsuario:
                                                                idUsuario);

                                                            bool rpta =
                                                            await createPedidoDisminuir(
                                                                pedido);
                                                            //   print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());
                                                            print((snapshot
                                                                .data[index]
                                                                .registropedido_cantidad)
                                                                .toString());
                                                          }

                                                          setState(() {
                                                            cantidadProductos -= 1;
                                                            print('antes ' +
                                                                amountProduct
                                                                    .toString());
                                                            amountProduct -= 1;
                                                            print('despues ' +
                                                                amountProduct
                                                                    .toString());
                                                          });
                                                        },
                                                      ),
                                                      Container(
                                                        child: Padding(
                                                            padding:
                                                            const EdgeInsets.only(
                                                                left: 1.0),
                                                            child: Text((snapshot
                                                                .data[index]
                                                                .registropedido_cantidad)
                                                                .toString())),
                                                      ),
                                                      IconButton(
                                                        icon: Container(
                                                          decoration:
                                                          new BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                            border: Border.all(
                                                                color:
                                                                Colors.black38,
                                                                width: 1.5),
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.black38,
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          print((snapshot
                                                              .data[index]
                                                              .registropedido_cantidad)
                                                              .toString());
                                                          PedidoModel pedido =
                                                          new PedidoModel(
                                                              idProducto: snapshot
                                                                  .data[index]
                                                                  .idProducto,
                                                              cantidad: 1,
                                                              precio: (snapshot
                                                                  .data[
                                                              index]
                                                                  .Producto_precio)
                                                                  .toDouble(),
                                                              idUsuario:
                                                              idUsuario);

                                                          bool rpta =
                                                          await createPedidoAumentar(
                                                              pedido);
                                                          print((rpta).toString() +
                                                              " - " +
                                                              (pedido.idUsuario)
                                                                  .toString() +
                                                              " -  " +
                                                              (pedido.idProducto)
                                                                  .toString());
                                                          print((snapshot
                                                              .data[index]
                                                              .registropedido_cantidad)
                                                              .toString());

                                                          setState(() {
                                                            cantidadProductos += 1;
                                                            print('antes ' +
                                                                amountProduct
                                                                    .toString());
                                                            amountProduct += 1;
                                                            print('despues ' +
                                                                amountProduct
                                                                    .toString());
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        heightScrollThumb: 48.0,
                        backgroundColor: Colors.black54,
                        scrollThumbBuilder: (
                            Color backgroundColor,
                            Animation<double> thumbAnimation,
                            Animation<double> labelAnimation,
                            double height, {
                              Text labelText,
                              BoxConstraints labelConstraints,
                            }) {
                          return FadeTransition(
                            opacity: thumbAnimation,
                            child: Container(
                              height: height,
                              width: 10.0,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: backgroundColor,
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Container(
                        height: 500.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            mainAxisAlignment:MainAxisAlignment.center,
                            children: <Widget>[
                              //Image.asset('assets/carro.png',height: 50.0,width: 50.0,),
                              Icon(
                                Icons.shopping_basket,
                                color: Color.fromRGBO(5, 175, 242, 0.4),
                                size: 100,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Carrito de compra vacio',
                                    style: TextStyle(
                                        color: Colors.black38, fontSize: 20,fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child:Container(
                                    alignment: AlignmentDirectional.center,
                                    child:  Text('Deberias hacer feliz a tu canasta ',
                                        style: TextStyle(
                                            color: Colors.amberAccent[400], fontSize: 15,fontWeight: FontWeight.bold)),
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child:Container(
                                    alignment: AlignmentDirectional.center,
                                    child:  Text('y añadir produtos',
                                        style: TextStyle(
                                            color: Colors.amberAccent[400], fontSize: 15,fontWeight: FontWeight.bold)),
                                  )
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ListView.builder(
                            controller: controller,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Skeleton(
                                  type: 'boxListShoppingCart',
                                ),
                              );
                            }));
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationNext(media),
    );
  }

  Widget _bottomNavigationNext(MediaQueryData media) {
    if (amountProduct > 0) {
      return Container(
        height: media.orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.12
            : MediaQuery.of(context).size.height * 0.18,

        //color: Colors.orangeAccent,
        child: Row(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(left: media.size.width * 0.07, bottom: 10.0),
              child: Container(
                  height: 60.0,
                  width: // 100.0,
                      media.orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.width * 0.25
                          : MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Color.fromRGBO(5, 175, 242, 1),),
                    color: Colors.white,
                  ),
                  child: FutureBuilder<PedidoRealModel>(
                      future: fetchPedidoReal(
                          http.Client(), (UsuarioModel.idUsuario).toString()),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          if (snapshot.data.pedido_estado != 'Atendido') {
                            // UsuarioModel.cantidadTotal=snapshot.data.pedido_cantidadtotal;
                            return Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                  child: Text(
                                    'S/. ' +
                                        (snapshot.data.pedido_montototal)
                                            .toStringAsFixed(1),
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ));
                          } else {
                            return Container();
                          }
                        } else {
                          return Container();
                        }
                      })),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: Container(
                  height: 60.0,
                  width: media.size.width * 0.6,
                  //  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.width * 0.6 :MediaQuery.of(context).size.width * 0.6,

                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/ScheduleScreen');
                    },
                    color: Color.fromRGBO(5, 175, 242, 1),
                   // color:Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                        side: BorderSide(color: Color.fromRGBO(5, 175, 242, 1),)

                    ),

                    child: Container(
                        width: 180.0,
                        child: Center(
                          child: Text(
                            'Siguiente',
                            style:
                                TextStyle(color:Colors.white /*Color.fromRGBO(5, 175, 242, 1)*/, fontSize: 25.0),
                          ),
                        )),
                  )),
            )
          ],
        ),
      );
    }
  }
}

