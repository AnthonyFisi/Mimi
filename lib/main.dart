import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Mimi/Login-Register.dart';
import 'package:tienda_mimi/Mimi/home.dart';
import 'package:tienda_mimi/Mimi/splash_screen.dart';
import 'package:tienda_mimi/Mimi/splash_screen2.dart';
import 'package:tienda_mimi/Service/Bloc/BlocPattern.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/Service/Pusher/mainPusher.dart';
import 'package:tienda_mimi/src/Route/route_generator.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Widgets/LoaderScreen.dart';

MainPusher  mainPusher= new MainPusher();

void main() {
  runApp(MyApp());
  UsuarioModel.autoLogIn();
  UsuarioModel.loadEmail();
  mainPusher.initPusher();
  mainPusher.conectPusher();
  //mainPusher.suscribePusher();
  //mainPusher.bindPusher();


}

bool isValid=false;
bool statusChange=false;

final FirebaseAuth auth = FirebaseAuth.instance;



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'GO',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
          hintColor: Colors.lightBlueAccent,
          primaryColor: Colors.lightBlueAccent,
        fontFamily: 'CeraPro',
       ),
     //home: Home(),
      //home: LoaderScreen(),
      home: SplashScreen2(),
      /*new
      StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData ) {
            rxUsuario.fetchTodo(http.Client(), snapshot.data.email);
            return SplashScreen();
          }
          else{

            print('login principal');
           // Home();
            return LoginRegister();
          }
        },
      ),*/
      onGenerateRoute: RouteGenerator.generateRoute,

    );
  }
}



