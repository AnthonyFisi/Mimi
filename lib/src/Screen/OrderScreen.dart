import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tienda_mimi/Service/Api/CarritoApi.dart';
import 'package:tienda_mimi/Service/Api/ListaPedidoApi.dart';
import 'package:tienda_mimi/Service/Model/ListaPedidoModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/OrdenDetailScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:http/http.dart' as http;

import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';

class OrderScreen extends StatefulWidget {
  final int idUsuario;

  const OrderScreen({Key key, this.idUsuario}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var _curIndex = 0;
  var contents = "Home";
  int residuo=0;

  Widget _indexBottom() => Container(
    height: 50.0,
    color: Colors.yellow,
    child: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 20,
            color: TEXT_BLACK_LIGHT,
          ),
          title: Text(
            "Inicio",
            style: TextStyle(
                fontSize: 10,
                color: _curIndex == 0 ? RED : TEXT_BLACK_LIGHT),
          ),
          activeIcon: Icon(
            Icons.home,
            size: 20,
            color: RED,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.place,
            size: 20,
            color: TEXT_BLACK_LIGHT,
          ),
          title: Text(
            "Ubicacion",
            style: TextStyle(
                fontSize: 10,
                color: _curIndex == 1 ? RED : TEXT_BLACK_LIGHT),
          ),
          activeIcon: Icon(
            Icons.place,
            size: 20,
            color: RED,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            size: 20,
            color: TEXT_BLACK_LIGHT,
          ),
          title: Text(
            "Carrito",
            style: TextStyle(
                fontSize: 10,
                color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
          ),
          activeIcon: Icon(
            Icons.shopping_cart,
            size: 20,
            color: RED,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.favorite_border,
            size: 20,
            color: TEXT_BLACK_LIGHT,
          ),
          title: Text(
            "Favoritos",
            style: TextStyle(
                fontSize: 10,
                color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
          ),
          activeIcon: Icon(
            Icons.favorite_border,
            size: 20,
            color: RED,
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.library_books,
            size: 20,
            color: TEXT_BLACK_LIGHT,
          ),
          title: Text(
            "Orden",
            style: TextStyle(
                fontSize: 10,
                color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
          ),
          activeIcon: Icon(
            Icons.library_books,
            size: 20,
            color: RED,
          ),
        )
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: _curIndex,
      onTap: (index) {
        setState(() {
          _curIndex = index;
          switch (_curIndex) {
            case 0:
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
              break;
            case 1:
              contents = "Ubicacion";
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(
                    idUsuario: UsuarioModel.idUsuario,
                  ),
                ),
              );
              break;
            case 3:
              break;
            case 4:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(),
                ),
              );
              break;
          }
        });
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading:  GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Color.fromRGBO(5, 175, 242, 1),
          ),
        ),
        title: Container(
          alignment: AlignmentDirectional.center,
          width: MediaQuery.of(context).size.width*0.6,
          child: Text('Lista de Ordenes ',style: TextStyle(color:Colors.black54,fontWeight: FontWeight.bold),),
        ),
        actions: <Widget>[



       /*
          GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.clear,
                    size: 30.0,
                    color: Colors.black54,
                  )))
       */
        ],
      ),

      backgroundColor: Colors.white,
      body:Container(
        height:MediaQuery.of(context).size.height,
        child: FutureBuilder<List<ListaPedidoModel>>(
            future:
            fetchListaPedidoModelHoy(http.Client(), (UsuarioModel.idUsuario).toString()),
            builder: (context, snapshot) {
              if (snapshot.data != null) {

                if (snapshot.data.length > 0) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(index.toString());
                        return Padding(
                          padding: EdgeInsets.only(top: 0),
                          child:  Padding(
                            padding: EdgeInsets.only(left:5.0,right: 5.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(10)),
                                  color: residuo == (index) ? Colors.white : Color.fromRGBO(0, 0,0,0.04),
                                ),
                                height: 235.0,
                                child: Column(
                                  children: <Widget>[
                                    /*
                                          * ListTile(
                                        //leading: Image.asset('assets/bolsaCompra.jpg'),
                                        leading:  QrImage(
                                          data: 'Appp anthony',
                                          size: 30,
                                        ),
                                        title: Text('Orden n° 15234'),
                                        subtitle: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text(snapshot.data[index].venta_fechaentrega),
                                              Text(snapshot.data[index].horario_nombre)

                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100.0,
                                          height: 200.0,
                                          // color: Colors.deepOrange,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.0),
                                                child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                  ,style: TextStyle(fontSize:20 ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 13.0,left:45.0),
                                                child:GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenDetailScreen(
                                                            listaPedidoModel: snapshot
                                                                .data[index],),
                                                    ),
                                                  );
                                                },
                                                child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                ),
                                                )
                                            ],
                                          ),
                                        ),

                                      )
                                          *
                                          * */
                                    SizedBox(
                                      height: 30.0,
                                    ),

                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left:15.0),
                                          child: Container(
                                            width:MediaQuery.of(context).size.width*0.42,
                                            alignment: AlignmentDirectional.topStart,
                                            child:fecheEntrega(snapshot.data[index].venta_fechaentrega,
                                                snapshot.data[index].horario_nombre)
                                          ),
                                        ),
                                        /*Container(
                                          width:MediaQuery.of(context).size.width*0.2,
                                          alignment: AlignmentDirectional.topStart,
                                          child:Text(snapshot.data[index].horario_nombre
                                            ,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue),
                                          ),

                                        ),*/
                                        Container(
                                          width:MediaQuery.of(context).size.width*0.40,
                                          alignment: AlignmentDirectional.topEnd,
                                          child:
                                          Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                            ,style: TextStyle(fontSize:18,fontWeight: FontWeight.bold ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      // mainAxisAlignment:Ma
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(top:10.0,left:15.0),
                                          child: Text('PRODUCTOS',style: TextStyle(color: Colors.black38),),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      // color:Colors.amberAccent,
                                        height: 70,
                                        child: Stack(
                                          children: <Widget>[

                                            Positioned(
                                              left: 1.0,
                                              right: 1.0,
                                              top: 1.0,
                                              bottom: 1.0,
                                              child: FutureBuilder(
                                                future:  fetchPedidoRealizado(http.Client(),(snapshot.data[index].idpedido).toString()),
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

                                                },
                                              ),
                                            )
                                          ],
                                        )

                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:10.0,right: 30.0),
                                      child: Divider(
                                        height:10.0,
                                        color: Colors.black12,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top:10.0),
                                      child: Container(
                                        // color:Colors.blue,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(left:10.0),
                                              child:
                                              Container(
                                                height: MediaQuery.of(context).size.height * 0.04,
                                                width:MediaQuery.of(context).size.height * 0.04,
                                                child: Column(
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
                                                ),
                                                //color: Colors.purpleAccent,
                                              ),
                                            ),

                                            Text('Delivery'),
                                            Padding(
                                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.425,),
                                                child: IconButton(
                                                    icon: Icon(Icons.add,color: Colors.blue,),
                                                    onPressed: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrdenDetailScreen(
                                                                listaPedidoModel: snapshot
                                                                    .data[index],),
                                                        ),
                                                      );
                                                    })
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(left:0),
                                              child:GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdenDetailScreen(
                                                              listaPedidoModel: snapshot
                                                                  .data[index],),
                                                      ),
                                                    );
                                                  },
                                                  child:Container(
                                                    //width: MediaQuery.of(context).size.width*0.5,
                                                      child: Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                      alignment:AlignmentDirectional.topEnd
                                                  )
                                              ),
                                            ),

                                            /*
                                                Padding(
                                                  padding: EdgeInsets.only(left:140),
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      color:Colors.amberAccent,
                                                    ),
                                                    alignment: AlignmentDirectional.center,
                                                    child: Icon(Icons.repeat,color: Colors.lightBlueAccent,),
                                                  ),
                                                ),
                                                Text('Reordenar'),
                                                */
                                          ],
                                        ),
                                      ),
                                    ),
                                    /*Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top:10.0),
                                              child:GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdenDetailScreen(
                                                              listaPedidoModel: snapshot
                                                                  .data[index],),
                                                      ),
                                                    );
                                                  },
                                                  child:Container(
                                                      width: MediaQuery.of(context).size.width*0.9,
                                                      child: Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                      alignment:AlignmentDirectional.topEnd
                                                  )
                                              ),
                                            )
                                          ],
                                        )

                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(top:10.0),
                                              child:Center(
                                                child: QrImage(
                                                  data: 'idPedido : '+(snapshot.data[index].idpedido).toString()+
                                                      'fecha : ' +snapshot.data[index].horario_nombre+
                                                      'costoTotal : ' + snapshot.data[index].venta_costototal.toString()+
                                                      'ubicacion  : ' + snapshot.data[index].ubicacion_nombre,
                                                  size: 130,
                                                ),
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*0.2,
                                            // color: Colors.redAccent,
                                          ),
                                          Container(
                                            child:Column(
                                              children: <Widget>[
                                                Text(snapshot.data[index].ubicacion_nombre),
                                                Text(snapshot.data[index].venta_fechaentrega),
                                                Text(snapshot.data[index].horario_nombre)
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.46,
                                            //  color: Colors.blue,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(top: 2.0),
                                                  child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                    ,style: TextStyle(fontSize:20 ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 40.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrdenDetailScreen(
                                                                listaPedidoModel: snapshot
                                                                    .data[index],),
                                                        ),
                                                      );
                                                    },
                                                    child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                  ),
                                                )
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.3,
                                            // color: Colors.yellow,
                                          )

                                          */
                                  ],
                                )
                            ),
                          )
                        );
                      });
                } else {
                  return Container(
                    child: Center(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 100.0),
                              child: Image.asset(
                                'assets/box.png',
                                height: 100.0,
                                width: 100.0,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 20.0),
                                child: Text('Lista de ordenes de hoy vacia',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                        color: Colors.black54)))
                          ],
                        )),
                  );
                }
              } else {
                return Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width,
                    child:  ListView.builder(
                        itemCount:10,
                        itemBuilder: (context, index) {

                          return Padding(padding: EdgeInsets.all(5.0),
                            child: Skeleton(type:'boxListShoppingCart',),
                          );
                        })
                );
              }
            }),
      ),

      /*
      DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
          /*  SliverAppBar(
              backgroundColor: Colors.white,
              expandedHeight: 70,
              flexibleSpace: FlexibleSpaceBar(
                background:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, top: 10.0),
                      child: Text(
                        'Lista de Ordenes',
                        style: TextStyle(
                            fontSize: 30.0,
                            //color: Color.fromRGBO(5, 175, 242, 1),
                            color: Colors.black54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),*/

/*
              SliverAppBar(
                expandedHeight: 70,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                  background:
            Padding(
            padding: EdgeInsets.only(left:2.0,right: 2.0,top:2.0,bottom: 2.0),
                  child:Container(
                    height: 50.0,
                   // color: Colors.deepOrange,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromRGBO(5, 175, 242, 1),

                    ),
                  ),
                ),),
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 2.0,top:2.0,bottom: 2.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.99,
                      height:  MediaQuery.of(context).size.height*0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color.fromRGBO(5, 175, 242, 1),

                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding:EdgeInsets.only(left:10.0),
                            child:Text(
                              'Lista de ordenes',
                              style: TextStyle(color: Colors.white, fontSize: 25.0),
                            ),
                          ),

                          Padding(
                            padding:EdgeInsets.only(left:110.0),
                            child: GestureDetector(
                              onTap: (){

                                Navigator.of(context).pop();

                              },
                              child:  Icon(
                                Icons.clear,
                                color: Colors.white,
                                size:25,
                              ),
                            ),
                          )

                        ],
                      ),
                    )
                  )
                ],
              ),
             */

              /*
              SliverAppBar(
                expandedHeight: 160.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.white,
                leading: GestureDetector(
                  onTap: (){

                    Navigator.of(context).pop();

                  },
                  child:  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black54,
                    size:20,
                  ),
                ),
                title: Text(
                  'Lista de ordenes',
                  style: TextStyle(color: Colors.black, fontSize: 25.0),
                ),


                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        )),
                    background: Container(
                      //color: Colors.greenAccent,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 80.0),
                            child: Container(
                                height: 90.0,
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                                  color: Colors.black12,
                                )),
                          ),
                          SizedBox(
                            height: 5.0,
                          )
                        ],
                      ),
                    )),



              ),
             */

              new SliverPadding(
                padding: new EdgeInsets.all(1.0),
                sliver:  new SliverList(
                  delegate: new SliverChildListDelegate([
                    TabBar(
                      labelColor: Colors.black87,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        Tab(
                            icon: Icon(
                              Icons.calendar_today,
                              color: RED,
                            ),
                            child: Text(
                              'Hoy',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )),
                        Tab(
                          icon: Icon(
                            Icons.cached,
                            color: RED,
                          ),
                          child: Text(
                            'Pendiente',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Tab(
                          icon: Icon(
                            Icons.assignment,
                            color: RED,
                          ),
                          child: Text(
                            'Historial',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                height: 235.0,
                child: FutureBuilder<List<ListaPedidoModel>>(
                    future:
                    fetchListaPedidoModelHoy(http.Client(), (UsuarioModel.idUsuario).toString()),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {

                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child:  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10)),
                                      color: residuo == (index % 2) ? Colors.white : Color.fromRGBO(0, 0,0,0.04),
                                    ),
                                    height: 235.0,
                                    child: Column(
                                      children: <Widget>[
                                        /*
                                          * ListTile(
                                        //leading: Image.asset('assets/bolsaCompra.jpg'),
                                        leading:  QrImage(
                                          data: 'Appp anthony',
                                          size: 30,
                                        ),
                                        title: Text('Orden n° 15234'),
                                        subtitle: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text(snapshot.data[index].venta_fechaentrega),
                                              Text(snapshot.data[index].horario_nombre)

                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100.0,
                                          height: 200.0,
                                          // color: Colors.deepOrange,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.0),
                                                child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                  ,style: TextStyle(fontSize:20 ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 13.0,left:45.0),
                                                child:GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenDetailScreen(
                                                            listaPedidoModel: snapshot
                                                                .data[index],),
                                                    ),
                                                  );
                                                },
                                                child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                ),
                                                )
                                            ],
                                          ),
                                        ),

                                      )
                                          *
                                          * */
                                        SizedBox(
                                          height: 30.0,
                                        ),

                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(left:15.0),
                                              child: Container(
                                                width:MediaQuery.of(context).size.width*0.12,
                                                alignment: AlignmentDirectional.topStart,
                                                child: Text('Hoy  , '
                                                  ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width:MediaQuery.of(context).size.width*0.2,
                                              alignment: AlignmentDirectional.topStart,
                                              child:Text(snapshot.data[index].horario_nombre
                                                ,style: TextStyle(fontWeight: FontWeight.bold,color:Colors.blue),
                                              ),

                                            ),
                                            Container(
                                              width:MediaQuery.of(context).size.width*0.52,
                                              alignment: AlignmentDirectional.topEnd,
                                              child:
                                              Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                ,style: TextStyle(fontSize:18,fontWeight: FontWeight.bold ),
                                              ),
                                            ),

                                          ],
                                        ),
                                        Row(
                                          // mainAxisAlignment:Ma
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top:10.0,left:15.0),
                                              child: Text('PRODUCTOS',style: TextStyle(color: Colors.black38),),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          // color:Colors.amberAccent,
                                            height: 70,
                                            child: Stack(
                                              children: <Widget>[

                                                Positioned(
                                                  left: 1.0,
                                                  right: 1.0,
                                                  top: 1.0,
                                                  bottom: 1.0,
                                                  child: FutureBuilder(
                                                    future:  fetchPedidoRealizado(http.Client(),(snapshot.data[index].idpedido).toString()),
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

                                                      }else{
                                                        return Container(
                                                          height: 100.0,
                                                          color: Colors.white,

                                                        );

                                                      }

                                                    },
                                                  ),
                                                )
                                              ],
                                            )

                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left:10.0,right: 30.0),
                                          child: Divider(
                                            height:10.0,
                                            color: Colors.black12,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top:10.0),
                                          child: Container(
                                            // color:Colors.blue,
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(left:10.0),
                                                  child:
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.04,
                                                    width:MediaQuery.of(context).size.height * 0.04,
                                                    child: Column(
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
                                                    ),
                                                    //color: Colors.purpleAccent,
                                                  ),
                                                ),

                                                Text('Delivery'),
                                                Padding(
                                                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.425,),
                                                  child: IconButton(
                                                      icon: Icon(Icons.add,color: Colors.blue,),
                                                      onPressed: (){
                                                Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                builder: (context) =>
                                                OrdenDetailScreen(
                                                listaPedidoModel: snapshot
                                                    .data[index],),
                                                ),
                                                );
                                                })
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left:0),
                                                  child:GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                OrdenDetailScreen(
                                                                  listaPedidoModel: snapshot
                                                                      .data[index],),
                                                          ),
                                                        );
                                                      },
                                                      child:Container(
                                                          //width: MediaQuery.of(context).size.width*0.5,
                                                          child: Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                          alignment:AlignmentDirectional.topEnd
                                                      )
                                                  ),
                                                ),

                                                /*
                                                Padding(
                                                  padding: EdgeInsets.only(left:140),
                                                  child: Container(
                                                    height: 25,
                                                    width: 25,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.all(Radius.circular(5)),
                                                      color:Colors.amberAccent,
                                                    ),
                                                    alignment: AlignmentDirectional.center,
                                                    child: Icon(Icons.repeat,color: Colors.lightBlueAccent,),
                                                  ),
                                                ),
                                                Text('Reordenar'),
                                                */
                                              ],
                                            ),
                                          ),
                                        ),
                                        /*Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(top:10.0),
                                              child:GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdenDetailScreen(
                                                              listaPedidoModel: snapshot
                                                                  .data[index],),
                                                      ),
                                                    );
                                                  },
                                                  child:Container(
                                                      width: MediaQuery.of(context).size.width*0.9,
                                                      child: Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                      alignment:AlignmentDirectional.topEnd
                                                  )
                                              ),
                                            )
                                          ],
                                        )

                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(top:10.0),
                                              child:Center(
                                                child: QrImage(
                                                  data: 'idPedido : '+(snapshot.data[index].idpedido).toString()+
                                                      'fecha : ' +snapshot.data[index].horario_nombre+
                                                      'costoTotal : ' + snapshot.data[index].venta_costototal.toString()+
                                                      'ubicacion  : ' + snapshot.data[index].ubicacion_nombre,
                                                  size: 130,
                                                ),
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*0.2,
                                            // color: Colors.redAccent,
                                          ),
                                          Container(
                                            child:Column(
                                              children: <Widget>[
                                                Text(snapshot.data[index].ubicacion_nombre),
                                                Text(snapshot.data[index].venta_fechaentrega),
                                                Text(snapshot.data[index].horario_nombre)
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.46,
                                            //  color: Colors.blue,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(top: 2.0),
                                                  child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                    ,style: TextStyle(fontSize:20 ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 40.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrdenDetailScreen(
                                                                listaPedidoModel: snapshot
                                                                    .data[index],),
                                                        ),
                                                      );
                                                    },
                                                    child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                  ),
                                                )
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.3,
                                            // color: Colors.yellow,
                                          )

                                          */
                                      ],
                                    )
                                  ),
                                );
                              });
                        } else {
                          return Container(
                            child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 100.0),
                                      child: Image.asset(
                                        'assets/box.png',
                                        height: 100.0,
                                        width: 100.0,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text('Lista de ordenes de hoy vacia',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black54)))
                                  ],
                                )),
                          );
                        }
                      } else {
                        return Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width*0.9,
                            child:  ListView.builder(
                                itemCount:10,
                                itemBuilder: (context, index) {

                                  return Padding(padding: EdgeInsets.all(5.0),
                                    child: Skeleton(type:'boxListShoppingCart',),
                                  );
                                })
                        );
                      }
                    }),
              ),
              /*Container(
                //   color:Colors.deepOrange,
                // height: 100.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100.0,
                      child: FutureBuilder<List<ListaPedidoModel>>(
                          future: fetchListaPedidoModelHoy(
                              http.Client(), (1).toString()),
                          builder: (context, snapshot) {
                            if (snapshot.data != null) {
                              if (snapshot.data.length > 0) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 20.0),
                                        child: Container(
                                          //   color: Colors.blue,
                                          height: 110.0,
                                          child: Column(
                                            children: <Widget>[
/*
                                            Padding(
                                              padding: const EdgeInsets.only(right:200.0),
                                              child: Container(
                                                child: Text(snapshot.data[index].venta_fechaentrega),
                                              ),
                                            ),
                                            */
                                              Container(
                                                child: Row(
                                                  children: <Widget>[
                                                    Image.asset(
                                                      'assets/regalo.png',
                                                      height: 20.0,
                                                      width: 20.0,
                                                    ),
                                                    Text(
                                                      'Total : ',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 20.0),
                                                    ),
                                                    Text(
                                                        'S/. ' +
                                                            (snapshot
                                                                    .data[index]
                                                                    .venta_costototal)
                                                                .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 15.0)),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40.0),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.black38,
                                                      size: 10.0,
                                                    ),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Text(snapshot.data[index]
                                                          .ubicacion_nombre),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40.0),
                                                    child: Icon(
                                                      Icons.credit_card,
                                                      color: Colors.black38,
                                                      size: 10.0,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 200.0,
                                                            top: 10.0),
                                                    child: Text(snapshot
                                                        .data[index]
                                                        .tipopago_nombre),
                                                  ),
                                                ],
                                              ),
                                              /* Container(
                                              height: 80.0,
                                              // color: Colors.purpleAccent,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 250.0,
                                                    // color: Colors.yellow,
                                                    child: Column(
                                                      children: <Widget>[

                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    //  color: Colors.purpleAccent,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('S/. '+(snapshot.data[index].venta_costototal).toString()),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:18.0),
                                                          child: Container(
                                                            //color: Colors.greenAccent,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Text('Detalles',style: TextStyle(color:Colors.lightBlue),),

                                                              ],
                                                            ),
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  )







                                                ],
                                              ),
                                            ),

*/
                                              GestureDetector(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 250.0),
                                                  child: Text(
                                                    'Detalles',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.lightBlue),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenDetailScreen(
                                                        listaPedidoModel:
                                                            snapshot
                                                                .data[index],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0,
                                                    right: 30.0,
                                                    top: 5.0,
                                                    bottom: 5.0),
                                                child: Container(
                                                  height: 6.0,
                                                  child: Divider(
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return Container(
                                  child: Center(
                                      child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 100.0),
                                        child: Image.asset(
                                          'assets/box.png',
                                          height: 100.0,
                                          width: 100.0,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: Text(
                                              'Lista de ordenes de hoy vacia',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.black54)))
                                    ],
                                  )),
                                );
                              }
                            } else {
                              return Center(
                                  child: CircularProgressIndicator(
                                backgroundColor: Colors.cyan,
                                strokeWidth: 5,
                              ));
                            }
                          }),
                    ),
                    /*Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(10.0),
                            topRight: const Radius.circular(10.0),
                            bottomLeft: const Radius.circular(10.0),
                            bottomRight: const Radius.circular(10.0),
                          )),
                    )*/
                  ],
                ),
              ),*/
              Container(
                height: 300.0,
                child: FutureBuilder<List<ListaPedidoModel>>(
                    future: fetchListaPedidoModelPendiente(
                        http.Client(), (UsuarioModel.idUsuario).toString()),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 100.0,
                                  child: Card(
                                    child: Row(
                                      children: <Widget>[
                                        /*
                                          * ListTile(
                                        //leading: Image.asset('assets/bolsaCompra.jpg'),
                                        leading:  QrImage(
                                          data: 'Appp anthony',
                                          size: 30,
                                        ),
                                        title: Text('Orden n° 15234'),
                                        subtitle: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text(snapshot.data[index].venta_fechaentrega),
                                              Text(snapshot.data[index].horario_nombre)

                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100.0,
                                          height: 200.0,
                                          // color: Colors.deepOrange,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.0),
                                                child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                  ,style: TextStyle(fontSize:20 ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 13.0,left:45.0),
                                                child:GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenDetailScreen(
                                                            listaPedidoModel: snapshot
                                                                .data[index],),
                                                    ),
                                                  );
                                                },
                                                child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                ),
                                                )
                                            ],
                                          ),
                                        ),

                                      )
                                          *
                                          * */


                                        Container(
                                          child: Padding(
                                            padding: EdgeInsets.only(top:10.0),
                                            child:Center(
                                              child: QrImage(
                                                data: 'idPedido : '+(snapshot.data[index].idpedido).toString()+
                                                       'fecha : ' +snapshot.data[index].horario_nombre+
                                                'costoTotal : ' + snapshot.data[index].venta_costototal.toString()+
                                                'ubicacion  : ' + snapshot.data[index].ubicacion_nombre,
                                                size: 130,
                                              ),
                                            ),
                                          ),
                                          width: MediaQuery.of(context).size.width*0.2,
                                         // color: Colors.redAccent,
                                        ),
                                        Container(
                                          child:Column(
                                            children: <Widget>[
                                              Text(snapshot.data[index].ubicacion_nombre),
                                              Text(snapshot.data[index].venta_fechaentrega),
                                              Text(snapshot.data[index].horario_nombre)
                                            ],
                                          ),
                                          width: MediaQuery.of(context).size.width*0.46,
                                        //  color: Colors.blue,
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(top: 2.0),
                                                child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                  ,style: TextStyle(fontSize:20 ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 40.0),
                                                child:GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdenDetailScreen(
                                                              listaPedidoModel: snapshot
                                                                  .data[index],),
                                                      ),
                                                    );
                                                  },
                                                  child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                ),
                                              )
                                            ],
                                          ),
                                          width: MediaQuery.of(context).size.width*0.3,
                                         // color: Colors.yellow,
                                        )
                                      ],
                                    )
                                    /*
                                      child: ListTile(
                                        leading: Image.asset('assets/bolsaCompra.jpg'),
                                        title: Text('Orden n° 15234'),
                                        subtitle: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text(snapshot.data[index].venta_fechaentrega),
                                              Text(snapshot.data[index].horario_nombre)

                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100.0,
                                          height: 200.0,
                                          // color: Colors.deepOrange,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.0),
                                                child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                  ,style: TextStyle(fontSize:20 ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 13.0,left:45.0),
                                                child:GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdenDetailScreen(
                                                              listaPedidoModel: snapshot
                                                                  .data[index],),
                                                      ),
                                                    );
                                                  },
                                                  child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),

                                      )
                                  */

                                  ),
                                );
                              });
                        } else {
                          return Container(
                            child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 100.0),
                                      child: Image.asset(
                                        'assets/box.png',
                                        height: 100.0,
                                        width: 100.0,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text(
                                            'Lista de ordenes pendientes vacia',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                color: Colors.black54)))
                                  ],
                                )),
                          );
                        }
                      } else {
                        return Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width*0.9,
                            child:  ListView.builder(
                                itemCount:10,
                                itemBuilder: (context, index) {

                                  return Padding(padding: EdgeInsets.all(5.0),
                                    child: Skeleton(type:'boxListShoppingCart',),
                                  );
                                })
                        );
                      }
                    }),
              ),
              Container(
               // color: Colors.orangeAccent,
                height: 300.0,
                child: FutureBuilder<List<ListaPedidoModel>>(
                    future: fetchListaPedidoModelHistorial(
                        http.Client(), (UsuarioModel.idUsuario).toString()),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        if (snapshot.data.length > 0) {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 150.0,
                                  child: Card(
                                      child:Row(
                                        children: <Widget>[
                                          /*
                                          * ListTile(
                                        //leading: Image.asset('assets/bolsaCompra.jpg'),
                                        leading:  QrImage(
                                          data: 'Appp anthony',
                                          size: 30,
                                        ),
                                        title: Text('Orden n° 15234'),
                                        subtitle: Container(
                                          child: Column(
                                            children: <Widget>[
                                              Text(snapshot.data[index].venta_fechaentrega),
                                              Text(snapshot.data[index].horario_nombre)

                                            ],
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100.0,
                                          height: 200.0,
                                          // color: Colors.deepOrange,
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(right: 20.0),
                                                child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                  ,style: TextStyle(fontSize:20 ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(top: 13.0,left:45.0),
                                                child:GestureDetector(
                                                onTap: (){
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenDetailScreen(
                                                            listaPedidoModel: snapshot
                                                                .data[index],),
                                                    ),
                                                  );
                                                },
                                                child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                ),
                                                )
                                            ],
                                          ),
                                        ),

                                      )
                                          *
                                          * */


                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.only(top:10.0),
                                              child:Center(
                                                child: QrImage(
                                                  data: 'idPedido : '+(snapshot.data[index].idpedido).toString()+
                                                      'fecha : ' +snapshot.data[index].horario_nombre+
                                                      'costoTotal : ' + snapshot.data[index].venta_costototal.toString()+
                                                      'ubicacion  : ' + snapshot.data[index].ubicacion_nombre,
                                                  size: 130,
                                                ),
                                              ),
                                            ),
                                            width: MediaQuery.of(context).size.width*0.2,
                                            // color: Colors.redAccent,
                                          ),
                                          Container(
                                            child:Column(
                                              children: <Widget>[
                                                Text(snapshot.data[index].ubicacion_nombre),
                                                Text(snapshot.data[index].venta_fechaentrega),
                                                Text(snapshot.data[index].horario_nombre)
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.46,
                                            //  color: Colors.blue,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(top: 2.0),
                                                  child: Text('S/.'+(snapshot.data[index].venta_costototal).toStringAsFixed(2)
                                                    ,style: TextStyle(fontSize:20 ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 40.0),
                                                  child:GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrdenDetailScreen(
                                                                listaPedidoModel: snapshot
                                                                    .data[index],),
                                                        ),
                                                      );
                                                    },
                                                    child:Text('Detalles',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
                                                  ),
                                                )
                                              ],
                                            ),
                                            width: MediaQuery.of(context).size.width*0.3,
                                            // color: Colors.yellow,
                                          )
                                        ],
                                      )
                                  ),
                                );
                              });
                        } else {
                          return Container(
                            child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 100.0),
                                      child: Image.asset(
                                        'assets/box.png',
                                        height: 100.0,
                                        width: 100.0,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 20.0),
                                        child: Text(
                                          'Historial vacio',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0,
                                              color: Colors.black54),
                                        ))
                                  ],
                                )),
                          );
                        }
                      } else {
                        return Container(
                            height: 100.0,
                            width: MediaQuery.of(context).size.width*0.9,
                            child:  ListView.builder(
                                itemCount:10,
                                itemBuilder: (context, index) {

                                  return Padding(padding: EdgeInsets.all(5.0),
                                    child: Skeleton(type:'boxListShoppingCart',),
                                  );
                                })
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),

      */

      //bottomNavigationBar: _indexBottom(),

      /*
      floatingActionButton: ClipOval(
      child: Container(
        height: 50,
        width: 50,
        color: Colors.redAccent,
        child: Icon(Icons.home,color: Colors.white,size: 40,),
      ),
    ),
    */

    );
  }

  Widget fecheEntrega(String fecha,String horario){
    if(DateTime.now().toString().substring(0,10)==fecha.substring(0,10)){
      return Text(
         'Hoy , '+ horario,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
      );
    }else{
      if(DateTime.now().add(new Duration(days: 1)).toString().substring(0,10) == fecha.substring(0,10)){
        return Text(
          'Mañana , '+horario,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
        );
      }else{
        return Text(
          fecha.substring(0,10)+' , '+horario,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
        );
      }
    }

  }


}




























/*
class OrderScreen extends StatefulWidget {

  final int idUsuario;

  const OrderScreen({Key key, this.idUsuario}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState(idUsuario);
}

class _OrderScreenState extends State<OrderScreen> {
  final int idUsuario;

  var _curIndex = 0;
  var contents = "Home";

  _OrderScreenState(this.idUsuario);

  Widget _indexBottom() =>
      Container(
        height: 50.0,
        color: Colors.yellow,
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Inicio",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 0 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.home,
                size: 20,
                color: RED,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.place,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Ubicacion",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 1 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.place,
                size: 20,
                color: RED,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Carrito",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.shopping_cart,
                size: 20,
                color: RED,
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Favoritos",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.favorite_border,
                size: 20,
                color: RED,
              ),
            ),

            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Orden",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.library_books,
                size: 20,
                color: RED,
              ),
            )


          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _curIndex,
          onTap: (index) {
            setState(() {
              _curIndex = index;
              switch (_curIndex) {
                case 0:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                  break;
                case 1:
                  contents = "Ubicacion";
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingCartScreen(idUsuario: idUsuario,),
                    ),
                  );
                  break;
                case 3:
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(),
                    ),
                  );
                  break;
              }
            });
          },
        ),
      );


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calendar_today,color: RED,) ,
                 child:Text('Hoy',style: TextStyle(color: Colors.black,),) ),
              Tab(icon: Icon(Icons.cached,color: RED,),
                  child:Text('Pendiente',style: TextStyle(color: Colors.black,),) ,),
              Tab(icon: Icon(Icons.assignment,color: RED,),
                child:Text('Historial',style: TextStyle(color: Colors.black,),) ,),
            ],
          ),
          title: Text('Ordenes'
          ),
        ),

        body: TabBarView(
          children: [
             Container(
                height: 600.0,
                child: Column(
                  children: <Widget>[

                    Container(
                      height: 410.0,
                      child: FutureBuilder<List<ListaPedidoModel>>(
                          future: fetchListaPedidoModelHoy(http.Client(),(idUsuario).toString()),
                          builder: (context,snapshot){
                            if(snapshot.data != null){

                              if(snapshot.data.length>0) {
                                return ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0, top: 20.0),
                                        child: Container(
                                          //   color: Colors.blue,
                                          height: 110.0,
                                          child: Column(
                                            children: <Widget>[

/*
                                            Padding(
                                              padding: const EdgeInsets.only(right:200.0),
                                              child: Container(
                                                child: Text(snapshot.data[index].venta_fechaentrega),
                                              ),
                                            ),
                                            */
                                              Container(
                                                child: Row(
                                                  children: <Widget>[

                                                    Image.asset(
                                                      'assets/regalo.png',
                                                      height: 20.0,
                                                      width: 20.0,
                                                    ),

                                                    Text('Total : ',
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 20.0),),

                                                    Text('S/. ' +
                                                        (snapshot.data[index]
                                                            .venta_costototal)
                                                            .toString()
                                                        , style: TextStyle(
                                                            color: Colors
                                                                .black54,
                                                            fontSize: 15.0)
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(left: 40.0),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Colors.black38,
                                                      size: 10.0,),
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Text(snapshot.data[index]
                                                          .ubicacion_nombre),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(left: 40.0),
                                                    child: Icon(
                                                      Icons.credit_card,
                                                      color: Colors.black38,
                                                      size: 10.0,),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(right: 200.0,
                                                        top: 10.0),
                                                    child: Text(
                                                        snapshot.data[index]
                                                            .tipopago_nombre),
                                                  ),
                                                ],
                                              ),
                                              /* Container(
                                              height: 80.0,
                                              // color: Colors.purpleAccent,
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    width: 250.0,
                                                    // color: Colors.yellow,
                                                    child: Column(
                                                      children: <Widget>[

                                                      ],
                                                    ),
                                                  ),

                                                  Container(
                                                    //  color: Colors.purpleAccent,
                                                    child: Column(
                                                      children: <Widget>[
                                                        Text('S/. '+(snapshot.data[index].venta_costototal).toString()),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top:18.0),
                                                          child: Container(
                                                            //color: Colors.greenAccent,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Text('Detalles',style: TextStyle(color:Colors.lightBlue),),

                                                              ],
                                                            ),
                                                          ),
                                                        )

                                                      ],
                                                    ),
                                                  )







                                                ],
                                              ),
                                            ),

*/
                                              GestureDetector(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(left: 250.0),
                                                  child: Text('Detalles',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .lightBlue),),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          OrdenDetailScreen(
                                                            listaPedidoModel: snapshot
                                                                .data[index],),
                                                    ),
                                                  );
                                                },
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 30.0,
                                                    right: 30.0,
                                                    top: 5.0,
                                                    bottom: 5.0),
                                                child: Container(
                                                  height: 6.0,
                                                  child: Divider(
                                                    color: Colors.black45,
                                                  ),
                                                ),
                                              )


                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }else{
                                return Container(
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[

                                        Padding(
                                            padding: EdgeInsets.only(top:100.0),
                                          child: Image.asset('assets/box.png',height: 100.0,width: 100.0,),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top:20.0),
                                           child: Text('Lista de ordenes de hoy vacia',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.black54))

                                        )
                                      ],
                                    )
                                  ),
                                );

                              }

                            }else {
                              return
                                Center(
                                    child:CircularProgressIndicator(
                                      backgroundColor: Colors.cyan,
                                      strokeWidth: 5,)
                                );

                            }
                          }
                      ),
                    ),


                    Container(
                      height: 100.0,
                      decoration: BoxDecoration(
                          color:Colors.black26,
                          borderRadius:  new BorderRadius.only(
                            topLeft:  const  Radius.circular(10.0),
                            topRight: const  Radius.circular(10.0),
                            bottomLeft: const  Radius.circular(10.0),
                            bottomRight: const  Radius.circular(10.0),

                          )
                      ),
                    )
                  ],
                ),
              ),


            Container(
              height: 300.0,
              child: FutureBuilder<List<ListaPedidoModel>>(
                  future: fetchListaPedidoModelPendiente(http.Client(),(idUsuario).toString()),
                  builder: (context,snapshot){
                    if(snapshot.data != null){
                    if(snapshot.data.length>0) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Container(
                                //   color: Colors.blue,
                                height: 100.0,
                                child: Column(
                                  children: <Widget>[


                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 200.0),
                                      child: Container(
                                        child: Text(snapshot.data[index]
                                            .venta_fechaentrega),
                                      ),
                                    ),

                                    Container(
                                      height: 80.0,
                                      // color: Colors.purpleAccent,
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 250.0,
                                            // color: Colors.yellow,
                                            child: Column(
                                              children: <Widget>[
                                                Text(snapshot.data[index]
                                                    .ubicacion_nombre),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .only(
                                                      right: 200.0, top: 10.0),
                                                  child: Text(
                                                      snapshot.data[index]
                                                          .tipopago_nombre),
                                                )
                                              ],
                                            ),
                                          ),

                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OrdenDetailScreen(
                                                        listaPedidoModel: snapshot
                                                            .data[index],),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              //  color: Colors.purpleAccent,
                                              child: Column(
                                                children: <Widget>[
                                                  Text('S/. ' +
                                                      (snapshot.data[index]
                                                          .venta_costototal)
                                                          .toString()),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(top: 18.0),
                                                    child: Container(
                                                      //color: Colors.greenAccent,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Text('Detalles',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lightBlue),),

                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              ),
                                            ),
                                          )


                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0, right: 20.0),
                                      child: Container(
                                        height: 1.0,
                                        child: Divider(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    )


                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }else{
                      return Container(
                        child: Center(
                            child: Column(
                              children: <Widget>[

                                Padding(
                                  padding: EdgeInsets.only(top:100.0),
                                  child: Image.asset('assets/box.png',height: 100.0,width: 100.0,),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top:20.0),
                                    child: Text('Lista de ordenes pendientes vacia'
                                        ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.black54))

                                )
                              ],
                            )
                        ),
                      );

                    }

                    }else {
                      return
                        Center(
                            child:CircularProgressIndicator(
                              backgroundColor: Colors.cyan,
                              strokeWidth: 5,)
                        );

                    }
                  }
              ),
            ),
            Container(
              height: 300.0,
              child: FutureBuilder<List<ListaPedidoModel>>(
                  future: fetchListaPedidoModelHistorial(http.Client(),(idUsuario).toString()),
                  builder: (context,snapshot){
                    if(snapshot.data != null){

                      if(snapshot.data.length>0) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Container(
                                  //   color: Colors.blue,
                                  height: 100.0,
                                  child: Column(
                                    children: <Widget>[


                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 200.0),
                                        child: Container(
                                          child: Text(snapshot.data[index]
                                              .venta_fechaentrega),
                                        ),
                                      ),

                                      Container(
                                        height: 80.0,
                                        // color: Colors.purpleAccent,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 250.0,
                                              // color: Colors.yellow,
                                              child: Column(
                                                children: <Widget>[
                                                  Text(snapshot.data[index]
                                                      .ubicacion_nombre),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(right: 200.0,
                                                        top: 10.0),
                                                    child: Text(
                                                        snapshot.data[index]
                                                            .tipopago_nombre),
                                                  )
                                                ],
                                              ),
                                            ),

                                            Container(
                                              //  color: Colors.purpleAccent,
                                              child: Column(
                                                children: <Widget>[
                                                  Text('S/. ' +
                                                      (snapshot.data[index]
                                                          .venta_costototal)
                                                          .toString()),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .only(top: 18.0),
                                                    child: Container(
                                                      //color: Colors.greenAccent,

                                                      child: Column(
                                                        children: <Widget>[
                                                          Text('Detalles',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .lightBlue),),

                                                        ],
                                                      ),
                                                    ),
                                                  )

                                                ],
                                              ),
                                            )


                                          ],
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Container(
                                          height: 1.0,
                                          child: Divider(
                                            color: Colors.black45,
                                          ),
                                        ),
                                      )


                                    ],
                                  ),
                                ),
                              );
                            }
                        );
                      }else{
                        return Container(
                          child: Center(
                              child: Column(
                                children: <Widget>[

                                  Padding(
                                    padding: EdgeInsets.only(top:100.0),
                                    child: Image.asset('assets/box.png',height: 100.0,width: 100.0,),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top:20.0),
                                      child: Text('Historial vacio',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.0,color: Colors.black54),)

                                  )
                                ],
                              )
                          ),
                        );

                      }
                    }else {
                      return
                        Center(
                            child:CircularProgressIndicator(
                              backgroundColor: Colors.cyan,
                              strokeWidth: 5,)
                        );

                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

*/
