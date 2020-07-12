import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tienda_mimi/Mimi/VerificactionAuthenticacion.dart';
import 'package:tienda_mimi/Mimi/WelcomeUser.dart';
import 'package:tienda_mimi/Mimi/custom/customTextField.dart';
import 'package:tienda_mimi/Mimi/sign_in.dart';
import 'package:tienda_mimi/Service/Bloc/BlocPattern.dart';
import 'package:tienda_mimi/Service/Model/UsuarioModel.dart';
import 'package:tienda_mimi/main.dart';

String  _emailUser;


class LoginRegister extends StatefulWidget {
  @override
  _LoginRegisterState createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  UsuarioModel usuarioModel;

  PersistentBottomSheetController _sheetController;
  String _email;
  String _password;
  String _displayName;
  String _phone;
  String _address;
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";
  bool CheckBoxCondiciones=false;


  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media =MediaQuery.of(context);
    Color primaryColor = Theme.of(context).primaryColor;

    //button widgets
    Widget filledButton(String text, Color splashColor, Color highlightColor,
        Color fillColor, Color textColor, void function()) {
      return RaisedButton(
        highlightElevation: 0.0,
        splashColor: splashColor,
        highlightColor: highlightColor,
        elevation: 0.0,
        color: fillColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0)),
        child: Text(
          text,
          style: TextStyle(
               color: textColor, fontSize: 20),
        ),
        onPressed: () {
          function();
        },
      );
    }

    void _validateLoginInput() async {
      final FormState form = _formKey2.currentState;
      if (_formKey2.currentState.validate()) {
        form.save();

        try {
          FirebaseUser user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password)).user;
          _emailUser=_email;

         // if(user.isEmailVerified)
          if(!user.isEmailVerified)
          {

            auth.signOut();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text('Confirmar el correo'),
                    ),
                  );
                });




           //77 Navigator.of(context).pushReplacementNamed('/');

          }else{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            final SharedPreferences prefs1 = await SharedPreferences.getInstance();

            prefs.setBool('sessionValue', true);
            prefs1.setString('email', _email);


            setState(() {
              UsuarioModel.sesion=prefs.getBool('sessionValue');
              UsuarioModel.keepEmail=prefs1.getString('email');

            });

            var usuario=rxUsuario.fetchTodo(http.Client(), user.email.toString());
             print(usuario.toString()+'sale algoooooooooooooooooooo');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text('Usuario valido el correo'),
                    ),
                  );
                });

          }

        } catch (error) {
          print('error');
          switch (error.code) {
            case "ERROR_USER_NOT_FOUND":
              {
                /*_sheetController.setState(() {
                  errorMsg =
                  "There is no user with such entries. Please try again.";

                  _loading = false;
                });*/
                errorMsg =
                "There is no user with such entries. Please try again.";
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            case "ERROR_WRONG_PASSWORD":
              {
                /*_sheetController.setState(() {
                  errorMsg = "Password doesn\'t match your email.";
                  _loading = false;
                });*/
                errorMsg = "Password doesn\'t match your email.";
                _loading = false;
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            default:
              {
                /*_sheetController.setState(() {
                  errorMsg = "";
                });*/
                errorMsg = "";

              }
          }
        }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    void _validateRegisterInput() async {
      final FormState form = _formKey.currentState;
      if (_formKey.currentState.validate()) {
        form.save();
        _sheetController.setState(() {
          _loading = true;
        });
        try {
          FirebaseUser user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
              email: _email, password: _password)).user;
          user.sendEmailVerification();
          usuarioModel=new UsuarioModel(
            idusuario: 100,
            Usuario_nombre: _displayName,
            Usuario_apellido: _address,
            Usuario_correo: _email,
            Usuario_celular: _phone,
            Usuario_contrasena: _password,
            Usuario_foto: ''
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationAuthentication(auth: user,usuarioModel: usuarioModel,),
            ),
          );



        } catch (error) {
          switch (error.code) {
            case "ERROR_EMAIL_ALREADY_IN_USE":
              {
                _sheetController.setState(() {
                  errorMsg = "This email is already in use.";
                  _loading = false;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            case "ERROR_WEAK_PASSWORD":
              {
                _sheetController.setState(() {
                  errorMsg = "The password must be 6 characters long or more.";
                  _loading = false;
                });
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              }
              break;
            default:
              {
                _sheetController.setState(() {
                  errorMsg = "";
                });
              }
          }
        }
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    String emailValidator(String value) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (value.isEmpty) return '*Required';
      if (!regex.hasMatch(value))
        return '*Ingresa un correo valido';
      else
        return null;
    }


    void registerSheet() {
      _sheetController = _scaffoldKey.currentState
          .showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            child: Container(

              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: AlignmentDirectional.topEnd,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: MediaQuery.of(context).size.width *0.8,
                          top: 10,

                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                  ),
                  SingleChildScrollView(
                      child: Form(
                        child: Column(children: <Widget>[

                          /*
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Align(
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context).primaryColor),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 25, right: 40),
                                    child: Text(
                                      "REGI",
                                      style: TextStyle(
                                        fontSize: 44,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                                Positioned(
                                  child: Align(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 40, left: 28),
                                      width: 130,
                                      child: Text(
                                        "STER",
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          */
                          Padding(
                            padding: EdgeInsets.only(left:20.0),
                            child: Container(
                             alignment:AlignmentDirectional.topStart,
                              child: Text(
                                'Registrarse',style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.only(
                                bottom: 20,
                                top: 30,
                              ),
                              child: CustomTextField(
                                icon: Icon(Icons.account_circle),
                                hint: "Nombre ",
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                onSaved: (input) {
                                  _displayName = input;
                                }
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: CustomTextField(
                                icon: Icon(Icons.account_circle),
                                hint: "Apellidos",
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                onSaved: (input) => _address = input,
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: CustomTextField(
                                icon: Icon(Icons.email),
                                hint: "Correo electronico",
                                onSaved: (input) {
                                  _email = input;
                                },
                                validator: emailValidator,
                              )),
                          Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: CustomTextField(
                                icon: Icon(Icons.phone),
                                onSaved: (input) => _phone= input,
                                validator: (input) =>
                                input.isEmpty ? "*Required" : null,
                                hint: "Telefono movil",
                              )),
                          Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: CustomTextField(
                                icon: Icon(Icons.lock),
                                obsecure: false,
                                onSaved: (input) => _password = input,
                                validator: (input){
                                  if(input.isEmpty){
                                    return "*Requiere la contraseña";
                                  }else{
                                    if(input.length<7){
                                      return "Contraseña debe contener mas de 7 carcateres";
                                    }
                                    return null;
                                  }

                                },
                                //=>
                                //input.isEmpty ? "*Required" : null,
                                hint: "contraseña",
                              )),
                        /*  Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: CustomTextField(
                                icon: Icon(Icons.lock),
                                obsecure: false,
                                validator: (input){
                                  if(input.isEmpty){
                                     return "*Requiere la contraseña";
                                  }else{
                                    if(input == _password){
                                      return null;
                                    }else{
                                      return "contraseña incorrecta";
                                    }
                                  }
                                },
                                hint: "Repetir contraseña",
                              )),*/
                          Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
                              child:Container(
                                alignment: AlignmentDirectional.center,
                                child: Center(
                                  child: Text('(Contraseña debe contar con Mayuscula,numero y simbolo)',style: TextStyle(color: Colors.black38),),
                                ),
                              )),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: CheckBoxCondiciones,
                                  onChanged: (bool value) {
                                    print(value.toString()+ 'respuesta de condiciones');
                                    setState(() {
                                      CheckBoxCondiciones = value;
                                    });
                                  },
                                ),
                                Padding(
                                    padding: EdgeInsets.only(left:10),
                                  child: Text('Aceptar terminos y condiciones de GO'),
                                )
                              ],
                            )
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: 20,
                                right: 20,
                                bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: _loading
                                ? CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  primaryColor),
                            )
                                : Container(
                              child: filledButton(
                                  "Registrarse",
                                  Colors.white,
                                  primaryColor,
                                  primaryColor,
                                  Colors.white,
                                  _validateRegisterInput),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ]),
                        key: _formKey,
                        autovalidate: _autoValidate,
                      )),
                ],
              ),
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        );
      });
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[

            Container(
              height:
              media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.3 :MediaQuery.of(context).size.height * 0.3,
              //color: Colors.yellowAccent,
            ),
            Container(
              height:
              media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.38 :MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                  padding: EdgeInsets.only(left:5.0,right: 5.0),
                child: Form(
                  key: _formKey2,
                  autovalidate: _autoValidate,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(bottom: 20, top: 20),
                          child: CustomTextField(
                            onSaved: (input) {
                              _email = input;
                            },
                            validator: emailValidator,
                            icon: Icon(Icons.email),
                            hint: "correo electronico",
                          )
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: CustomTextField(
                            icon: Icon(Icons.lock),
                            obsecure: true,
                            onSaved: (input) => _password = input,
                            validator: (input) =>
                            input.isEmpty ? "*Required" : null,
                            hint: "contraseña",
                          )
                      ),

                      GestureDetector(
                        onTap: (){

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WElcomeUser(),
                            ),
                          );

                        },
                        child: Padding(
                            padding: EdgeInsets.only(left: 120),
                            child: Text('Olvidates tu contraseña?',style:TextStyle(color:Colors.black54,decoration: TextDecoration.underline),)
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.only(
                          top: 30,
                          left: 80,
                          right: 80,
                          //bottom: MediaQuery.of(context).viewInsets.bottom
                        ),
                        child: _loading == true
                            ? CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              primaryColor),
                        )
                            : Container(
                          child: filledButton(
                              "Iniciar Sesion",
                              Colors.white,
                              Colors.lightBlueAccent,
                              Colors.lightBlueAccent,
                              Colors.white,
                              _validateLoginInput),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),

                    ],
                  ),
                ),
              )
            ),

            Container(
              height:
              media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.32 :MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: <Widget>[
                  Padding(
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'No tienes una cuenta?', style:TextStyle(fontSize: 15)
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:10.0),
                            child: Container(
                                child: GestureDetector(
                                  onTap: (){
                                    registerSheet();
                                  },
                                  child: Text(
                                      'Registrate aqui',
                                      style:TextStyle(fontWeight:FontWeight.bold,color:Colors.black,decoration: TextDecoration.underline,fontSize: 15)
                                  ),
                                )
                            ),
                          )

                        ],
                      )

                    ),
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  ),
                  Padding(
                    child: Container(
                        child:Center(
                          child: Text('O',style: TextStyle(fontSize: 15,color: Colors.black),),
                        )
                    ),
                    padding: EdgeInsets.only(top:0, left: 20, right: 20),
                  ),


                  Padding(
                    child: Container(
                        child:Center(
                         child: Text('Continuar con ',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black38),),
                        )
                    ),
                    padding: EdgeInsets.only(top:10, left: 20, right: 20,bottom: 10),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left:0.0),
                            child: IconButton(
                                icon:Image.asset('assets/googleLogo.png',height: 50,width: 50,),
                                onPressed: () async {
                                  signInWithGoogle();

                                  final SharedPreferences prefs1 = await SharedPreferences.getInstance();
                                  prefs1.setString('email',email);

                                  final SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('sessionValue', true);


                                  setState(() {
                                    isValid=true;
                                    UsuarioModel.keepEmail=prefs1.getString('email');
                                    UsuarioModel.sesion=prefs.getBool('sessionValue');
                                    print(isValid.toString()+'button googlw sigin');
                                  });

                                }
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:0.0),
                            child: IconButton(
                                icon:Image.asset('assets/FacebookLogo.jpg',height: 80,width: 100,fit: BoxFit.cover,),
                                onPressed: (){
                                  signInWithGoogle().whenComplete((){

                                    setState(() {
                                      isValid=true;
                                      print(isValid.toString()+'button googlw sigin');
                                    });

                                    Navigator.of(context).pushReplacementNamed('/home');

                                  });
                                }
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),

                  /*
                  Padding(
                    child: Container(
                      child: outlineButton(registerSheet),
                      height: 50,
                    ),
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                  ),

                  Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Container(
                        color: Colors.redAccent,
                        child: RaisedButton(
                          onPressed: (){

                            signInWithGoogle().whenComplete((){

                              setState(() {
                                isValid=true;
                                print(isValid.toString()+'button googlw sigin');
                              });

                              Navigator.of(context).pushReplacementNamed('/home');

                            });
                          },
                          child: Text('Google',style: TextStyle(color: Colors.white),),
                        ),
                        height: 30.0,
                      )
                  ),

*/
                ],
              ),
            ),


          ],
        )
    );
  }
}
