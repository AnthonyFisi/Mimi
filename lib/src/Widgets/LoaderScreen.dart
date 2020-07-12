
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tienda_mimi/src/Screen/AfterCheckoutScreen.dart';
import 'package:tienda_mimi/src/Widgets/ColorLoader.dart';
import 'package:tienda_mimi/src/Widgets/dot_type.dart';

class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {


  @override
  void initState() {
    super.initState();

    startTimer();

  }

  startTimer() async {
    var duration = Duration(seconds:5);
    return new Timer(duration, route);
  }

  route() async {


    Navigator.of(context).pushNamedAndRemoveUntil('/AfterCheckoutScreen',  ModalRoute.withName('/'));


    /*Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => AfterCheckoutScreen()
    )
    );*/
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: AlignmentDirectional.center,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 200.0,
            ),

            Container(
              height: 100.0,width: 100.0,
              color: Colors.white,
              child: Image.asset('assets/comercio.png',fit: BoxFit.contain,),
            ),
            Container(
                alignment: AlignmentDirectional.bottomCenter,
                child:Text('Cargando venta ',style: TextStyle(color: Colors.black26,fontSize: 18),)
            ),


            Container(
              color: Colors.white,
              height: 100.0,
              child: ColorLoader5(
                dotOneColor: Colors.blue[400],
                dotTwoColor: Colors.blue[400],
                dotThreeColor:  Colors.blue[400],
                dotType: DotType.circle,
                dotIcon: Icon(Icons.adjust,size: 30.0,),
                duration: Duration(seconds: 1),
              ),
            )

          ],
        ),
      ),
    );
  }
}
