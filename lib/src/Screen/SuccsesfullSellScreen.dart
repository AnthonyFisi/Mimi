
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Screen/OrderScreen.dart';

class SuccsesfullSellScreen extends StatefulWidget {
  @override
  _SuccsesfullSellScreenState createState() => _SuccsesfullSellScreenState();
}

class _SuccsesfullSellScreenState extends State<SuccsesfullSellScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500.0,
        child: Column(
          children: <Widget>[

            Container(
              height: 300.0,
              child: Center(
                child: Image.asset('assets/succes.png',height: 100.0,width: 100.0,),
              ),
            ),

            Text('Gracias por tu compra '),

            Padding(
              padding: const EdgeInsets.only(top:100.0),
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

      ),
    );
  }
}


