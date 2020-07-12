import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Screen/PerfilScreen.dart';

int idUbicacionGlobal;
String ubicacionActual;

Widget appSliverBarWidgetHome(context) {
  final media =MediaQuery.of(context);

  return SliverAppBar(
    expandedHeight: 10.0,
    floating: true,
    pinned: true,
    snap: true,
    elevation: 50,
    backgroundColor:Color.fromRGBO(5, 175, 242, 1),
    leading:Padding(
      padding: EdgeInsets.only(top:10.0,bottom: 10.0),
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        border:Border.all(color: Colors.white,width: 1.5),
        ),
        child: Padding(
          padding: EdgeInsets.only(left:5.0,top: 2.0),
          child:Text(
            'GO',
            style: TextStyle(
                color: Colors.white, fontSize: 25.0,fontWeight: FontWeight.w700),
          ),
        ),
      ),
    ),

  title:Padding(
      padding: EdgeInsets.only(right:30.0),
      child:Row(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.only(right: 1.0),
            child: Text('ENVIAR A ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 10.0),),
          ),


          Padding(
            padding: EdgeInsets.only(right: 0.0),
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

                    idUbicacionGlobal=snapshot.data.idubicacion;
                    ubicacionActual=snapshot.data.ubicacion_nombre;
                    return Container(
                      height: 28.0,
                      width:media.size.width*0.34,
                      // media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.4 :MediaQuery.of(context).size.height * 0.15,

                      decoration: new BoxDecoration(

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
                                  color: Colors.white, fontSize: 14.0,fontWeight: FontWeight.bold,),
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
                      height: 10,
                      width: 10,
                    );
                  }
                },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left:5.0),
              child: Icon(Icons.keyboard_arrow_down,size: 18.0,color: Colors.white,)
          ),

        ],
      ),
  ),


      actions: <Widget>[

        GestureDetector(
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(context) => PerfilScreen(
                    )
                )
            );
/*
            auth.signOut();
            //MyApp();
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool('sessionValue', null);
            prefs.setString('email', null);

            UsuarioModel.sesion=false;
            UsuarioModel.keepEmail="";
              //Navigator.of(context).pushReplacementNamed('/LoginRegister');
             Navigator.of(context).pushNamedAndRemoveUntil(
                  '/homeProof', (Route<dynamic> route) => false);

         //   Navigator.of(context).pushNamed('/PerfilScreen');

          */
          },
          child:
          Padding(
              padding: EdgeInsets.only(right: 15.0),
              child:  Container(
                decoration: new BoxDecoration(
                    border:Border.all(color: Colors.white),
                    shape: BoxShape.circle

                ),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.person,color: Colors.white,),
                ),
              )
          )
        )
    ],
  );
}


