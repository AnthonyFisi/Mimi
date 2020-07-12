
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/FavoriteProductApi.dart';
import 'package:tienda_mimi/Service/Api/UsuarioApi.dart';
import 'package:tienda_mimi/Service/Model/FavoriteProductModel.dart';
import 'package:tienda_mimi/Service/Model/FavoriteProductMore.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Screen/DetailProductScreen.dart';


class PerfilScreen extends StatefulWidget {
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  UsuarioApi usuarioApi=new UsuarioApi();

  Random random = new Random();
  FavoriteProductApi _favoriteProductApi;

  @override
    void initState() {
    // TODO: implement initState
    super.initState();
    _favoriteProductApi= new FavoriteProductApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black54,),
          onPressed: (){
          Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
        title: Container(
          width: MediaQuery.of(context).size.width*0.5,
          child: Center(
            child: Text('Perfil',style:TextStyle(color:Colors.black87,fontSize: 20.0)),
          )
        ),
/*
        actions: <Widget>[
          GestureDetector(
              onTap: (){

                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

              },
              child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child:Icon(Icons.clear,size: 30.0,color: Colors.black54,)
              )
          )
        ],*/
      ),

        body:CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height*0.3,
                color: Colors.white,
                child: FutureBuilder<UsuarioModel>(
                  future: usuarioApi.fetchUsuariofindById(http.Client(),(UsuarioModel.idUsuario).toString()),
                  builder: (context,snapshot){
                    if(snapshot.data != null){

                      return Column(
                        children: <Widget>[

                          //Image.network(snapshot.data.Usuario_foto,height: 100.0,width: 100.0,),
                          Padding(
                            padding: EdgeInsets.only(top:20),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
                              child: Text(snapshot.data.Usuario_nombre.toUpperCase().substring(0,1),style: TextStyle(color: Colors.white,fontSize:35,fontWeight: FontWeight.bold),),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top:20),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(snapshot.data.Usuario_nombre.substring(0,1).toUpperCase()+
                                      snapshot.data.Usuario_nombre.substring(1,snapshot.data.Usuario_nombre.length)
                                      +' '+
                                      snapshot.data.Usuario_apellido.substring(0,1).toUpperCase()+
                                      snapshot.data.Usuario_apellido.substring(1,snapshot.data.Usuario_nombre.length)
                                      ,style: TextStyle(fontSize: 25,color:Colors.black,fontWeight: FontWeight.bold)
                                  ),
                                )
                            ),
                          ),
                                  Padding(
                                  padding: EdgeInsets.only(top:5),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 20,left: 20),
                                          child:Icon(Icons.location_on,color:Colors.black38,size: 15,),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child:  Container(
                                              width: MediaQuery.of(context).size.width*0.5,
                                              child:Text(UsuarioModel.direccion,style: TextStyle(fontSize: 15,color:Colors.black38),),
                                              alignment: AlignmentDirectional.center,
                                            )
                                        ),

                                      ],
                                    ),
                                  ),
                                  ),



                        /*
                          Container(
                            color:Colors.blue,
                            width: MediaQuery.of(context).size.width*0.5,
                              child:Text(UsuarioModel.direccion,style: TextStyle(fontSize: 15,color:Colors.black38),),
                            /*Center(
                                child:  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
//MediaQuery.of(context).size.width*0.1
                                    Padding(
                                      padding: EdgeInsets.only(left:0),
                                      child:Icon(Icons.location_on,color:Colors.black38,size: 15,),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left:10),
                                      child:Text(UsuarioModel.direccion,style: TextStyle(fontSize: 15,color:Colors.black38),),
                                    )

                                  ],

                                ),
                              )*/
                          )
                          */



                        ],
                      );

                    }else{
                      return Container(


                      );
                    }

                  },
                )

              ),
            ),
            /*
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height*0.15,
                color: Colors.black12,
              ),
            ),
            */
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: 3,
                child: SizedBox(
                  height:MediaQuery.of(context).size.height*0.6,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        tabs: <Widget>[
                          Tab(
                            text: "Ubicaciones",

                          ),
                          Tab(
                            text: "Metodos de pago",
                          ),
                          Tab(
                            text: "Configuraciones",
                          )
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height*0.6,
                              color: Colors.green,
                            ),
                            /*
                            Container(
                              height: MediaQuery.of(context).size.height*0.6,
                            //  color: Colors.green,
                              child: FutureBuilder<List<FavoriteProductMoreModel>>(
                                future:_favoriteProductApi.listaFavoriteProduct(UsuarioModel.idUsuario) ,
                                builder: (context,snapshot){
                                  if(snapshot.data != null){
                                    return GridView.count(
                                        primary: false,
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 2,
                                        controller: new ScrollController(keepScrollOffset: false),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        childAspectRatio: 1,
                                        children:List.generate(snapshot.data.length, (index){
                                          return new Container(
                                              margin: EdgeInsets.all(5.0),
                                              color: Colors.white,
                                              width: 210.0,
                                              child: Stack(
                                                children: <Widget>[


                                                  Positioned(
                                                    left: 30.0,
                                                    top:10.0,
                                                    child: GestureDetector(
                                                      onTap:(){

                                                      },

                                                      child: Image.network(snapshot.data[index].producto_uri_imagen,
                                                        height: 100.0,
                                                        width: 100.0,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),

                                              Positioned(

                                                right: 10.0,
                                                top: 10,
                                                child: Container(
                                                  child: Icon(Icons.favorite,color: Colors.amberAccent[400],),
                                                ),
                                              ),
                                                  Positioned(
                                                    top:120,
                                                    left: 20.0,
                                                    child:Center(
                                                      child: Column(

                                                        children: <Widget>[
                                                          Text(snapshot.data[index].producto_nombre+ " "+ snapshot.data[index].producto_marca),
                                                          Text( (snapshot.data[index].producto_precio).toString())
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                          );
                                        })
                                    );
                                  }else{
                                    return Container(
                                      color: Colors.white,
                                      height: 50,
                                    );
                                  }
                                },
                              ),
                            ),
                            */
                            Container(
                              height: MediaQuery.of(context).size.height*0.6,
                              color: Colors.redAccent,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height*0.6,
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )




          ],
      )

    );
  }
}
