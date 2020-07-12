import 'package:flutter/material.dart';
import 'package:pusher_websocket_flutter/pusher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Service/Api/CategoriesApi.dart';
import 'package:tienda_mimi/Service/Api/ListaPedidoApi.dart';
import 'package:tienda_mimi/Service/Api/PedidoRealApi.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:tienda_mimi/Service/Api/UbicacionApi.dart';
import 'package:tienda_mimi/Service/Model/CarritoModel.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:tienda_mimi/Service/Model/ListaPedidoModel.dart';
import 'package:tienda_mimi/Service/Model/PedidoRealModel.dart';
import 'package:tienda_mimi/Service/Model/UbicacionModel.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/Service/Pusher/mainPusher.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Promociones.dart';
import 'package:tienda_mimi/src/Screen/FavoriteProductScreen.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:tienda_mimi/src/Screen/OrderScreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/SearchScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';
import 'package:tienda_mimi/src/Screen/NavigationDrawerScreen.dart';
import 'package:tienda_mimi/src/Widgets/SkeletonWidget.dart';
import 'package:tienda_mimi/src/Widgets/appBarWidgetHome.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';


String lastConnectionState;
List<String> buscadorString=new List<String>();

Event lastEvent;
Channel channel;


Channel channel1;
Event lastEvent1;


Channel channel2;
Event lastEvent2;


int cantidadProductos=0;
int amountProduct=0;
int idPedido;

var channelController = TextEditingController(text: "my-channel");
var eventController = TextEditingController(text: "my-event");

var channelController1 = TextEditingController(text: "my-channel1");
var eventController1 = TextEditingController(text: "my-event1");

var channelController2 = TextEditingController(text: "my-channel2");
var eventController2 = TextEditingController(text: "my-event2");


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _curIndex = 0;
  var contents = '';
  var heightScreen;
  var widhtScreen;
  var media;
  TextEditingController  _controller= new TextEditingController();
  TextEditingController  _controller2= new TextEditingController();
  //MainPusher mainPusher=new MainPusher();

  @override
  initState() {
    super.initState();
    _curIndex = 0;
    mainPusher.suscribePusher();
    //initPusher();
    //conectPusher();
    CarritoModel.carritoModel.clear();
    //print(UsuarioModel.keepEmail+'EMAIL EN HOME SCREEN');

  }


  Future<void> initPusher() async {
    try {
      await Pusher.init('18c8170377c406cfcf3a', PusherOptions(cluster: 'us2'),
          enableLogging: true);
      new Future.delayed(const Duration(seconds: 120)); //recommend

    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void conectPusher() {
    Pusher.connect(onConnectionStateChange: (x) async {
      //if (mounted)
      setState(() {
        lastConnectionState = x.currentState;
      });
    }, onError: (x) {
      debugPrint("Error: ${x.message}");
    });
  }

  Future<void> suscribePusher() async {
    channel = await Pusher.subscribe(channelController.text);
  }


  Future<void> suscribePusher1() async {
    channel1 = await Pusher.subscribe(channelController1.text);
  }


  Future<void> suscribePusher2() async {
    channel2 = await Pusher.subscribe(channelController2.text);
  }

  Widget _indexBottom() => Container(
        height: 65.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Inicio",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 0 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.home,
                size: 25,
                color: RED,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.place,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Ubicacion",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 1 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.place,
                size: 20,
                color: RED,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Carrito",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.shopping_cart,
                size: 20,
                color: RED,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_border,
                size: 20,
                color: TEXT_BLACK_LIGHT,
              ),
              title: Text(
                "Favoritos",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 3 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.favorite_border,
                size: 20,
                color: RED,
              ),
            ),
            BottomNavigationBarItem(
              icon: Container(
                  height: 35.0,
                  width: 50.0,
                  //color: Colors.lightGreenAccent,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10.0,
                        left: 10.0,
                        child: Icon(
                          Icons.library_books,
                          size: 20,
                          color: TEXT_BLACK_LIGHT,
                        ),
                      ),
                      Positioned(
                          left: 20.0,
                          bottom: 15.0,
                          child: FutureBuilder<List<ListaPedidoModel>>(
                            future: fetchListaPedidoModelHoy(http.Client(),
                                (UsuarioModel.idUsuario).toString()),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(40.0)),
                                    child: Center(
                                      child: Text(
                                        '+1',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                );
                              } else {
                                return Container();
                              }
                            },
                          ))
                    ],
                  )),
              title: Text(
                "Orden",
                style: TextStyle(
                    fontSize: 10,
                    color: _curIndex == 4 ? RED : TEXT_BLACK_LIGHT),
              ),
              activeIcon: Icon(
                Icons.library_books,
                size: 20,
                color: RED,
              ),
            )
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _curIndex,
          onTap: (index) {
            setState(() {
              _curIndex = index;
              switch (_curIndex) {
                case 0:
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/', (Route<dynamic> route) => false);
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationScreen(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShoppingCartScreen(
                        idUsuario: UsuarioModel.idUsuario,
                      ),
                    ),
                  );
                  break;
                case 3:
                 // Navigator.of(context).pushNamed('/AfterCheckoutScreen');
                  // waiting2(context);
                  //openBottomSheet2(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteProductScreen(),
                    ),
                  );
                  break;
                case 4:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(),
                    ),
                  );
                  break;
              }
            });
          },
        ),
      );

  waiting2(BuildContext context){
    return showDialog(

        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            backgroundColor: Colors.transparent,
            content:
            SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    color: Colors.transparent,
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
                        child: Text('Cargando ...',style: TextStyle(fontSize: 25.0,color:Colors.white),),
                      )
                  )

                ],
              ),
            ),

          );
        }
    );
  }

  openBottomSheet2(BuildContext context) {
    TextEditingController comentario= TextEditingController();
    showModalBottomSheet(
        isDismissible:false,
        isScrollControlled:true,
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 500,
            child: Column(
              children: <Widget>[

                Container(
                  height: 100.0,
                  child: Center(
                    child: Image.asset('assets/succes.png',height: 50.0,width: 50.0,),
                  ),
                ),

                Text('Gracias por tu compra '),

                Padding(
                  padding: const EdgeInsets.only(top:0.0),
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
          );
        }
        );
  }

  void changePage(int index) {
    setState(() {
      //currentIndex = index;

      _curIndex = index;
      switch (_curIndex) {
        case 0:
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          break;
        case 1:
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LocationScreen(),
              ));
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShoppingCartScreen(
                idUsuario: UsuarioModel.idUsuario,
              ),
            ),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(
                idUsuario: UsuarioModel.idUsuario,
              ),
            ),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScreen(
                idUsuario: UsuarioModel.idUsuario,
              ),
            ),
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
   final media =MediaQuery.of(context);
   return RegistrationLocation2(media);
  }


  Widget RegistrationLocation2(MediaQueryData media){

    print(UsuarioModel.sesion.toString()+'Sesion perrasssssssssss');
    if(UsuarioModel.idUsuario != 0){
      print(UsuarioModel.idUsuario.toString() );

      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            appSliverBarWidgetHome(context),

            SliverToBoxAdapter(
                child: Container(
                  //height: MediaQuery.of(context).size.height * 0.09,
                  height:
                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.09 :MediaQuery.of(context).size.height * 0.15,

                  decoration: new BoxDecoration(
                      color: Color.fromRGBO(5, 175, 242, 1),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(0.0),
                        topRight: const Radius.circular(0.0),
                        bottomLeft: const Radius.circular(5.0),
                        bottomRight: const Radius.circular(5.0),
                      )),
                  child: Row(
                    children: <Widget>[

                      Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/ShoppingCartScreen',arguments: UsuarioModel.idUsuario);

                                ///ShoppingCartScreen'
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.15,
                                  height:
                                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.08 :MediaQuery.of(context).size.height * 0.12,

                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        top: 10.0,
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      ),
                                      Positioned(
                                        left: 15.0,
                                        bottom: 30.0,
                                        child: FutureBuilder<PedidoRealModel>(
                                            future: fetchPedidoReal(http.Client(),
                                                (UsuarioModel.idUsuario).toString()),
                                            builder: (context, snapshot) {
                                              if (snapshot.data != null) {
                                                if (snapshot.data.pedido_estado !=
                                                    'Atendido') {

                                                  cantidadProductos=snapshot.data
                                                      .pedido_cantidadtotal;
                                                  amountProduct=snapshot.data
                                                      .pedido_cantidadtotal;
                                                  idPedido=snapshot.data.idpedido;
                                                  return Container(
                                                      height: 20.0,
                                                      width: 30.0,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              40.0)),
                                                      child: Center(
                                                        child: Text(
                                                          '+' +
                                                              (snapshot.data
                                                                  .pedido_cantidadtotal)
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight:
                                                              FontWeight.bold),
                                                        ),
                                                      ));
                                                } else {
                                                  return Container();
                                                }
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      )
                                    ],
                                  )))),
                      Padding(
                        padding: EdgeInsets.only(left:0.0),
                        child:
                        FutureBuilder<List<String>>(
                            future: fetchLista(http.Client()),
                            builder: ( context,  snapshot) {
                              if(snapshot.data != null){
                                buscadorString=snapshot.data;
                                return GestureDetector(
                                  onTap: (){
                                    mainPusher.bindPusher();
                                    showSearch(context: context, delegate: DataSearch(snapshot.data));
                                  },
                                  child:  Container(
                                    height: 35.0,
                                    width: MediaQuery.of(context).size.width * 0.80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        color: Colors.white),
                                    child: TextField(

                                      enabled: false,
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                          hintText: "¿Que estas buscando? ",
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left: 15.0,bottom: 10.0),
                                          suffixIcon: IconButton(
                                              icon: Icon(Icons.search),
                                              onPressed: (){

                                              }
                                          )),
                                    ),
                                  ),
                                );
                              }else{
                                return Container(
                                  height: 30.0,
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      color: Colors.white),
                                  child: TextField(
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                        hintText: "¿Que estas buscando? ",
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(left: 15.0),
                                        suffixIcon: IconButton(
                                          icon: Icon(Icons.search),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SearchScreen(),
                                              ),
                                            );

                                          },
                                          iconSize: 20.0,
                                        )),
                                  ),
                                );
                              }
                            }
                        ),

                        /*
                  Container(
                    height: 30.0,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "¿Que estas buscando? ",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {



                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            */
                              },
                            iconSize: 20.0,
                          )),
                    ),
                  ),

                */
                      ),

                    ],
                  ),
                )),

            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ),


            // CategoriesGridViewWidget(),
            FutureBuilder<List<CategoriesModel>>(
              future: fetchCategoriesModel(http.Client()),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return SliverGrid(
                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent
                          :media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.12 :MediaQuery.of(context).size.height * 0.25,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 0.7,
                    ),

                    ///Lazy building of list
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                           // suscribePusher();
                            suscribePusher1();
                            suscribePusher2();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListCategoriesScreen(
                                  categoriesModel: snapshot.data[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            // color: Colors.orangeAccent,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 1.0),
                                  child: Image.network(
                                    snapshot.data[index].categoria_descripcion,
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                  child: Text(
                                    snapshot.data[index].categoria_nombre,
                                    style: TextStyle(fontSize: 11.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                      /// Set childCount to limit no.of items
                      childCount: snapshot.data.length,
                    ),
                  );
                } else {
                  return SliverGrid(
                    gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),

                    delegate: SliverChildBuilderDelegate( (BuildContext context ,int index){
                      return Padding(
                          padding: EdgeInsets.all(5.0),
                        child: Skeleton(type: 'boxHome',),
                      );
                    },childCount: 9,
                    ),

                  );
/*
                  SliverGrid(
                    gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 80.0,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 2.0,
                    ),

                    ///Lazy building of list
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Container(color: Colors.black12);
                      },

                      /// Set childCount to limit no.of items
                      childCount: 10,
                    ),
                  );
                  */
                }
              },
            ),

            SliverToBoxAdapter(
              child: Container(
                //height: MediaQuery.of(context).size.height * 0.2,
                  height:
                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.2 :MediaQuery.of(context).size.height * 0.4,

                  child: Carousel(
                    boxFit: BoxFit.cover,
                    images: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.black12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.black38,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                    autoplay: true,
                    dotBgColor: Colors.black.withOpacity(0.0),
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                  )),
            ),

            SliverToBoxAdapter(
                child: Promociones(
                  // heightScrenn: MediaQuery.of(context).size.height * 0.15,
                  heightScrenn:
                  media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.25,

                )),
          ],
        ),
        drawer: navigationDrawerScreen(context),
        bottomNavigationBar: _indexBottom(),
      );
    }else{
      return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(top:100.0),
                child: Container(
                  child: Text('Ingresar tu ubicacion actual'),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:5.0),
                child: Container(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Av. Principal n° 123 ...',
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:5.0),
                child: Container(
                  child: Text('Ingresar detalles del lugar'),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:5.0),
                child: Container(
                  child: TextField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      labelText: ' Ejm:Casa de dos pisos',
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:5.0),
                child: Container(
                    child: RaisedButton(
                      onPressed: () async {


                        print(_controller2.text + 'controller 2');

                        UbicacionModel ubicacionModel= new UbicacionModel(
                          idubicacion: 0,
                          ubicacion_nombre: _controller.text,
                          ubicacion_comentarios: _controller2.text,
                          idusuario: UsuarioModel.idUsuario,
                          ubicacion_estado: 'activo',
                          eliminado: false,
                        );

                        bool rpta=await creatUbicacionModel(ubicacionModel);

                        if(rpta){

                          print('registrado CON EXITO');
                          setState(() {

                          });
                        }else{
                          print('NO SE REGISTRO :c ');

                          setState(() {

                          });

                        }
                      },
                      child: Text('Registrarse'),
                    )
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top:200.0),
                child: RaisedButton(
                  color: Colors.orangeAccent,
                  onPressed: (){
                    auth.signOut().then((onValue) async {
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool('sessionValue', null);
                      prefs.setString('email', null);
                      setState(() {
                        UsuarioModel.sesion=false;
                        UsuarioModel.keepEmail="";
                      });
                      Navigator.of(context).pushReplacementNamed('/homeProof');
                    });
                  },
                  child: Text('salir'),
                ),
              )


            ],
          ),
        ),
      );
    }
  }

  Widget RegistrationLocation(MediaQueryData media){
    return FutureBuilder<UbicacionModel>(
      future: showUbicacionActual(http.Client(),UsuarioModel.idUsuario.toString()),
        builder: (context,snapshot){

        if(snapshot.data != null){
          print(snapshot.data.toString() );

          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                appSliverBarWidgetHome(context),

                SliverToBoxAdapter(
                    child: Container(
                      //height: MediaQuery.of(context).size.height * 0.09,
                      height:
                      media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.09 :MediaQuery.of(context).size.height * 0.15,

                      decoration: new BoxDecoration(
                          color: Color.fromRGBO(5, 175, 242, 1),
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(0.0),
                            topRight: const Radius.circular(0.0),
                            bottomLeft: const Radius.circular(5.0),
                            bottomRight: const Radius.circular(5.0),
                          )),
                      child: Row(
                        children: <Widget>[

                          Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/ShoppingCartScreen',arguments: UsuarioModel.idUsuario);

                                    ///ShoppingCartScreen'
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width * 0.15,
                                      height:
                                      media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.08 :MediaQuery.of(context).size.height * 0.12,

                                      child: Stack(
                                        children: <Widget>[
                                          Positioned(
                                            top: 10.0,
                                            child: Icon(
                                              Icons.shopping_cart,
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                          ),
                                          Positioned(
                                            left: 15.0,
                                            bottom: 30.0,
                                            child: FutureBuilder<PedidoRealModel>(
                                                future: fetchPedidoReal(http.Client(),
                                                    (UsuarioModel.idUsuario).toString()),
                                                builder: (context, snapshot) {
                                                  if (snapshot.data != null) {
                                                    if (snapshot.data.pedido_estado !=
                                                        'Atendido') {

                                                      cantidadProductos=snapshot.data
                                                          .pedido_cantidadtotal;
                                                      amountProduct=snapshot.data
                                                          .pedido_cantidadtotal;
                                                      idPedido=snapshot.data.idpedido;
                                                      return Container(
                                                          height: 20.0,
                                                          width: 30.0,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  40.0)),
                                                          child: Center(
                                                            child: Text(
                                                              '+' +
                                                                  (snapshot.data
                                                                      .pedido_cantidadtotal)
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight:
                                                                  FontWeight.bold),
                                                            ),
                                                          ));
                                                    } else {
                                                      return Container();
                                                    }
                                                  } else {
                                                    return Container();
                                                  }
                                                }),
                                          )
                                        ],
                                      )))),
                          Padding(
                            padding: EdgeInsets.only(left:0.0),
                            child:
                            FutureBuilder<List<String>>(
                                future: fetchLista(http.Client()),
                                builder: ( context,  snapshot) {
                                  if(snapshot.data != null){
                                    buscadorString=snapshot.data;
                                    return Container(
                                      height: 30.0,
                                      width: MediaQuery.of(context).size.width * 0.80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: Colors.white),
                                      child: TextField(
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                            hintText: "¿Que estas buscando? ",
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 15.0),
                                            suffixIcon: IconButton(
                                                icon: Icon(Icons.search),
                                                onPressed: (){
                                                  //suscribePusher();
                                                  showSearch(context: context, delegate: DataSearch(snapshot.data));
                                                }
                                            )),
                                      ),
                                    );
                                  }else{
                                    return Container(
                                      height: 30.0,
                                      width: MediaQuery.of(context).size.width * 0.80,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),
                                          color: Colors.white),
                                      child: TextField(
                                        textInputAction: TextInputAction.search,
                                        decoration: InputDecoration(
                                            hintText: "¿Que estas buscando? ",
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 15.0),
                                            suffixIcon: IconButton(
                                              icon: Icon(Icons.search),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => SearchScreen(),
                                                  ),
                                                );

                                              },
                                              iconSize: 20.0,
                                            )),
                                      ),
                                    );
                                  }
                                }
                            ),

                            /*
                  Container(
                    height: 30.0,
                    width: MediaQuery.of(context).size.width * 0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                          hintText: "¿Que estas buscando? ",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 15.0),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {



                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            */
                              },
                            iconSize: 20.0,
                          )),
                    ),
                  ),

                */
                          ),

                        ],
                      ),
                    )),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ),


                // CategoriesGridViewWidget(),
                FutureBuilder<List<CategoriesModel>>(
                  future: fetchCategoriesModel(http.Client()),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return SliverGrid(
                        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent
                              :media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.12 :MediaQuery.of(context).size.height * 0.25,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 5.0,
                          childAspectRatio: 0.7,
                        ),

                        ///Lazy building of list
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                               // suscribePusher();
                                //suscribePusher1();
                                //suscribePusher2();

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ListCategoriesScreen(
                                      categoriesModel: snapshot.data[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                // color: Colors.orangeAccent,
                                alignment: Alignment.center,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 1.0),
                                      child: Image.network(
                                        snapshot.data[index].categoria_descripcion,
                                        height: 40.0,
                                        width: 40.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10.0, top: 10.0),
                                      child: Text(
                                        snapshot.data[index].categoria_nombre,
                                        style: TextStyle(fontSize: 11.0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },

                          /// Set childCount to limit no.of items
                          childCount: snapshot.data.length,
                        ),
                      );
                    } else {
                      return SliverGrid(
                        gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 80.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 5.0,
                          childAspectRatio: 2.0,
                        ),

                        ///Lazy building of list
                        delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Container(color: Colors.black12);
                          },

                          /// Set childCount to limit no.of items
                          childCount: 10,
                        ),
                      );
                    }
                  },
                ),

                SliverToBoxAdapter(
                  child: Container(
                    //height: MediaQuery.of(context).size.height * 0.2,
                      height:
                      media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.2 :MediaQuery.of(context).size.height * 0.4,

                      child: Carousel(
                        boxFit: BoxFit.cover,
                        images: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                color: Colors.black12,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                        autoplay: true,
                        dotBgColor: Colors.black.withOpacity(0.0),
                        animationCurve: Curves.fastOutSlowIn,
                        animationDuration: Duration(milliseconds: 1000),
                      )),
                ),

                SliverToBoxAdapter(
                    child: Promociones(
                      // heightScrenn: MediaQuery.of(context).size.height * 0.15,
                      heightScrenn:
                      media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.15 :MediaQuery.of(context).size.height * 0.25,

                    )),
              ],
            ),
            drawer: navigationDrawerScreen(context),
            bottomNavigationBar: _indexBottom(),
          );
        }else{
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top:100.0),
                    child: Container(
                      child: Text('Ingresar tu ubicacion actual'),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Container(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Av. Principal n° 123 ...',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Container(
                      child: Text('Ingresar detalles del lugar'),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Container(
                      child: TextField(
                        controller: _controller2,
                        decoration: InputDecoration(
                          labelText: ' Ejm:Casa de dos pisos',
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                    child: Container(
                        child: RaisedButton(
                          onPressed: () async {


                            print(_controller2.text + 'controller 2');

                            UbicacionModel ubicacionModel= new UbicacionModel(
                              idubicacion: 0,
                              ubicacion_nombre: _controller.text,
                              ubicacion_comentarios: _controller2.text,
                              idusuario: UsuarioModel.idUsuario,
                              ubicacion_estado: 'activo',
                              eliminado: false,
                            );

                            bool rpta=await creatUbicacionModel(ubicacionModel);

                            if(rpta){

                              print('registrado CON EXITO');
                              setState(() {

                              });
                            }else{
                              print('NO SE REGISTRO :c ');

                              setState(() {

                              });

                            }
                          },
                          child: Text('Registrarse'),
                        )
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top:200.0),
                    child: RaisedButton(
                      color: Colors.orangeAccent,
                        onPressed: (){
                          auth.signOut().then((onValue) {
                            Navigator.of(context).pushReplacementNamed('/registration');
                          });
                        },
                      child: Text('salir'),
                    ),
                  )


                ],
              ),
            ),
          );
        }

        }
    );
  }
}
