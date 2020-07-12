import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Mimi/Login-Register.dart';
import 'package:tienda_mimi/Mimi/sign_in.dart';
import 'package:tienda_mimi/Mimi/splash_screen.dart';
import 'package:tienda_mimi/Service/Bloc/BlocPattern.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/main.dart';
import 'package:http/http.dart' as http;



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //autoLogIn();
    //loadEmail();
    rxUsuario.fetchTodo(http.Client(),UsuarioModel.keepEmail);

    print('session state   ' +UsuarioModel.sesion.toString());
    print('email state   ' +UsuarioModel.keepEmail);

  }

  @override
  Widget build(BuildContext context) {
    //return initHome();
    print(UsuarioModel.sesion.toString()+' cambio de variable');
    return UsuarioModel.sesion ? initHome() : initHome2();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool userSession = prefs.getBool('sessionValue');

    if (userSession != null) {
      setState(() {
        UsuarioModel.sesion = true;
      });
      return;
    }
  }
  void loadEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UsuarioModel.keepEmail = prefs.getString('email');
  }
/*
  Widget initHome(){


    if(UsuarioModel.sesion){
      print('estoy aqui en slpash');
      /*
      return SplashScreen();
      */
    }else{
      print('estoy aqui en STREAM');

      /*
      return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData ) {
           // rxUsuario.fetchTodo(http.Client(), snapshot.data.email);
            return SplashScreen();
          }
          else{

            print('login principal');
            // Home();
            return LoginRegister();
          }
        },
      );
      */
    }

  }
*/

  Widget initHome(){


      print('estoy aqui en slpash');

      return SplashScreen();


  }
  Widget initHome2(){


      print('estoy aqui en STREAM');


      return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData ) {
           // rxUsuario.fetchTodo(http.Client(), snapshot.data.email);
            return SplashScreen();
          }
          else{

            print('login principal');
            // Home();
            return LoginRegister();
          }
        },
      );

    }

  }


