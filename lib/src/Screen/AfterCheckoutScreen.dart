import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Api/UsuarioApi.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/OrderScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';


class AfterCheckoutScreen extends StatefulWidget {
  @override
  _AfterCheckoutScreenState createState() => _AfterCheckoutScreenState();
}

class _AfterCheckoutScreenState extends State<AfterCheckoutScreen> {
  UsuarioApi usuarioApi=new UsuarioApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child:IconButton(
                  icon:Icon(Icons.clear,size: 30.0,color: Colors.black54,),
                  onPressed:(){
                    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                  }
              )
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[

          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.28,
              child: Column(
                children: <Widget>[

                  Padding(
                      padding: EdgeInsets.only(top:50.0),
                      child:Image.asset(
                        'assets/succes.png',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                  )
                ],
              )
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Column(
              children: <Widget>[
                Text('Gracias por tu ',style: TextStyle(color: Colors.amber[800],fontSize: 25.0,fontWeight: FontWeight.bold)),
                FutureBuilder<UsuarioModel>(
                    future: usuarioApi.fetchUsuariofindById(
                        http.Client(), (UsuarioModel.idUsuario).toString()),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                       // return
                          //Text(snapshot.data.Usuario_nombre,style: TextStyle(color:Colors.amber[800],fontSize: 25.0,fontWeight: FontWeight.bold));
                        return Text('compra'
                            ,style: TextStyle(color: Colors.amber[800],fontSize: 25.0,fontWeight: FontWeight.bold)
                        );

                      }else{
                        return Text('');
                      }
                    }
                    ),

                Padding(padding: EdgeInsets.only(top:20.0),
                    child: Text('Puedes verificar el delivery ',
                        style: TextStyle(color:Colors.black26,fontSize: 15.0,fontWeight: FontWeight.bold)
                    ),
                ),
                Padding(padding: EdgeInsets.only(top:0.0),
                  child: Text(' en la seccion de Ordenes',
                      style: TextStyle(color:Colors.black26,fontSize: 15.0,fontWeight: FontWeight.bold)
                  ),

                )

              ],
            )),
          ),
/*
          SliverToBoxAdapter(
            child: Container(
             child: Padding(
               padding: EdgeInsets.only(left:10.0,top:12.0,bottom:25.0),
               child:RaisedButton(
                 onPressed:() async {
                   Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                   // Navigator.of(context).pushNamedAndRemoveUntil('/SearchResultScreen', ModalRoute.withName('/'),arguments: suggestionList[index]);


                   /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderScreen (idUsuario: UsuarioModel.idUsuario,),
                          ),
                        );*/

                 },
                 color: Colors.white,

                 shape: RoundedRectangleBorder(
                   borderRadius: new BorderRadius.circular(10.0),
                   side: BorderSide(color:Color.fromRGBO(5, 175, 242, 1)),
                 ),
                 child: Container(
                     width: 180.0,
                     child: Center(
                         child: Row(
                           children: <Widget>[
                             Icon(Icons.home,color: Color.fromRGBO(5, 175, 242, 1),),
                             Padding(
                               padding:EdgeInsets.only(left:5.0),
                               child: Text('Inicio',style: TextStyle(color:Color.fromRGBO(5, 175, 242, 1),fontSize: 20.0),),
                             )

                           ],
                         )
                     )
                 ),
               ),
             ),

            ),
          ),
*/
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top:50.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.18,
                child: Column(
                  children: <Widget>[
                    /*
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);


                    },
                    child:Padding(
                      padding: EdgeInsets.only(left:20.0,bottom:10.0),
                      child: Container(
                          height: 60.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color:GREENCART),
                            color:Colors.white,
                          ),
                          child:Center(
                            child: Icon(Icons.home,color:GREENCART),
                          )
                      ),
                    ),

                  ),
                  */
                    Container(
                      height:MediaQuery.of(context).size.height * 0.08 ,
                      child: RaisedButton(
                        onPressed:() async {
                          Navigator.of(context).pushNamedAndRemoveUntil('/OrderScreen', ModalRoute.withName('/'),arguments: UsuarioModel.idUsuario);
                          // Navigator.of(context).pushNamedAndRemoveUntil('/SearchResultScreen', ModalRoute.withName('/'),arguments: suggestionList[index]);


                          /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderScreen (idUsuario: UsuarioModel.idUsuario,),
                          ),
                        );*/

                        },
                        color: Color.fromRGBO(5, 175, 242, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Container(
                            width: 250.0,
                            child:Row(
                              children: <Widget>[
                                /* Flexible(
                                  child: Icon(Icons.library_books,color: Colors.white,),
                                ),*/
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 50,
                                  child: Icon(Icons.library_books,color: Colors.white,),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 200,
                                  child: Text('Verificar mi orden',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                ),

                                /*  Expanded(
                                  child: Text('Verificar mi orden',style: TextStyle(color: Colors.white,fontSize: 20.0),),
                                )*/


                              ],
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:10),
                      child:Container(
                        height:MediaQuery.of(context).size.height * 0.08 ,
                        child: RaisedButton(
                    onPressed:() async {
                      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                      // Navigator.of(context).pushNamedAndRemoveUntil('/SearchResultScreen', ModalRoute.withName('/'),arguments: suggestionList[index]);


                      /*  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OrderScreen (idUsuario: UsuarioModel.idUsuario,),
                          ),
                        );*/

                    },
                    color: Colors.white,

                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                      side: BorderSide(color:Colors.white/*Color.fromRGBO(5, 175, 242, 0.5)*/),
                    ),
                    child: Container(
                        width: 250.0,
                        child: Center(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 50,
                                  child: Icon(Icons.home,color: Color.fromRGBO(5, 175, 242,1),),
                                ),
                                Container(
                                  alignment: AlignmentDirectional.center,
                                  width: 200,
                                  child: Text('Inicio',style: TextStyle(color:Color.fromRGBO(5, 175, 242, 1),fontSize: 20.0),),
                                ),



                              ],
                            )
                        )
                    ),
                  ),
                      ),
                    )


                  ],
                ),
              ),
            )
          )


        ],
      ),
    );
  }
}
waiting2(BuildContext context){
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
                  //color: Colors.deepOrange,
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
                      child: Text('',style: TextStyle(fontSize: 25.0),),
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
                //Image.network('https://media1.tenor.com/images/06ae072fb343a704ee80c2c55d2da80a/tenor.gif'),
                Container(
                  height: 300.0,
                  color: Colors.deepOrange,
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