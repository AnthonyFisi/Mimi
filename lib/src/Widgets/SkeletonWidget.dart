import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatefulWidget {
  final String type;

  const Skeleton({Key key, this.type}) : super(key: key);

  //Skeleton({Key key, this.height , this.width }) : super(key: key);

  createState() => SkeletonState();
}

class SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
          parent: _controller,
          curve: Curves.linear
      ),
    )..addListener(() {
      setState(() {});
    });
   // _controller.repeat();

  }

  @override
  void didChangeDependencies() {
    _controller.repeat();

    super.didChangeDependencies();


  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TypeSkeleton(widget.type);
      /*
      Container(
      width:  widget.width,
      height: widget.height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
              begin: Alignment(gradientPosition.value, 0),
              end: Alignment(-1, 0),
              colors: [Colors.black12, Colors.black26, Colors.black12]
          )
      ),
    );
    */


  }


  Widget TypeSkeleton(String type){

    switch(type){

      case 'boxHome':
        return Container(
          width:  15,
          height: 15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                  begin: Alignment(gradientPosition.value, 0),
                  end: Alignment(-1, 0),
                  colors: [Colors.black12, Colors.black26, Colors.black12]
              )
          ),
        );

      case 'boxListCategories':
        return Container(
          width: 150.0,
          height: 290.0,
          child: Column(
            children: <Widget>[
              Container(
                width: 120,
                height:200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    gradient: LinearGradient(
                        begin: Alignment(gradientPosition.value, 0),
                        end: Alignment(-1, 0),
                        colors: [Colors.black12, Colors.black26, Colors.black12]
                    )
                ),
              ),

              Padding(
                  padding: EdgeInsets.only(top:5.0),
                child: Container(
                  width: 120,
                  height:30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          begin: Alignment(gradientPosition.value, 0),
                          end: Alignment(-1, 0),
                          colors: [Colors.black12, Colors.black26, Colors.black12]
                      )
                  ),
                ),
              )
            ],
          ),
        );


      case 'boxListShoppingCart':
        return Container(
          height: 90.0,
          child:Row (
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  height:80,
                  width: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          begin: Alignment(gradientPosition.value, 0),
                          end: Alignment(-1, 0),
                          colors: [Colors.black12, Colors.black26, Colors.black12]
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  width: 150,
                  height:90,
                  child: Column(
                    children: <Widget>[
                     Padding(
                        padding: EdgeInsets.only(top:10.0),
                        child:Container(
                          height:10,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: Alignment(gradientPosition.value, 0),
                                  end: Alignment(-1, 0),
                                  colors: [Colors.black12, Colors.black26, Colors.black12]
                              )
                          ),
                        ) ,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:10.0),
                        child:Container(
                          height:10,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: Alignment(gradientPosition.value, 0),
                                  end: Alignment(-1, 0),
                                  colors: [Colors.black12, Colors.black26, Colors.black12]
                              )
                          ),
                        ) ,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:10.0),
                        child:Container(
                          height:10,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: LinearGradient(
                                  begin: Alignment(gradientPosition.value, 0),
                                  end: Alignment(-1, 0),
                                  colors: [Colors.black12, Colors.black26, Colors.black12]
                              )
                          ),
                        ) ,
                      ),




                    ],
                  ),
                ),
              ),
              Padding(
              padding: EdgeInsets.all(10.0),
                child: Container(
                  height:20,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                          begin: Alignment(gradientPosition.value, 0),
                          end: Alignment(-1, 0),
                          colors: [Colors.black12, Colors.black26, Colors.black12]
                      )
                  ),
                ),
              )
            ],
          ),
        );

      case 'boxListSubcategoriesIcon':
        return Container(
          width:  50,
          height: 5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                  begin: Alignment(gradientPosition.value, 0),
                  end: Alignment(-1, 0),
                  colors: [Colors.black12, Colors.black26, Colors.black12]
              )
          ),
        );

      default :
        return Container(
          height: 10.0,
          width: 10.0,
          color: Colors.lightBlueAccent,
        );

    }

  }
}


