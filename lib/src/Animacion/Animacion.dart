import 'package:flutter/material.dart';

const owl_url = 'https://raw.githubusercontent.com/flutter/website/master/src/images/owl.jpg';

class FadeInDemo extends StatefulWidget {
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacityLevel = 0.0;

  bool _isFavorited = true;
  int _favoriteCount = 41;
  String _estado='Me gusta';

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        _estado='No Me gusta';
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
        _estado='Me gusta';
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        height: 100.0,
        width: 300.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(1),
              child: IconButton(
                icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
                color: Colors.red[500],
                onPressed: _toggleFavorite,
              ),
            ),
            SizedBox(
              width: 100,
              child: Container(
                child: Row(
                  children: <Widget>[
                    Text('$_favoriteCount'),
                    Text(_estado),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );


    /*Column(children: <Widget>[

      Image.network(owl_url),
      MaterialButton(
        child: Text(
          'Show details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => setState(() {
          opacityLevel = 1.0;
        }),
      ),

      AnimatedOpacity(
        duration: Duration(seconds: 3),
        opacity: opacityLevel,
        child: Column(
          children: <Widget>[
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      ),



    ]);*/


  }
}