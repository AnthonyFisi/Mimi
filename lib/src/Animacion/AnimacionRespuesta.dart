import 'package:flutter/material.dart';

class AnimacionRespuesta extends StatefulWidget {
  @override
  _AnimacionRespuestaState createState() => _AnimacionRespuestaState();
}

class _AnimacionRespuestaState extends State<AnimacionRespuesta> {

  double opacityLevel = 0.0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 200.0,
        child: Stack(
          children: <Widget>[


            Positioned(
              left: 10.0,
              bottom: 50.0,
              child: MaterialButton(
                child: Text(
                  'Agregar',
                  style: TextStyle(color: Colors.blueAccent),
                ),
                onPressed: () => setState(() {
                  opacityLevel = 1.0;
                }),
              ),
            ),


            Positioned(
              
              child: AnimatedOpacity(
                duration: Duration(seconds: 1),
                opacity: opacityLevel,
                child: Column(
                  children: <Widget>[
                    Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/bd-comedor.appspot.com/o/cesta.png?alt=media&token=6d0a7f78-c838-4a7a-90d3-9c4c9350851d',scale: 1.0,
                    height: 100.0,
                      width: 100.0,
                    )
                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
