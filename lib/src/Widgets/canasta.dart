
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Bloc/BlocPattern.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';

class canasta extends StatefulWidget {
  @override
  _canastaState createState() => _canastaState();
}

class _canastaState extends State<canasta> {

  @override
  void initState() {
    super.initState();
    //rxPedidoReal.fetchTodo(http.Client(),UsuarioModel.idUsuario.toString());
     //bindPusher();

  }

  @override
  void dispose() {
    super.dispose();
  }


  void bindPusher(){
    channel.bind(eventController.text, (x) {
      if (mounted)
        setState(() {
          lastEvent = x;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.of(context).pushNamed('/ShoppingCartScreen',arguments: UsuarioModel.idUsuario);
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

                Text(
                  lastEvent?.data ?? "",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
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
  }
}
