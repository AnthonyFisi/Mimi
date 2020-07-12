import 'package:flutter/material.dart';

import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:http/http.dart' as http;

Widget appSliverBarWidgetCategories(context) {
  return SliverAppBar(
    expandedHeight: 50.0,
    floating: true,
    pinned: true,
    snap: true,
    elevation: 50,
    backgroundColor: Colors.white,
    leading: Icon(Icons.arrow_back_ios,color: Colors.black,),
    actions: <Widget>[

      Container(
        width: 260.0,
        //color: Colors.blue,
        child: Stack(
          children: <Widget>[

            Positioned(
              left: 30,
              bottom: 30,
              child:GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(),
                      ));
                },
                child: FutureBuilder<UbicacionModel>(
                  future: showUbicacionActual(http.Client(), (1).toString()),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Container(
                        height: 40.0,
                        width: 180,
                        //color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.gps_fixed,color: Colors.black54,size: 20.0,),
                              Text(
                                snapshot.data.ubicacion_nombre,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11.0),
                              ),
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
           /* Positioned(
              top:20.0,
              left: 40.0,
              child:   GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Image.asset(
                      'assets/LogoColor.png',
                      height: 40.0,
                    ),
                  )
              ),
            )
            */
          ],
        ),
      ),
      /*FutureBuilder<List<String>>(
          future: fetchLista(http.Client()),
          builder: (context, snapshot) {
            return IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 25.0,
                ),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearch(snapshot.data));
                });
          }),

       GestureDetector(

          child:Image.asset('assets/cart.png',height: 30.0,width: 30.0,),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoppingCartScreen(idUsuario: 1,),
                ),
              );
            },
      )*/
      IconButton(
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.black,
          size: 25.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShoppingCartScreen(
                idUsuario: 1,
              ),
            ),
          );
        },
      ),
    ],
  );
}
