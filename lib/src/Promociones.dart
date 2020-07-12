
import 'package:flutter/material.dart';

class Promociones extends StatelessWidget {
  final double heightScrenn;

  const Promociones({Key key, this.heightScrenn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: heightScrenn,
         // color: Colors.deepOrangeAccent,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context,int index) {

                return Container(
                  decoration: new BoxDecoration(
                      color: Colors.black26,
                      borderRadius: new BorderRadius.only(
                          topLeft:  const  Radius.circular(10.0),
                          topRight: const  Radius.circular(10.0),
                         bottomLeft: const  Radius.circular(10.0),
                        bottomRight: const  Radius.circular(10.0),

                      )

                  ),
                  margin: EdgeInsets.all(5.0),
                  width: 170.0,
                  //color: Colors.tealAccent,

                );

              }
          ),
        ),
      ],
    );
  }

}

/*
*     GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LocationScreen(),
                  ));
            },
            child: FutureBuilder<UbicacionModel>(
              future: showUbicacionActual(http.Client(), (1).toString()),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    height: 40.0,
                    width: 60,
                    //color: Colors.blue,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          //right:2.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  snapshot.data.ubicacion_nombre,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),

         Icon(Icons.keyboard_arrow_down,color: Colors.black,size: 20.0,),
          GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0),
                child: Image.asset(
                  'assets/LogoColor.png',
                  height: 40.0,
                ),
              )
          ),
*
* */