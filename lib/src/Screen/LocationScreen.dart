import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Widgets/appBarWidgetHome.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController direccion = TextEditingController();
  TextEditingController detalle = TextEditingController();

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    direccion.dispose();
    detalle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final media=MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          GestureDetector(
              onTap: () {
                /*Navigator.of(context).pushNamedAndRemoveUntil(
                    '/', (Route<dynamic> route) => false);
              */
                Navigator.of(context).pop();
                },
              child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(
                    Icons.clear,
                    size: 30.0,
                    color: Colors.black54,
                  )))
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
/*
          SliverToBoxAdapter(
            child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Registra tu lugar favorita de entregas',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold
                        ),),
                    )

                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Card(
              child: Container(
                height: 200.0,
                child: Column(
                  children: <Widget>[

                    Text('Direccion'),
                    Container(
                      height: 30.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white),
                      child: TextField(
                        controller: direccion,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            hintText: "Buscar direcciom ",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.place),
                              onPressed: () {},
                              iconSize: 20.0,
                            )),
                      ),
                    ),
                    Text('Detalle de direccion'),
                    Container(
                      height: 30.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white),
                      child: TextField(
                        controller: detalle,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                            hintText: "Ingresar detalles ",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 15.0),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {},
                              iconSize: 20.0,
                            )),
                      ),
                    ),

                    MaterialButton(
                        onPressed: () async {
                          UbicacionModel ubicacionModel= new UbicacionModel(idubicacion:0,ubicacion_nombre:direccion.text,ubicacion_comentarios: detalle.text,idusuario:UsuarioModel.idUsuario,ubicacion_estado:'activo' );

                          bool rpta= await creatUbicacionModel(ubicacionModel);
                          print(rpta);
                          setState(() {

                          });
                        },
                      child: Card(
                        color: Colors.deepOrange,
                        child: Container(
                          height: 50.0,
                          width: 100.0,
                          child: Center(child: Text('Agregar',style: TextStyle(color: Colors.white),)),
                        ),
                      )
                    )

                  ],
                ),
              ),
            ),
          ),
*/
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    'Ubicaciones',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    'Actual',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.1,
             height:
             media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.1 :MediaQuery.of(context).size.height * 0.15,

              child: Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: new BoxDecoration(
                          // color: Colors.orange,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black54)),
                      child: Icon(
                        Icons.location_searching,
                        color: Colors.black54,
                        size: 20,
                      ),
                    ),
                    title: Text(ubicacionActual),
                    /*  trailing:
                              FlatButton.icon(
                                  onPressed: ()async{
                                    bool respuesta= await eliminarUbicacionModel(snapshot.data[index]);
                                    print((respuesta).toString()+ 'eliminado');
                                  },
                                  icon:Icon(Icons.delete_outline),
                                  label: Text('')
                              )*/
                  )),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    'Lista de ubicaciones',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.35,
              height:
              media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.35 :MediaQuery.of(context).size.height * 0.6,

              child: FutureBuilder<List<UbicacionModel>>(
                  future: fetchUbicacionModel(
                      http.Client(), (UsuarioModel.idUsuario).toString()),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Container(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  return

                                    Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () async {
                                          bool respuesta =
                                              await actualizarUbicacionModel(
                                                  snapshot.data[index]);
                                          print((bool).toString());

                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/',
                                                  (Route<dynamic> route) =>
                                                      false);

                                          setState(() {});
                                        },
                                        child: Container(
                                          width:MediaQuery.of(context).size.width*0.7,
                                          child: Card(

                                            child: ListTile(
                                              leading: Container(
                                                height: 30.0,
                                                width: 30.0,
                                                decoration: new BoxDecoration(
                                                  // color: Colors.orange,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.black54
                                                    )
                                                ),
                                                child: Icon(Icons.location_searching,color:Colors.black54,size: 20.0,),
                                              ),
                                              title: Text(snapshot
                                                  .data[index].ubicacion_nombre),
                                            ),
                                          )
                                        )
                                      ),
                                      FlatButton.icon(
                                          onPressed: () async {
                                            bool respuesta =
                                                await eliminarUbicacionModel(
                                                    snapshot.data[index]
                                                        .idubicacion);
                                            print((respuesta).toString() +
                                                'eliminado');

                                            setState(() {
                                              snapshot.data.removeAt(index);
                                            });
                                          },
                                          icon: Icon(Icons.delete_outline),
                                          label: Text(''))
                                    ],
                                  );

                                  /*Card(
                                      color:Colors.white,
                                      child:Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: ()async{

                                                bool respuesta= await actualizarUbicacionModel(
                                                    snapshot.data[index]
                                                );
                                                print((bool).toString());

                                                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

                                                setState(() {
                                                });
                                              },
                                              child: ListTile(
                                                leading: Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  decoration: new BoxDecoration(
                                                    // color: Colors.orange,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.black54
                                                      )
                                                  ),
                                                  child: Icon(Icons.location_searching,color:Colors.black54,size: 20.0,),
                                                ),
                                                title: Text(snapshot.data[index].ubicacion_nombre),
                                                // trailing:

                                              )
                                          ),
                                          FlatButton.icon(
                                              onPressed: ()async{
                                                bool respuesta= await eliminarUbicacionModel(snapshot.data[index].idubicacion);
                                                print((respuesta).toString()+ 'eliminado');

                                                setState(() {
                                                  snapshot.data.removeAt(index);

                                                });
                                              },


                                              icon:Icon(Icons.delete_outline),
                                              label: Text('')
                                          )


                                        ],
                                      )
                                  );
*/
                                  /* Container(
                                    child:Row(
                                      children: <Widget>[

                                        GestureDetector(
                                          onTap: ()async{

                                            bool respuesta= await actualizarUbicacionModel(
                                                snapshot.data[index]
                                            );
                                            print((bool).toString());

                                            Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

                                            setState(() {
                                            });
                                          },
                                          child: Card(
                                              color:Colors.white,
                                              child:Row(
                                                children: <Widget>[
                                                  GestureDetector(
                                                  onTap: ()async{

                                          bool respuesta= await actualizarUbicacionModel(
                                          snapshot.data[index]
                                          );
                                          print((bool).toString());

                                          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

                                          setState(() {
                                          });
                                          },
                                                    child: ListTile(
                                                      leading: Container(
                                                        height: 30.0,
                                                        width: 30.0,
                                                        decoration: new BoxDecoration(
                                                          // color: Colors.orange,
                                                            shape: BoxShape.circle,
                                                            border: Border.all(
                                                                color: Colors.black54
                                                            )
                                                        ),
                                                        child: Icon(Icons.location_searching,color:Colors.black54,size: 20.0,),
                                                      ),
                                                      title: Text(snapshot.data[index].ubicacion_nombre),
                                                      // trailing:

                                                    )
                                                  ),
                                                  FlatButton.icon(
                                                      onPressed: ()async{
                                                        bool respuesta= await eliminarUbicacionModel(snapshot.data[index].idubicacion);
                                                        print((respuesta).toString()+ 'eliminado');

                                                        setState(() {
                                                          snapshot.data.removeAt(index);

                                                        });
                                                      },


                                                      icon:Icon(Icons.delete_outline),
                                                      label: Text('')
                                                  )


                                                ],
                                              )
                                          ),
                                        ),



                                      ],

                                    )
                                  );*/
                                }),
                          ));
                    } else {
                      return Container(
                        child: Text('Cargando'),
                      );
                    }
                  }),
            ),
          ),


          SliverToBoxAdapter(
            child: Container(
              height: //MediaQuery.of(context).size.height * 0.15,
              media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.25,

              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Container(
                          height: 60.0,
                          width: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Colors.deepOrange,
                            ),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.location_on,
                              //    color:GREENCART
                              color: Colors.deepOrange,
                            ),
                          )),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, top: 12.0, bottom: 25.0),
                    child: RaisedButton(
                      onPressed: () async {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/OrderScreen', ModalRoute.withName('/'),
                            arguments: UsuarioModel.idUsuario);
                        // Navigator.of(context).pushNamedAndRemoveUntil('/SearchResultScreen', ModalRoute.withName('/'),arguments: suggestionList[index]);
                      },
                      // color: GREENCART,
                      color: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: Container(
                          width: 200.0,
                          child: Center(
                              child: Row(
                            children: <Widget>[
                              // Icon(Icons.library_books,color: Colors.white,),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  'Registrar Ubicacion',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                ),
                              )
                            ],
                          ))),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
