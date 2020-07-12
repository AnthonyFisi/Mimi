
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child:Icon(Icons.clear,size: 30.0,color: Colors.black54,)
          )
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[

          SliverToBoxAdapter(
              child: Container(
                  height: MediaQuery.of(context).size.height*0.1,
                  child: Padding(
                    padding: EdgeInsets.only(left:10.0),
                    child: Text('Notificaciones',style: TextStyle(color: Colors.black54,fontSize: 30.0)),
                  )
              )
          ),
          SliverToBoxAdapter(
              child: Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child:  Container(
                        height: 90.0,
                        width: 350,
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.black12,
                        )),
                  )
              )
          )

        ],
      ),
    );
  }
}
