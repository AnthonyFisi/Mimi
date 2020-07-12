import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Api/TipoPagoApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Api/VentaApi.dart';
import 'package:tienda_mimi/Service/Model/HorarioModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/TipoPago.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/Service/Model/VentaModel.dart';
import 'package:tienda_mimi/src/Screen/AfterCheckoutScreen.dart';
import 'package:tienda_mimi/src/Screen/PayMethodScreen.dart';
import 'package:tienda_mimi/src/Screen/SuccsesfullSellScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:http/http.dart' as http;



class CheckOutScreen extends StatefulWidget {
  final HorarioModelCompleto horarioModelCompleto;

  const CheckOutScreen({Key key, @required this.horarioModelCompleto}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState(horarioModelCompleto);
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  final HorarioModelCompleto horarioModelCompleto;

  double costoTotal=0;
  String TipoPago_nombre="Efectivo";
  Color col=Colors.white;
  int _index=1;
  int idtipoPago=1;
  int idUbicacion=1;
  String nombre='';
  String dia='';
  String comentarios='Ejm: Casa de color roja,pagare con 50 soles ,etc.';

  List<String> dias=['Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo'];

  _CheckOutScreenState(this.horarioModelCompleto);
  @override

  void initState(){
    super.initState();
    int i =(horarioModelCompleto.fecha).weekday;
    dia=dias.elementAt(i-1);
    print((horarioModelCompleto.fecha).toString().substring(0,10)+' '+
        horarioModelCompleto.horario_nombre.substring(1,6)+':00');
    print(DateTime.now().toString());
  }




 Future<TipoPago> createAlertDialogo(BuildContext context){

    TipoPago tipoPagoModel;
   return showDialog(context: context,builder:(context){
     return AlertDialog(
       title: Text("Escoger Tipo de pago"),
       content: Container(
         height: 300.0,
         child: FutureBuilder<List<TipoPago>>(
             future:fetchTipoPago(http.Client()),
             builder: ( context,  snapshot) {
               if (snapshot.data != null) {
                 return Container(
                 child: ListView.builder(
                 itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                   return GestureDetector(
                     onTap: (){
                       setState(() {
                        // col=Colors.lightGreenAccent;

                         tipoPagoModel =new TipoPago(
                           idtipopago: snapshot.data[index].idtipopago,
                           tipopago_nombre: snapshot.data[index].tipopago_nombre
                         );

                         Navigator.of(context).pop(tipoPagoModel);

                       });
                     },
                     child: Card(
                        color: col,
                       child:Container(
                         height: 50.0,
                           child: Column(
                             children: <Widget>[
                               Text(snapshot.data[index].tipopago_nombre),
                             ],
                           ))
                     ),
                   );
                 }

                 ),
                 );
              }else{
                 return Container(
                   child: Text('Cargando'),
                 );
               }
             }
         ),
       ),
       actions: <Widget>[
        /* MaterialButton(
           elevation:5.0,
           child: Container(
             height: 10.0,
               child: Text('confirmar')
           ),
           onPressed: (){
             Navigator.of(context).pop(ubicacionModel);
           },
         ),*/
       ],

     );
   });
 }


  openBottomSheet(BuildContext context) {
    TextEditingController comentario= TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Text('Comentarios',style: TextStyle(color: Colors.black38,fontSize: 20),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:5.0,right: 5.0),
                  child: Container(
                      height: 150.0,
                      color: Colors.white,
                      child: TextField(

                        maxLines: 20,
                        controller: comentario,
                        decoration: InputDecoration(
                          fillColor: Colors.black12,
                          hintText: "Ingresar detalles de la compra",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0),
                        ),
                      )
                  ),
                ),

                Padding(
                    padding:EdgeInsets.all(10.0),
                  child: Container(
                      height: 50.0,
                      child:  RaisedButton(
                        onPressed: (){
                          Navigator.of(context).pop(comentario);
                        },
                        child: Text('Aceptar',style: TextStyle(color: Colors.white),),
                        color: Colors.lightBlueAccent,
                      )
                  )
                )

              ],
            ),
          );
        });
  }

  openBottomSheet2(BuildContext context) {
    TextEditingController comentario= TextEditingController();
    showModalBottomSheet(
        isDismissible:false,
        isScrollControlled:true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            child: Column(
              children: <Widget>[

                Container(
                  height: 100.0,
                  child: Center(
                    child: Image.asset('assets/succes.png',height: 50.0,width: 50.0,),
                  ),
                ),

                Text('Gracias por tu compra '),

                Padding(
                  padding: const EdgeInsets.only(top:0.0),
                  child: Row(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(left:80.0),
                        child: RaisedButton(

                          onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                          },
                          child: Text('Inicio'),
                          color: Colors.orange,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left:20.0),
                        child: RaisedButton(

                          onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil('/OrderScreen',
                                ModalRoute.withName('/'),arguments: UsuarioModel.idUsuario);


                          },
                          child: Text('Ver Orden'),
                          color: Colors.orange,
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          );
        });
  }



  Future<String> createAlertDialogoComentarios(BuildContext context){

    TextEditingController comentario= TextEditingController();
    return showDialog(context: context,builder:(context){
      return AlertDialog(
        title: Text("Ingresar comentarios"),
        content: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          height: 200.0,
          child: TextField(
            maxLines: 20,
            controller: comentario,
            decoration: InputDecoration(

              fillColor: Colors.blue,
              hintText: "Ingresar detalles de la compra",
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: 15.0),
            ),
          )
        ),
        actions: <Widget>[
           MaterialButton(
           elevation:5.0,
           child: Container(
               child: Text('confirmar')
           ),
           onPressed: (){
             Navigator.of(context).pop(comentario.text);
           },
         ),
        ],

      );
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

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
            child: Text(' Completar de compra',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          actions: <Widget>[
          ],
        ),

      body: CustomScrollView(
        slivers: <Widget>[
/*
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(5, 175, 242, 1),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:Padding(
                    padding: EdgeInsets.only(
                      right: 20.0,
                    ),
                    child:  Icon(
                      Icons.clear,
                      size: 25,
                      color: Colors.white,
                    ),
                  )
              )
            ],
          ),
          SliverAppBar(
            automaticallyImplyLeading: false,

            backgroundColor: Colors.white,
            actions: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                },
                child:  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child:Icon(Icons.clear,color: Colors.black,)
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child:  Container(
              height: 125.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/checkoutWallpape3.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(padding: EdgeInsets.all(10.0),
                child: Text('Completar compra',style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
              /*
                        child: Card(
                        //color: Color.fromRGBO(5, 175, 242, 1),
                        color:Color.fromRGBO(88, 204, 167, 1),
                        child: ListTile(

                          subtitle: Text('Carrito de compra',style: TextStyle(fontSize: 25,color: Colors.white),),
                          trailing: Padding(
                              padding:EdgeInsets.only(bottom: 2.0),
                            child:Icon(Icons.clear,color: Colors.white,size: 25,),
                          ),
                        ),
                      ),
                      */

            ),
          ),

          SliverToBoxAdapter(

            child: Padding(
              padding: EdgeInsets.only(left:10.0),
             child: Container(
              height: 40.0,
              decoration: new BoxDecoration(
                color:Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft:  const  Radius.circular(0.0),
                  topRight: const  Radius.circular(0.0),
                  bottomLeft: const  Radius.circular(0.0),
                  bottomRight: const  Radius.circular(20.0),

                ),
              ),
              child: Text('Completar compra',style: TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold),),
            ),
            ),
          ),
          */



          SliverToBoxAdapter(
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:1.0),
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[

                            //Image.asset('assets/billetera.png',height: 25.0,width: 25.0,),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('Tipo de pago ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),
                            ),
                          ],
                        )),
                  ),

                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text(TipoPago_nombre),
                    trailing: IconButton(
                        icon: Icon(Icons.mode_edit,color: Colors.black38,size: 25,),
                        onPressed: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PayMethodScreen()
                            ),
                          );
                          /*
                          createAlertDialogo(context).then((onValue){
                            print(onValue.tipopago_nombre);
                            setState(() {
                              TipoPago_nombre=onValue.tipopago_nombre;
                              idtipoPago=onValue.idtipopago;
                            });
                          });
                       */
                        }
                    )
                  )
                  /*Padding(
                    padding: const EdgeInsets.only(left:1.0),
                    child: Container(
                      color:Colors.white,
                      height: 40.0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Text(TipoPago_nombre),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.52),
                            child: GestureDetector(
                              onTap: (){
                                createAlertDialogo(context).then((onValue){
                                  print(onValue.tipopago_nombre);
                                  setState(() {
                                    TipoPago_nombre=onValue.tipopago_nombre;
                                    idtipoPago=onValue.idtipopago;
                                  });
                                });
                              },
                              child: Card(
                                child: Container(
                                    width: 80.0,
                                    child:Center(
                                      child: Text('Cambiar',style: TextStyle(color: Colors.lightBlueAccent),),

                                    )),
                                shape: RoundedRectangleBorder(
                                    side: new BorderSide(color:Colors.lightBlueAccent, width: 1.0),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),




          SliverToBoxAdapter(
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:1.0),
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[

                            // Image.asset('assets/mapa.png',height: 25.0,width: 25.0,),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('Ubicacion ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),
                            ),
                          ],
                        )),
                  ),

                  ListTile(
                    leading: Icon(Icons.location_on),
                    title:FutureBuilder<UbicacionModel>(
                      future: showUbicacionActual(http.Client(),UsuarioModel.idUsuario.toString()),
                      builder: (context,snapshot){
                        if(snapshot.data !=null){
                          idUbicacion=snapshot.data.idubicacion;
                          return Text( snapshot.data.ubicacion_nombre,style: TextStyle(color: Colors.black,fontSize: 15.0),);

                        }else{
                          return Container(
                          );
                        }
                      },
                    )
                  )
              /*
                  Padding(
                    padding: EdgeInsets.only(left:10.0),
                    child:Container(
                        height: 60.0,
                        child: Stack(
                          children: <Widget>[

                            Padding(
                              padding:EdgeInsets.only(top:15.0),
                              child:FutureBuilder<UbicacionModel>(
                                future: showUbicacionActual(http.Client(),UsuarioModel.idUsuario.toString()),
                                builder: (context,snapshot){
                                  if(snapshot.data !=null){
                                    idUbicacion=snapshot.data.idubicacion;
                                    return Text( snapshot.data.ubicacion_nombre,style: TextStyle(color: Colors.black,fontSize: 15.0),);

                                  }else{
                                    return Container(
                                    );
                                  }
                                },
                              ),
                            )

                          ],
                        )


                    ),

                  ),
                  */
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Card(
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(left:1.0),
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('Fecha de entrega ',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),
                            ),
                          ],
                        )),
                  ),

                  ListTile(
                    leading: Icon(Icons.date_range),
                    title: Row(

                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.only(left:5.0),
                          child: Text(dia),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(horarioModelCompleto.horario_nombre),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:1.0),
                          child: Text( ((horarioModelCompleto.fecha).year).toString() + '-'+
                              ((horarioModelCompleto.fecha).month).toString() + '-'+
                              ((horarioModelCompleto.fecha).day).toString()
                          ),
                        )

                      ],
                    ),
                  ),
                  /*
                  Padding(
                    padding: EdgeInsets.only(left:10.0),
                    child:Container(
                        height: 40.0,
                        child: Stack(
                          children: <Widget>[

                            Padding(
                              padding:EdgeInsets.only(top:10.0),
                              child:Row(

                                children: <Widget>[

                                  Padding(
                                    padding: const EdgeInsets.only(left:5.0),
                                    child: Text(dia),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(horarioModelCompleto.horario_nombre),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:1.0),
                                    child: Text( ((horarioModelCompleto.fecha).year).toString() + '-'+
                                        ((horarioModelCompleto.fecha).month).toString() + '-'+
                                        ((horarioModelCompleto.fecha).day).toString()
                                    ),
                                  )

                                ],
                              )
                            )

                          ],
                        )


                    ),

                  ),
                  */

                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:1.0),
                    child: Container(
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text('Comentarios',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),
                            ),
                          ],
                        )),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title:Text(comentarios,style: TextStyle(color: Colors.black26),) ,
                    trailing:IconButton(
                        icon: Icon(Icons.mode_edit),
                        onPressed: ()  {

                          openBottomSheet(context);


                          /*
                          createAlertDialogoComentarios(context).then((onValue){
                            setState(() {

                              print(onValue);
                              comentarios=onValue;

                            });
                          });*/
                        }
                    ) ,
                  )
              /*
                  Container(
                      color: Colors.white,
                      height: 40.0,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:15.0),
                            child: Container(width:200.0,child: Text(comentarios,style: TextStyle(color: Colors.black26),)),
                          ),

                          Padding(
                            padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width*0.15),
                            child: GestureDetector(
                              onTap: (){


                                createAlertDialogoComentarios(context).then((onValue){
                                  setState(() {

                                    print(onValue);
                                    comentarios=onValue;

                                  });
                                });
                              },
                              child: Icon(Icons.mode_edit)
                              /*Card(
                                child: Container(
                                    width:60.0,
                                    child: Center(child: Text('Añadir',style: TextStyle(color: Colors.lightBlueAccent),))),
                                shape: RoundedRectangleBorder(
                                    side: new BorderSide(color:Colors.lightBlueAccent, width: 1.0),
                                    borderRadius: BorderRadius.circular(4.0)
                                ),
                              ),*/
                            ),
                          ),
                        ],
                      )
                  ),
                  */
                ],
              ),
            ),
          ),

      SliverToBoxAdapter(
        child: Card(
          child: Column(
            children: <Widget>[

              Container(
                child:Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left:1.0,),
                    child: Text('Resumen de Pedido',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black45),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:10.0,),
                child:
                Row(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height*0.1,
                      width: MediaQuery.of(context).size.width*0.6,
                      alignment: AlignmentDirectional.topStart,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left:1.0,),
                            child: Text('Total productos',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0,),
                            child: Text('Costo delivery',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0,),
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
     costoTotal=snapshot.data.pedido_montototal+5;

     return  Padding(
       padding: const EdgeInsets.only(left:1.0,),
       child: Text(snapshot.data.pedido_montototal.toString(),style: TextStyle(fontSize: 15.0,color: Colors.black),),
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
                            child: Text('5',style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0,),
                            child: Text(costoTotal.toString(),style: TextStyle(fontSize: 15.0,color: Colors.black),),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
        ],
      ),
        bottomNavigationBar: Container(
          height: 100.0,
          // color: Colors.orangeAccent,
          child: Row(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left:20.0,bottom:10.0),
                child: Container(
                    height: 60.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color:Color.fromRGBO(5, 175, 242, 1),),
                      color:Colors.white,
                    ),
                    child: FutureBuilder<PedidoRealModel>(
                        future: fetchPedidoReal(http.Client(),(UsuarioModel.idUsuario).toString()),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            if(snapshot.data.pedido_estado !='Atendido'){
                             // UsuarioModel.cantidadTotal=snapshot.data.pedido_cantidadtotal;
                              return Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Center(//(num.toStringAsFixed(2)
                                    child: Text('S/. '+(snapshot.data.pedido_montototal).toStringAsFixed(2)
                                      ,style: TextStyle(color: Colors.black,fontSize: 20.0,fontWeight: FontWeight.bold),),
                                  )
                              );
                            }else{
                              return Container(
                              );
                            }
                          } else {
                            return Container(
                            );
                          }
                        }
                    )
                ),
              ),

              Padding(
                padding: EdgeInsets.only(left:10.0,top:15.0,bottom:25.0),
                child:RaisedButton(
                  onPressed:() async {
                    VentaModel venta= new VentaModel(
                        idPedido  : 0,
                        idtipopago : idtipoPago,
                        idubicacion : idUbicacion,
                        idhorario  : horarioModelCompleto.idhorario,
                        venta_estadoPago:'SinCancelar' ,
                        venta_costodelivery :5.0 ,
                        venta_costoTotal : costoTotal,
                        venta_fechaEntrega :((horarioModelCompleto.fecha).toString().substring(0,10)+' '+
                            horarioModelCompleto.horario_nombre.substring(1,6)+':00'),
                        venta_fecha  : (new DateTime.now()).toString(),
                        comentario: comentarios
                    );
                    print('objeto');
                    print((venta.venta_fecha).toString());
                    print((venta.idtipopago).toString());
                    bool respuesta= await createVenta(venta,UsuarioModel.idUsuario);

                   waiting2(context);
                   await Future.delayed(Duration(seconds: 4));
                   Navigator.of(context).pop();
                    if(respuesta){
                      openBottomSheet2(context);
                      //waiting(context);
                      //await Future.delayed(Duration(seconds: 5));

                      Navigator.of(context).pushNamedAndRemoveUntil('/AfterCheckoutScreen',  ModalRoute.withName('/'));
                      //Navigator.of(context).pushNamedAndRemoveUntil('/LoaderScreen',  ModalRoute.withName('/'));


                    }
                  },
                  color:Color.fromRGBO(5, 175, 242, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Container(
                      width: 180.0,
                      child: Center(
                        child: Text('Comprar',style: TextStyle(color: Colors.white,fontSize: 25.0),),
                      )
                  ),
                ),
              )

            ],
          ),
        )

    );
  }
}

waiting2(BuildContext context){
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          backgroundColor: Colors.transparent,
          content:
          SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 100.0,
                  color: Colors.transparent,
                  child:Center(
                      child: CircularProgressIndicator(
                        // valueColor: Color.fromRGBO(0, 0, 0, 0),
                        backgroundColor: Colors.greenAccent,
                        strokeWidth: 5,)
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: Center(
                      child: Text('Cargando ...',style: TextStyle(fontSize: 25.0,color:Colors.white),),
                    )
                )

              ],
            ),
          ),

        );
      }
  );
}

waiting(BuildContext context){
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 300.0,
                  child: Column(
                    children: <Widget>[

                      Image.asset('assets/good2.gif',
                        height: 300.0,
                        width: 400.0,
                        fit: BoxFit.cover,

                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top:10.0),
                    child: Center(
                      child: Text('Compra exitosa',style: TextStyle(fontSize: 25.0),),
                    )
                )
              ],
            ),
          ),
        );
      }
  );
}
