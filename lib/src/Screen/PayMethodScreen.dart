import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/TipoPagoApi.dart';
import 'package:tienda_mimi/Service/Model/TipoPago.dart';
import 'package:http/http.dart' as http;

class PayMethodScreen extends StatefulWidget {
  @override
  _PayMethodScreenState createState() => _PayMethodScreenState();
}

class _PayMethodScreenState extends State<PayMethodScreen> {

  TipoPago tipoPagoModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
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
          child: Text(' Metodo de pago',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),),
        ),
        backgroundColor: Colors.white,
        elevation: 1.0,
        actions: <Widget>[
          /*
            Padding(
              padding: EdgeInsets.only(
                right: 20.0,
              ),
              child:  Icon(
                Icons.shopping_basket,
                size: 25,
                color: Colors.black38,
              ),
            )
          */
        ],

      ),

      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[

                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  color: Colors.white,
                  height: 30,
                  child: Text('Metodo de pago actual ', style: TextStyle(color: Colors.black45,fontSize: 20),),
                ),

                Container(
                  child: Card(
                    child: ListTile(
                      leading:Image.asset('assets/dinero.png'),
                      title: Text('Efectivo' , style: TextStyle(color: Colors.black45),),
                    ),
                  ),
                )

              ],
            ),
          ),

          Container(
            height: 400.0,
            child: ListView(
              children: <Widget>[

                Container(
                  color: Colors.white,
                  height: 60.0,
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text('Otros metodos de pago', style: TextStyle(color: Colors.black45,fontSize: 18),),
                ),

                Card(
                  child: ListTile(
                    leading:Image.asset('assets/american-express.png'),
                    title: Text('American Express' , style: TextStyle(color: Colors.black45),),
                  ),
                ),


                Card(
                  child: ListTile(
                    leading:Image.asset('assets/paypal.png'),
                    title: Text('Paypal' , style: TextStyle(color: Colors.black45),),
                  ),
                ),


                Card(
                  child: ListTile(
                    leading:Image.asset('assets/tarjeta-mastercard.png'),
                    title: Text('MasterCard' , style: TextStyle(color: Colors.black45),),
                  ),
                ),


                Card(
                  child: ListTile(
                    leading:Image.asset('assets/visa.png'),
                    title: Text('Visa' , style: TextStyle(color: Colors.black45),),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading:Image.asset('assets/western-union.png'),
                    title: Text('Western Union' , style: TextStyle(color: Colors.black45),),
                  ),
                ),



              ],
            ),
          )
/*
          Container(
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
                                elevation: 5.0,
                                 // color: col,
                                  child:Container(
                                      height: 50.0,
                                      child: Column(
                                        children: <Widget>[

                                          Card(
                                            child: ListTile(
                                              leading: Image.asset('assets/'),
                                              title: Tar,
                                            ),
                                          )
                                        ],
                                      )
                                  )
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
*/
        ],
      ),

    );
  }
}
