import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/FavoriteProductApi.dart';
import 'package:tienda_mimi/Service/Model/FavoriteProductMore.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Screen/DetailProductScreen.dart';

class FavoriteProductScreen extends StatefulWidget {
  @override
  _FavoriteProductScreenState createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {

  FavoriteProductApi _favoriteProductApi= new FavoriteProductApi();
  @override
  void initState(){
    super.initState();
    mainPusher.bindPusher();

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:
      AppBar(
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
              child: Text('Productos Favoritos',style:TextStyle(color:Colors.black87,fontSize: 15.0)),
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
      body: CustomScrollView(
        slivers: <Widget>[
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
                            'Productos favoritos',
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          ),
                        ),

                        Padding(
                          padding:EdgeInsets.only(left:70.0),
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

          SliverToBoxAdapter(
            child: Container(
              height: 100,
              color: Colors.black26,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top:10),
              child: Container(
                height: 30,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left:20),
                  child: Text('4 PRODUCTOS',style: TextStyle(color: Colors.black,fontSize: 20)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height,
               // color: Colors.lightBlue[50],
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
                          childAspectRatio: 0.85,
                          children:List.generate(snapshot.data.length, (index){
                            return new Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                                margin: EdgeInsets.all(5.0),
                                width: 210.0,
                                child: Stack(
                                  children: <Widget>[


                                    Positioned(
                                      left: 30.0,
                                      top:10.0,
                                      child: GestureDetector(

                                        onTap:(){

                                          ProductoJOINCategoriaJOINImagenModel productoJOINCategoriaJOINImagenModel= new  ProductoJOINCategoriaJOINImagenModel
                                            (
                                            idProducto:snapshot.data[index].idProducto,
                                            idCategoria:2,
                                            producto_uri_imagen:snapshot.data[index].producto_uri_imagen,
                                            producto_marca:snapshot.data[index].producto_marca,
                                            producto_envase:snapshot.data[index].producto_envase,
                                            producto_detalle:snapshot.data[index].producto_detalle,
                                            producto_cantidad:snapshot.data[index].producto_cantidad,
                                            nombresubcategoria:'',
                                            idsubcategoria:2,
                                            detalle:snapshot.data[index].producto_detalle,
                                            Categoria_nombre:'',
                                            Categoria_descripcion:'',
                                            Producto_nombre:snapshot.data[index].producto_nombre,
                                            Producto_precio:snapshot.data[index].producto_precio,
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailProductScreen(
                                                  productoJOINCategoriaJOINImagenModel: productoJOINCategoriaJOINImagenModel
                                              ),
                                            ),
                                          );

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
                                        child: Icon(Icons.favorite,color: Colors.redAccent,),
                                      ),
                                    ),
                                    Positioned(
                                      top:120,
                                      left: 20.0,
                                      child:Center(
                                        child: Column(

                                          children: <Widget>[
                                            Text(snapshot.data[index].producto_nombre+ " "),
                                            Text( snapshot.data[index].producto_marca),
                                            Text(snapshot.data[index].producto_envase+' '+snapshot.data[index].producto_cantidad),
                                            Text( 'S/.'+(snapshot.data[index].producto_precio).toString())
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
          )

        ],
      ),
    );
  }
}
