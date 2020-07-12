
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Service/Api/UsuarioApi.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/src/Screen/LocationScreen.dart';
import 'package:tienda_mimi/src/Screen/NotificationScreen.dart';
import 'package:tienda_mimi/src/Screen/OrderScreen.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Screen/PerfilScreen.dart';

Widget  navigationDrawerScreen(context){
  UsuarioApi usuarioApi=new UsuarioApi();

  return new Drawer(

    child: new ListView(
      children: <Widget>[

        FutureBuilder<UsuarioModel>(
          future: usuarioApi.fetchUsuariofindById(http.Client(),(UsuarioModel.idUsuario).toString()),
          builder: (context,snapshot){
             Random random = new Random();

            if(snapshot.data != null){
              return new UserAccountsDrawerHeader(
                accountName: new Text(snapshot.data.Usuario_nombre+' '+snapshot.data.Usuario_apellido,style: TextStyle(color: Colors.black),),
                accountEmail: new Text(snapshot.data.Usuario_correo,style: TextStyle(color: Colors.black),),
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/lake.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                   // backgroundImage: NetworkImage(snapshot.data.Usuario_foto)
                  backgroundColor: Color.fromARGB(255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
                  child: Text(snapshot.data.Usuario_nombre.toUpperCase().substring(0,1),style: TextStyle(color: Colors.white,fontSize:35,fontWeight: FontWeight.bold),),
                ),
              );
            }else{
              return Container(

              );
            }

          },
        ),



        new ListTile(
            leading: Icon(Icons.location_on,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Ubicacion"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LocationScreen(
                  ),
                ),
              );
            }
            ),
        new ListTile(
            leading: Icon(Icons.library_books,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Ordenes"),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderScreen(
                    idUsuario:UsuarioModel.idUsuario,
                  ),
                ),
              );


            }),
        new ListTile(
            leading: Icon(Icons.perm_identity,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Perfil"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:(context) => PerfilScreen(
                  )
                )
              );
            }),

        new ListTile(
            leading: Icon(Icons.notifications_none,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Notificaciones"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder:(context) => NotificationScreen()
                  )
              );
            }),

        new ListTile(
            leading: Icon(Icons.settings,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Configuracion"),
            onTap: () {
              Navigator.pop(context);
            }),
        new Divider(),
        new ListTile(
            leading: Icon(Icons.info,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Ayuda"),
            onTap: () {
              Navigator.pop(context);
            }),
        new ListTile(
            leading: Icon(Icons.power_settings_new,color: Color.fromRGBO(5, 175, 242, 1),),
            title: new Text("Cerrar Session"),
            onTap: () async {
              auth.signOut();
              //MyApp();
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('sessionValue', null);
              prefs.setString('email', null);

              UsuarioModel.sesion=false;
              UsuarioModel.keepEmail="";
              //Navigator.of(context).pushReplacementNamed('/LoginRegister');
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/homeProof', (Route<dynamic> route) => false);

              //   Navigator.of(context).pushNamed('/PerfilScreen');
            }),
      ],
    ),
  );

}