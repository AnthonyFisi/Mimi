

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/main.dart';
import 'package:tienda_mimi/Service/Api/UsuarioApi.dart';



class VerificationAuthentication extends StatefulWidget {
 final  FirebaseUser auth;
 final  UsuarioModel usuarioModel;

  const VerificationAuthentication({Key key, this.auth, this.usuarioModel}) : super(key: key);


  @override
  _VerificationAuthenticationState createState() => _VerificationAuthenticationState(auth,usuarioModel);
}

class _VerificationAuthenticationState extends State<VerificationAuthentication> {


  final  FirebaseUser user;
  final UsuarioModel usuarioModel;
   UsuarioApi usuarioApi;
  _VerificationAuthenticationState(this.user,this.usuarioModel);




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Confirmacion de autenticacion'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: EdgeInsets.all(10.0),
            child:Column(
              children: <Widget>[
                Padding(
                padding: EdgeInsets.all(10.0),
                child:Text('En unos minutos recibiras un correo para validar tu el correo ingresado ',style: TextStyle(color: Colors.black38),)
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Text('Confirma e inicia sesion ',style: TextStyle(color: Colors.black38),)
                ),

              ],
            )
          ),
         Padding(
            padding: EdgeInsets.only(left:50.0,right: 50.0),
            child:
            Container(
              child: RaisedButton(
                onPressed: () async{

                  FirebaseUser userConfirmation = (await FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: usuarioModel.Usuario_correo, password:usuarioModel.Usuario_contrasena)).user;

                  if(userConfirmation.isEmailVerified){

                    final SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setBool('sessionValue', true);

                    final SharedPreferences prefs1 = await SharedPreferences.getInstance();
                    prefs1.setString('email', usuarioModel.Usuario_correo);



                    setState(() {
                      isValid=true;
                      UsuarioModel.sesion=prefs.getBool('sessionValue');
                      UsuarioModel.keepEmail=prefs1.getString('email');

                    });

                    bool respuesta =await usuarioApi.creatUsuarioModel(usuarioModel);



                    print(respuesta.toString() + 'RESPUESTA DE REGISTTRO');

                    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
                    userUpdateInfo.displayName = usuarioModel.Usuario_nombre;
                    userUpdateInfo.photoUrl='true';
                    userConfirmation.updateProfile(userUpdateInfo).then((onValue) {
                      Firestore.instance.collection('users').document(userConfirmation.uid).setData(
                          {'email': usuarioModel.Usuario_correo,
                            'displayName':usuarioModel.Usuario_nombre
                          }
                            ).then((onValue) {



                    //    Navigator.of(context).pushReplacementNamed('/');

                      });
                    });

                  }else{
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              child: Column(
                                children: <Widget>[
                                   Text('El mensaje enviado aun no fue confirmado.'),
                                   Text('Porfavor confirmar correo.'),
                                ],
                              )
                            ),
                          );
                        });
                  }

                },
                child: Text('Iniciar Sesion',style: TextStyle(color: Colors.white),),
                color: Colors.lightBlueAccent,
              ),



            ),
          ),
          Padding(
            padding: EdgeInsets.only(left:50.0,right: 50.0),
            child:
            Container(
              child:Column(
                children: <Widget>[
                  Text('Si no recibes el correo'),
                  Text('Pulsar reenviar correo ')
                ],
              )
            ),
          ),


          Padding(
            padding: EdgeInsets.only(left:50.0,right: 50.0),
            child:
            Container(
              child: RaisedButton(
                onPressed: (){
                  user.sendEmailVerification();
                },
                child: Text('Enviar mensaje',style: TextStyle(color: Colors.white),),
                color: Colors.lightBlueAccent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
