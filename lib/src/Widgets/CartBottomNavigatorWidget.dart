
import 'package:flutter/material.dart';
import 'package:tienda_mimi/PatternBLOC/websocket.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';


Widget CartBottomNavigationWidget(context,Future<PedidoRealModel> _pedidoFuture,PusherService pusherService){

  return GestureDetector(
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
            StreamBuilder(
              stream: pusherService.eventStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container(
                  child: Text(snapshot.data,style: TextStyle(color: Colors.white,fontSize: 25),),
                );
              },
            ),
  /*          FutureBuilder<PedidoRealModel>(
                future:  _pedidoFuture,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {




                    if(snapshot.data.pedido_estado !='Atendido'){
                      UsuarioModel.cantidadTotal=snapshot.data.pedido_cantidadtotal;
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
                              child: Text('S/.'+(snapshot.data.pedido_montototal).toStringAsFixed(2) + ' soles ' ,style: TextStyle(color: Colors.white,fontSize: 15.0),),
                            ),



                            //Text((UsuarioModel.cantidadTotal).toString())

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
*/
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


}
/*
*Container(
              width: 150,
              color: Colors.black12,
              child: Column(

              ),
            ),
*  */

/*
*
* */