import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/PedidoApi.dart';
import 'package:tienda_mimi/Service/Model/CarritoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/src/Categories.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';



class ButtonAnimationWidget2 extends StatefulWidget {
  final int idProducto;
  final int cantidadAnimation;
  final double precio;
  final int idUsuario;
  final bool changeSize;


  const ButtonAnimationWidget2({Key key, this.idProducto, this.cantidadAnimation, this.precio, this.idUsuario,this.changeSize}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ButtonAnimationWidgetState(idProducto,cantidadAnimation,precio,idUsuario,changeSize);
  }
}


enum ScoreWidgetStatus {
  HIDDEN,
  BECOMING_VISIBLE,
  VISIBLE,
  BECOMING_INVISIBLE
}

class ButtonAnimationWidgetState extends State<ButtonAnimationWidget2> with TickerProviderStateMixin {

  double variable=10.0;
  double leftWidget=50.0;
  double topWidget=0.0;
  double rightWidget=20.0;
  double bottomWidget=0.0;
  Color colorChange2=WHITE;


  final int idProducto;
  final int cantidadAnimation;
  final double precio;
  final int idUsuario;
  final bool changeSize;

  bool showNextButton = true;
  bool showNameLabel = false;
  bool alignTop = false;
  bool increaseLeftPadding = false;
  bool showGreetings = false;
  bool showQuoteCard = false;
  String name = '';
  bool _isButtonDisabled = false;



  double screenWidth;
  double screenHeight;
  String quote;

  int cant=1;

  ButtonAnimationWidgetState(this.idProducto, this.cantidadAnimation, this.precio, this.idUsuario,this.changeSize);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    functionCantidad(cantidadAnimation);


  }

  void functionCantidad(int cantidad){

    if(cantidadAnimation>0){
      setState(() {
        _isButtonDisabled = !_isButtonDisabled;
        // showNextButton= !showNextButton;
        showNameLabel = true;
        alignTop = true;
        variable=250.0;
        colorChange2=Color.fromRGBO(5, 175, 242, 1);
        showQuoteCard = true;
        cant=cantidadAnimation;

      });

    }

  }




  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: changeSize ? 70.0 :50,
      width: 200.0,
      child: Stack(
        alignment: FractionalOffset.center,
       overflow: Overflow.visible,
        children: <Widget>[


          //getScoreButton(),
          _getAnimatedPositionWidget(),
          _getAnimatedPositionedButton()

        ],
      ),
    );
  }

  _getAnimatedPositionedButton() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 1),
      curve: Curves.easeInOut,
      top: variable,
      left: 30.0,
      right: 0.0,

      child: Padding(
        padding: const EdgeInsets.fromLTRB(50.0,0.0,20.0,0.0),
        child: GestureDetector(
          child: Container(
            width: 0.0,
            height: 30.0,
            // color: Colors.yellow,
            child: Card(child: Center(child: Text('Añadir',style: TextStyle(color: Color.fromRGBO(5, 175, 242, 1)),))),
          ),
          //onTapUp: onTapUp,
          //onTapDown: onTapDown,
          onTap: _isButtonDisabled ? null: () async{

            setState(() {
              _isButtonDisabled = !_isButtonDisabled;
              // showNextButton= !showNextButton;
              showNameLabel = true;

              alignTop = true;
              variable=250.0;
              colorChange2=Color.fromRGBO(5, 175, 242, 1);

              // UsuarioModel.cantidadTotal=UsuarioModel.cantidadTotal+1;

            });
            PedidoModel pedido= new PedidoModel(
                idProducto: idProducto,
                cantidad: 1,
                precio: (precio).toDouble(),
                idUsuario: idUsuario
            );

            bool rpta= await createPedido(pedido);
            print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());

            _increaseLeftPadding();
            _showGreetings();
            _showQuote();


          },

        ),
      ),

    );
  }




  _getAnimatedPositionWidget() {
    return AnimatedPositioned(
      width: 180,
      duration: Duration(microseconds: 1),
      curve: Curves.easeInOut,
      child: _getQuoteCardWidget(),
      top: changeSize ? 0.0 : 10.0,
      left:changeSize ? 0.0 :60.0,
    );
  }

  _getQuoteCardWidget() {
    return  Card(
      color: Colors.white,
      elevation: 1.0,
      child: _getAnimatedSizeWidget(),
    );
  }

  _getAnimatedSizeWidget() {
    return AnimatedSize(
      duration: Duration(microseconds: 1),
      curve: Curves.easeInOut,
      vsync: this,
      child: _getQuoteContainer(),
    );
  }

  _getQuoteContainer() {
    return Container(
      height: showQuoteCard ? (changeSize ? 65 : 40) : 0,
      width: showQuoteCard ? screenWidth - 5 : 0,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 1),
          child: Container(
            //color: Colors.deepPurpleAccent,
            child: Row(

              children: <Widget>[



                Padding(
                    padding: EdgeInsets.only(right: changeSize ? 15.0 :15.0),
                    child:Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: changeSize ? Color.fromRGBO(5, 175, 242, 1):Colors.white,width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.remove ,size: changeSize ? 30:30.0,color: colorChange2,),
                        onPressed:()async {

                          if(cant>1){
                            PedidoModel pedido= new PedidoModel(
                                idProducto: idProducto,
                                cantidad: 1,
                                precio: (precio).toDouble(),
                                idUsuario: idUsuario
                            );

                            bool rpta= await createPedidoDisminuir(pedido);
                            print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());
                          }else{
                            bool rpta= await eliminarProducto(UsuarioModel.idUsuario,idProducto);

                            if(rpta){
                              print('ELIMINADO');
                              amountProduct-=1;


                            }else{
                              print('NOOOOOOOOOOOOOOOOOOOOOOOO');
                            }
                          }
                          setState((){
                            if(cant>1){
                              cant=cant-1;
                              //UsuarioModel.cantidadTotal=UsuarioModel.cantidadTotal-1;
                            }else{
                              variable=10.0;
                              showQuoteCard=false;
                              colorChange2=WHITE;
                            }
                          });
                        },

                      ),
                    )


                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Center(
                      child: Text((cant).toString(),style: TextStyle( fontSize:changeSize ? 20:12.0),)
                  ),

                ),
                Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child:Padding(
                        padding: EdgeInsets.only(right: changeSize ? 15.0 :15.0),
                        child:Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: changeSize ? Color.fromRGBO(5, 175, 242, 1):Colors.white,width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child:IconButton(
                            //iconSize: ,
                            icon: Icon(Icons.add ,size:  changeSize ? 30:30.0,color:colorChange2),
                            onPressed:() async{





                              PedidoModel pedido= new PedidoModel(
                                  idProducto: idProducto,
                                  cantidad: 1,
                                  precio: (precio).toDouble(),
                                  idUsuario: idUsuario
                              );

                              bool rpta= await createPedidoAumentar(pedido);
                              print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());


                              setState((){
                                cant=cant+1;


                                for(int i=0; i<CarritoModel.carritoModel.length;i++){

                                  if(CarritoModel.carritoModel.removeAt(i).idProducto==idProducto){
                                    CarritoModel.carritoModel.removeAt(i).registropedido_cantidad+=1;
                                    //int cantidad=int.parse(CarritoModel.carritoModel.removeAt(i).producto_cantidad)+1;
                                    //CarritoModel.carritoModel.removeAt(i).producto_cantidad=cantidad.toString();
                                  }else{
                                    CarritoModel carrito= new CarritoModel(
                                        idProducto:idProducto,
                                        producto_nombre:'',
                                        producto_marca:'',
                                        producto_envase:'',
                                        producto_detalle:'',
                                        producto_cantidad:'',
                                        registropedido_cantidad:1,
                                        registropedido_preciototal:1,
                                        producto_uri_imagen:'',
                                        Producto_precio:1
                                    );
                                    CarritoModel.carritoModel.add(carrito);
                                  }

                                }


                                //UsuarioModel.cantidadTotal=UsuarioModel.cantidadTotal+1;
                                //  print((UsuarioModel.cantidadTotal).toString()+'no entramosssssssssssssssssssssssssssssssssss');
                              });
                            },

                          )
                        )


                    ),
                    /*
                    IconButton(

                      icon: Icon(Icons.add ,size:  changeSize ? 40:30.0,color:colorChange2),
                      onPressed:() async{





                        PedidoModel pedido= new PedidoModel(
                            idProducto: idProducto,
                            cantidad: 1,
                            precio: (precio).toDouble(),
                            idUsuario: idUsuario
                        );

                        bool rpta= await createPedidoAumentar(pedido);
                        print((rpta).toString() + " - " +(pedido.idUsuario).toString()+" -  "+ (pedido.idProducto).toString());


                        setState((){
                          cant=cant+1;


                          for(int i=0; i<CarritoModel.carritoModel.length;i++){

                            if(CarritoModel.carritoModel.removeAt(i).idProducto==idProducto){
                              CarritoModel.carritoModel.removeAt(i).registropedido_cantidad+=1;
                              //int cantidad=int.parse(CarritoModel.carritoModel.removeAt(i).producto_cantidad)+1;
                              //CarritoModel.carritoModel.removeAt(i).producto_cantidad=cantidad.toString();
                            }else{
                              CarritoModel carrito= new CarritoModel(
                                  idProducto:idProducto,
                                  producto_nombre:'',
                                  producto_marca:'',
                                  producto_envase:'',
                                  producto_detalle:'',
                                  producto_cantidad:'',
                                  registropedido_cantidad:1,
                                  registropedido_preciototal:1,
                                  producto_uri_imagen:'',
                                  Producto_precio:1
                              );
                              CarritoModel.carritoModel.add(carrito);
                            }

                          }


                          //UsuarioModel.cantidadTotal=UsuarioModel.cantidadTotal+1;
                          //  print((UsuarioModel.cantidadTotal).toString()+'no entramosssssssssssssssssssssssssssssssssss');
                        });
                      },

                    )
                    */


                ),
              ],
            ),

          ),
        ),
      ),
    );
  }

  _showQuote() {
    Future.delayed(Duration(milliseconds: 1), () {
      setState(() {
        showQuoteCard = true;
      });
    });
  }

  _showGreetings() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showGreetings = true;
      });
    });
  }

  _increaseLeftPadding() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        increaseLeftPadding = true;
      });
    });
  }

}



/*
*

  ButtonAnimationWidgetState(this.idProducto, this.cantidad, this.precio, this.idUsuario);




  int _counter = 0;
  double _sparklesAngle = 0.0;
  ScoreWidgetStatus _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
  final duration = new Duration(milliseconds: 400);
  final oneSecond = new Duration(seconds: 1);
  Random random;
  Timer holdTimer, scoreOutETA;
  AnimationController scoreInAnimationController, scoreOutAnimationController,
      scoreSizeAnimationController, sparklesAnimationController;
  Animation scoreOutPositionAnimation, sparklesAnimation;

  initState() {
    super.initState();
    random = new Random();
    scoreInAnimationController = new AnimationController(duration: new Duration(milliseconds: 150), vsync: this);
    scoreInAnimationController.addListener((){
      setState(() {}); // Calls render function
    });

    scoreOutAnimationController = new AnimationController(vsync: this, duration: duration);
    scoreOutPositionAnimation = new Tween(begin: 100.0, end: 150.0).animate(
        new CurvedAnimation(parent: scoreOutAnimationController, curve: Curves.easeOut)
    );
    scoreOutPositionAnimation.addListener((){
      setState(() {});
    });
    scoreOutAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scoreWidgetStatus = ScoreWidgetStatus.HIDDEN;
      }
    });

    scoreSizeAnimationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 150));
    scoreSizeAnimationController.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        scoreSizeAnimationController.reverse();
      }
    });
    scoreSizeAnimationController.addListener((){
      setState(() {});
    });

    sparklesAnimationController = new AnimationController(vsync: this, duration: duration);
    sparklesAnimation = new CurvedAnimation(parent: sparklesAnimationController, curve: Curves.easeIn);
    sparklesAnimation.addListener((){
      setState(() { });
    });
  }

  dispose() {
    super.dispose();
    scoreInAnimationController.dispose();
    scoreOutAnimationController.dispose();
  }

  void increment(Timer t) {
    scoreSizeAnimationController.forward(from: 0.0);
    sparklesAnimationController.forward(from: 0.0);
    setState(() {
      _counter++;
      _sparklesAngle = random.nextDouble() * (2*pi);
    });
  }

  void onTapDown(TapDownDetails tap) {
    // User pressed the button. This can be a tap or a hold.
    if (scoreOutETA != null) {
      scoreOutETA.cancel(); // We do not want the score to vanish!
    }
    if(_scoreWidgetStatus == ScoreWidgetStatus.BECOMING_INVISIBLE) {
      // We tapped down while the widget was flying up. Need to cancel that animation.
      scoreOutAnimationController.stop(canceled: true);
      _scoreWidgetStatus = ScoreWidgetStatus.VISIBLE;
    }
    else if (_scoreWidgetStatus == ScoreWidgetStatus.HIDDEN ) {
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_VISIBLE;
      scoreInAnimationController.forward(from: 0.0);
    }
    increment(null); // Take care of tap
    holdTimer = new Timer.periodic(duration, increment); // Takes care of hold
  }

  void onTapUp(TapUpDetails tap) {
    // User removed his finger from button.
    scoreOutETA = new Timer(oneSecond, () {
      scoreOutAnimationController.forward(from: 0.0);
      _scoreWidgetStatus = ScoreWidgetStatus.BECOMING_INVISIBLE;
    });
    holdTimer.cancel();
  }



  Widget getScoreButton() {
    var scorePosition = 0.0;
    var scoreOpacity = 0.0;
    var extraSize = 0.0;
    switch(_scoreWidgetStatus) {
      case ScoreWidgetStatus.HIDDEN:
        break;
      case ScoreWidgetStatus.BECOMING_VISIBLE :
      case ScoreWidgetStatus.VISIBLE:
        scorePosition = scoreInAnimationController.value * 100;
        scoreOpacity = scoreInAnimationController.value;
        extraSize = scoreSizeAnimationController.value * 3;
        break;
      case ScoreWidgetStatus.BECOMING_INVISIBLE:
        scorePosition = scoreOutPositionAnimation.value;
        scoreOpacity = 1.0 - scoreOutAnimationController.value;
    }

    var stackChildren = <Widget>[
    ];
/*
    var firstAngle = _sparklesAngle;
    var sparkleRadius = (sparklesAnimationController.value * 50) ;
    var sparklesOpacity = (1 - sparklesAnimation.value);

    for(int i = 0;i < 5; ++i) {
      var currentAngle = (firstAngle + ((2*pi)/5)*(i));
      var sparklesWidget =
      new Positioned(child: new Transform.rotate(
          angle: currentAngle - pi/2,
          child: new Opacity(opacity: sparklesOpacity,
              child : new Image.asset("images/sparkles.png", width: 14.0, height: 14.0, ))
      ),
        left:(sparkleRadius*cos(currentAngle)) + 20,
        top: (sparkleRadius* sin(currentAngle)) + 20 ,
      );
      stackChildren.add(sparklesWidget);
    }*/

    stackChildren.add(new Opacity(opacity: scoreOpacity, child: new Container(
        height: 50.0 + extraSize,
        width: 50.0  + extraSize,
        decoration: new ShapeDecoration(
          shape: new CircleBorder(
              side: BorderSide.none
          ),
          color: Colors.lightGreenAccent,
        ),
        child: new Center(child:
        new Text("+" + _counter.toString(),
          style: new TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15.0),))
    )
    )
    );


    var widget =  new Positioned(
        child: new Stack(
          alignment: FractionalOffset.center,
          overflow: Overflow.visible,
          children: stackChildren,
        )
        ,
        bottom: scorePosition
    );
    return widget;
  }

*
* */