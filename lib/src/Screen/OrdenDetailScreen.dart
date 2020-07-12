import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tienda_mimi/Service/Api/CarritoApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Model/ListaPedidoModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/appBarWidgetSubCategorieList.dart';


class OrdenDetailScreen extends StatefulWidget {

 final  ListaPedidoModel listaPedidoModel;

  const OrdenDetailScreen({Key key, this.listaPedidoModel}) : super(key: key);


  @override
  _OrdenDetailScreenState createState() => _OrdenDetailScreenState(listaPedidoModel);
}

class _OrdenDetailScreenState extends State<OrdenDetailScreen> {
  final  ListaPedidoModel listaPedidoModel;

  _OrdenDetailScreenState(this.listaPedidoModel);


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: CustomScrollView(
        slivers: <Widget>[

        // SliverToBoxAdapter(child: appSliverBarWidgetSubCategorieList(context, '')),


          SliverToBoxAdapter(
            child: Container(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[

                  Container(
                    height: 400.0,
                    color: Colors.black12,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                        ),
                        Positioned(
                          left:MediaQuery.of(context).size.width*0.82,
                          top:25,
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: ClipOval(
                              child: Container(
                                height: 50.0,
                                width: 50.0,
                                color:Colors.white,
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black54,

                                ),
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),

                 Padding(
                   padding: EdgeInsets.only(top:10,left:10),
                   child:  Container(
                     child: Row(
                       children: <Widget>[
                         Container(
                           width: MediaQuery.of(context).size.width*0.45,
                           child: Text('Orden id #185748'),
                         ),
                         Padding(
                           padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.25),
                           child:
                           Container(
                             height: MediaQuery.of(context).size.height * 0.04,
                             width:MediaQuery.of(context).size.height * 0.04,
                             decoration: BoxDecoration(
                                 image:DecorationImage(
                                   image: AssetImage('assets/succes.png'),
                                 )
                             ),
                             /* child: Column(
                              children: <Widget>[

                                Padding(
                                    padding: EdgeInsets.only(top:0.0),
                                    child:Image.asset(
                                      'assets/succes.png',
                                      height: 20,
                                      width: 20,
                                      fit: BoxFit.cover,
                                    )
                                )
                              ],
                            ),*/
                             //color: Colors.purpleAccent,
                           ),
                         ),
                         Text('Delivery'),

                       ],
                     ),
                   ),
                 ),
                  Padding(
                    padding: EdgeInsets.only(right: 180),
                    child: Container(
                      //color: Colors.purpleAccent,
                      width: MediaQuery.of(context).size.width*0.45,
                      child: fecheEntrega(listaPedidoModel.venta_fechaentrega, listaPedidoModel.horario_nombre),
                    ),
                  ),



                  Container(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:280.0,top:10),
                          child: Text('Delivery a '),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right:60.0),
                          child: Text(listaPedidoModel.ubicacion_nombre,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
                        ),
                      ],
                    ),
                  ),
                  /*
                  Padding(
                    padding: const EdgeInsets.only(right:180.0,top:10),
                    child: Text(listaPedidoModel.venta_fechaentrega),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:250.0,top:10),
                    child: Text('Ubicacion'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left:25.0),
                    child: Text(listaPedidoModel.ubicacion_nombre,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
                  ),*/

                  Padding(
                    padding: const EdgeInsets.only(right:10),
                    child:Row(
                      children: <Widget>[
                        Container(
                          // color: Colors.lightGreen,
                          width: 200.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:80.0,top:0),
                                child: Text('Medio de pago',),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:140.0),
                                child: Text(listaPedidoModel.tipopago_nombre,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
                              ),
                            ],
                          ),
                        ),
                        /*Container(
                          //color: Colors.purpleAccent,
                          width: 90.0,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:0.0,top:0),
                                child: Text('Total',),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:0.0),
                                child: Text('S/. '+(listaPedidoModel.venta_costototal).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0)),
                              ),
                            ],
                          ),
                        ),*/

                      ],
                    ),

                  ),


                  Padding(
                    padding: const EdgeInsets.only(top:10.0,left:10,right: 10),
                    child: Container(
                      child:Divider(
                        height: 1.0,
                        color: Colors.black26,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:10),
                    child:     Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: AlignmentDirectional.topStart,
                      color:Colors.blue,
                      child:Padding(
                        padding: EdgeInsets.only(left:10),
                        child:  Text('PRODUCTOS',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                      ),
                    )
                  ),

                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
          child: FutureBuilder(
            future:  fetchPedidoRealizado(http.Client(),(listaPedidoModel.idpedido).toString()),
            builder: (context,snapshot){

              if(snapshot.data != null){
                return Container(
                  height: 180.0,
                  //color: Colors.orangeAccent,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            child: Row(
                              children: <Widget>[

                                Container(
                                  //color:Colors.blue,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Image.network(
                                          snapshot
                                              .data[index].producto_uri_imagen,
                                          height: 30.0,
                                          width: 30.0,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(1.0),
                                          child: Text(
                                            snapshot
                                                .data[index].producto_nombre,
                                            style: TextStyle(fontSize: 12.0,color: Colors.black38),
                                          ),
                                        ),
                                        Text(snapshot
                                            .data[index].producto_marca+' '+snapshot
                                            .data[index].producto_detalle,
                                          style: TextStyle(fontSize: 12.0,color: Colors.black38),
                                        ),
                                        /*
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(1.0),
                                                                                  child: Text(snapshot
                                                                                      .data[index].producto_detalle,
                                                                                    style: TextStyle(fontSize: 12.0),
                                                                                  ),
                                                                                ),

                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(1.0),
                                                                                  child: Text(snapshot
                                                                                      .data[index].producto_envase +
                                                                                      " " +
                                                                                      snapshot.data[index]
                                                                                          .producto_cantidad,
                                                                                    style: TextStyle(fontSize: 12.0),
                                                                                  ),
                                                                                ),
                                                                                */


                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  width: 25,
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[

                                      Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Text(' x'+
                                            (snapshot.data[index].registropedido_cantidad)
                                                .toString()
                                            ,style: TextStyle(color: Colors.black38)
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.2),
                                  child: Container(
                                    // color:Colors.amber,
                                    width: 50,
                                    child: Center(
                                      child: Column(
                                        children: <Widget>[

                                          Padding(
                                            padding: const EdgeInsets.all(1.0),
                                            child: Text('S/. '+
                                                (snapshot.data[index]
                                                    .registropedido_preciototal)
                                                    .toString()
                                                ,style: TextStyle(color: Colors.black38)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )

                              ],

                            ),
                          ),
                        );
                      }
                  ),
                );

              }
              else{
                return Container(
                  height: 100.0,
                  color: Colors.white,

                );

              }
              /*
                    if(snapshot.data != null){
                      return Container(
                        height: 180.0,
                        //color: Colors.orangeAccent,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[

                                      Container(
                                        //color:Colors.blue,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Image.network(
                                                snapshot
                                                    .data[index].producto_uri_imagen,
                                                height: 40.0,
                                                width: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // color:Colors.amber,
                                        width: 180,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(
                                                  snapshot
                                                      .data[index].producto_nombre,
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              ),
                                              Text(snapshot
                                                  .data[index].producto_marca,
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(snapshot
                                                    .data[index].producto_detalle,
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(snapshot
                                                    .data[index].producto_envase +
                                                    " " +
                                                    snapshot.data[index]
                                                        .producto_cantidad,
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),
                                      ),

                                      Container(
                                        // color:Colors.amber,
                                        width: 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[

                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(
                                                    (snapshot.data[index].registropedido_cantidad)
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color:Colors.amber,
                                        width: 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[

                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text('S/. '+
                                                    (snapshot.data[index]
                                                        .registropedido_preciototal)
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],

                                  ),
                                ),
                              );
                            }
                        ),
                      );

                    }else{
                      return Container(
                        height: 100.0,
                        color: Colors.purpleAccent,

                      );}
                    */
            },
          ),
          ),
/*
          SliverToBoxAdapter(
            child: ExpansionTile(
              title: Text('Productos '),
             // subtitle: Text('cntidad : '+ cantidadProductos.toString()),
             // trailing: Icon(Icons.arrow_back_ios,textDirection:TextDirection.rtl ,),
              children: <Widget>[
                FutureBuilder(
                  future:  fetchPedidoRealizado(http.Client(),(listaPedidoModel.idpedido).toString()),
                  builder: (context,snapshot){

                    if(snapshot.data != null){
                      return Container(
                        height: 180.0,
                        //color: Colors.orangeAccent,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[

                                      Container(
                                        //color:Colors.blue,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Image.network(
                                                snapshot
                                                    .data[index].producto_uri_imagen,
                                                height: 30.0,
                                                width: 30.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(
                                                  snapshot
                                                      .data[index].producto_nombre,
                                                  style: TextStyle(fontSize: 12.0,color: Colors.black38),
                                                ),
                                              ),
                                              Text(snapshot
                                                  .data[index].producto_marca+' '+snapshot
                                                  .data[index].producto_detalle,
                                                style: TextStyle(fontSize: 12.0,color: Colors.black38),
                                              ),
                                              /*
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(1.0),
                                                                                  child: Text(snapshot
                                                                                      .data[index].producto_detalle,
                                                                                    style: TextStyle(fontSize: 12.0),
                                                                                  ),
                                                                                ),

                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(1.0),
                                                                                  child: Text(snapshot
                                                                                      .data[index].producto_envase +
                                                                                      " " +
                                                                                      snapshot.data[index]
                                                                                          .producto_cantidad,
                                                                                    style: TextStyle(fontSize: 12.0),
                                                                                  ),
                                                                                ),
                                                                                */


                                            ],
                                          ),
                                        ),
                                      ),

                                      Container(
                                        width: 25,
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[

                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Text(' x'+
                                                  (snapshot.data[index].registropedido_cantidad)
                                                      .toString()
                                                  ,style: TextStyle(color: Colors.black38)
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.2),
                                        child: Container(
                                          // color:Colors.amber,
                                          width: 50,
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[

                                                Padding(
                                                  padding: const EdgeInsets.all(1.0),
                                                  child: Text('S/. '+
                                                      (snapshot.data[index]
                                                          .registropedido_preciototal)
                                                          .toString()
                                                      ,style: TextStyle(color: Colors.black38)
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )

                                    ],

                                  ),
                                ),
                              );
                            }
                        ),
                      );

                    }
                    else{
                      return Container(
                        height: 100.0,
                        color: Colors.white,

                      );

                    }
                    /*
                    if(snapshot.data != null){
                      return Container(
                        height: 180.0,
                        //color: Colors.orangeAccent,
                        child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  child: Row(
                                    children: <Widget>[

                                      Container(
                                        //color:Colors.blue,
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(1.0),
                                              child: Image.network(
                                                snapshot
                                                    .data[index].producto_uri_imagen,
                                                height: 40.0,
                                                width: 40.0,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // color:Colors.amber,
                                        width: 180,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(
                                                  snapshot
                                                      .data[index].producto_nombre,
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              ),
                                              Text(snapshot
                                                  .data[index].producto_marca,
                                                style: TextStyle(fontSize: 12.0),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(snapshot
                                                    .data[index].producto_detalle,
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(snapshot
                                                    .data[index].producto_envase +
                                                    " " +
                                                    snapshot.data[index]
                                                        .producto_cantidad,
                                                  style: TextStyle(fontSize: 12.0),
                                                ),
                                              ),



                                            ],
                                          ),
                                        ),
                                      ),

                                      Container(
                                        // color:Colors.amber,
                                        width: 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[

                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text(
                                                    (snapshot.data[index].registropedido_cantidad)
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // color:Colors.amber,
                                        width: 50,
                                        child: Center(
                                          child: Column(
                                            children: <Widget>[

                                              Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Text('S/. '+
                                                    (snapshot.data[index]
                                                        .registropedido_preciototal)
                                                        .toString()),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],

                                  ),
                                ),
                              );
                            }
                        ),
                      );

                    }else{
                      return Container(
                        height: 100.0,
                        color: Colors.purpleAccent,

                      );}
                    */
                  },
                ),

              ],
            )

          ),
          */





          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left:10.0,right: 10.0),
              child: Container(
                child: Divider(
                  height: 1.0,
                  color: Colors.black26,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top:20),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width*0.6,
                      alignment: AlignmentDirectional.topStart,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,),
                            child: Text('Total productos',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,),
                            child: Text('Costo delivery',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:10.0,top:5.0),
                            child: Text('Total',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      // color: Colors.orangeAccent,
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[



                          FutureBuilder<PedidoRealModel>(
                              future: fetchPedidoReal(http.Client(),(UsuarioModel.idUsuario).toString()),
                              builder: (context,snapshot){
                                if (snapshot.data != null) {
                                  //costoTotal=snapshot.data.pedido_montototal+5;

                                  return  Padding(
                                    padding: const EdgeInsets.only(left:1.0,),
                                    child: Text(listaPedidoModel.venta_costototal.toStringAsFixed(1),style: TextStyle(fontSize: 15.0,color: Colors.black),),
                                  );
                                }else{
                                  return  Padding(
                                    padding: const EdgeInsets.only(left:1.0,),
                                    child: Text('0',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                                  );
                                }
                              }
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0,),
                            child: Text(listaPedidoModel.venta_costodelivery+'.0',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0,top:5.0),
                            child: Text((listaPedidoModel.venta_costototal+
                                double.parse(listaPedidoModel.venta_costodelivery)
                            ).toStringAsFixed(1),style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
          /*
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top:10.0,right: 20.0,left: 20.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 1.0,
                      color: Colors.black26,
                    ),


                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right:150.0,top:10.0),
                          child: Text('SubTotal'),
                        ),

                        Padding(
                            padding: EdgeInsets.only(left:10),
                          child: Text('S/. '+(listaPedidoModel.venta_costototal).toString()),
                        )

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:10.0,right:10.0,top:20.0),
                      child: RaisedButton(
                        onPressed: () async {

                        },
                        color: GREENCART,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Re Ordenar',
                              style: TextStyle(
                                  color: Colors.white,
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
*/


          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left:10.0,right: 10.0),
              child: Container(
                child: Divider(
                  height: 1.0,
                  color: Colors.black26,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 80,
              child: ListTile(
                leading: Container(
                  height:35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.purpleAccent,

                  ),
                  child: Icon(Icons.help,color: Colors.amberAccent[400],),
                ),
                title: Text('Necesitas soporte ?',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                subtitle: Text('Chatea con nuestros colaboradores',style: TextStyle(fontSize: 10.0,color: Colors.black),),
                trailing: Text('Chat',style: TextStyle(fontSize: 20.0,color: Colors.black,fontWeight: FontWeight.bold),),
              )
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left:10,right: 10),
              child: Container(
                height: 50,
                child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    child: Text('Re-Ordenar',style: TextStyle(fontSize: 20.0,color: Colors.white,fontWeight: FontWeight.bold),),
                    onPressed: (){}

                )
              ),
            ),
          ),
SliverToBoxAdapter(
  child: Container(
    height: 10.0,
  ),
)

/*
          SliverToBoxAdapter(
            child: Container(
              //height: 200,
              //color: Colors.lightGreen,
              child:  Padding(
                padding: EdgeInsets.only(bottom:0),
                child: Center(
                  child: QrImage(
                    data: 'idPedido : '+(listaPedidoModel.idpedido).toString()+
                        'fecha : ' +listaPedidoModel.horario_nombre+
                        'costoTotal : ' + listaPedidoModel.venta_costototal.toString()+
                        'ubicacion  : ' + listaPedidoModel.ubicacion_nombre,
                    size: 150,
                  ),
                )
              )
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              child: Center(
                child: Text('Mostrar codigo QR para confirmar entrega',style:TextStyle(color: Colors.lightBlueAccent,fontWeight: FontWeight.bold)),
              ),
            ),
          )
*/
        ],
      ),

    );
  }

  Widget fecheEntrega(String fecha,String horario){
    if(DateTime.now().toString().substring(0,10)==fecha.substring(0,10)){
      return Text(
        'Hoy , '+ horario,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
      );
    }else{
      if(DateTime.now().add(new Duration(days: 1)).toString().substring(0,10) == fecha.substring(0,10)){
        return Text(
          'Mañana , '+horario,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        );
      }else{
        return Text(
          fecha.substring(0,10)+' , '+horario,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        );
      }
    }

  }
}
