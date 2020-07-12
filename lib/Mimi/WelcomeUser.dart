
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Mimi/custom/customTextField.dart';
import 'package:tienda_mimi/main.dart';


class WElcomeUser extends StatefulWidget {
  @override
  _WElcomeUserState createState() => _WElcomeUserState();
}

class _WElcomeUserState extends State<WElcomeUser> {

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  String _email;
  String errorMsg="";
  bool _respuesta=false;

  void _validateSendEmailInput() async {
    final FormState form = _formKey2.currentState;
    if (_formKey2.currentState.validate()) {
      form.save();

      try {
        await auth.sendPasswordResetEmail(email: _email);
        setState(() {
          _respuesta=true;
        });
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  height: 100.0,
                  child:Column(
                    children: <Widget>[
                      Text('Mensaje enviado correctamente'),
                      Text('Verificar bandeja de entrada')
                    ],
                  )
                ),
              );
            });
        
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
              //_loading = false;
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
        //_autoValidate = true;
      });
    }
  }

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


  @override
  Widget build(BuildContext context) {
    final media=MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(

        ),
        actions: <Widget>[

          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
                icon: Icon(Icons.clear),
                onPressed: (){
                  Navigator.of(context).pop();
                }
            ),
          )

        ],
      ),

      body:ListView(
        children: <Widget>[

          Container(
            height:
            media.orientation == Orientation.portrait ? MediaQuery.of(context).size.height * 0.5 :MediaQuery.of(context).size.height *0.9,

            child: _respuesta ? AfterSendEmailWidget() :sendEmailWidget(),
          ),
          
          Padding(
              padding:EdgeInsets.only(top:200.0),
            child: OutlineButton(
              highlightedBorderColor: Colors.white,
              borderSide: BorderSide(color: Colors.lightBlue, width: 2.0),
              highlightElevation: 0.0,
              splashColor: Colors.white,
              highlightColor: Theme.of(context).primaryColor,
              color: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0),
              ),
              child: Text(
                "Iniciar sesion",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.lightBlue, fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )

        ],
      ),

    );
  }


  Widget  sendEmailWidget(){
     return Column(
       children: <Widget>[

         Padding(
           padding: EdgeInsets.only(top:10.0),
           child: Container(
               alignment: AlignmentDirectional.topStart,
               child: Text('Recuperar contraseña')
           ),
         ),

         Padding(
           padding: EdgeInsets.only(top:10.0),
           child: Container(
               alignment: AlignmentDirectional.center,
               child: Text('Ingresar correo electronico')
           ),
         ),
         Padding(
           padding: EdgeInsets.only(top:50.0),
           child: Container(

               child:Form(
                   key: _formKey2,
                   child: Column(
                     children: <Widget>[

                       CustomTextField(
                         onSaved: (input) {
                           _email = input;
                         },
                         validator: emailValidator,
                         icon: Icon(Icons.email),
                         hint: "correo electronico",
                       ),
                       Padding(
                         padding: EdgeInsets.only(top:100),
                         child:  Container(
                           child: filledButton(
                               "Enviar mensaje",
                               Colors.white,
                               Colors.lightBlueAccent,
                               Colors.lightBlueAccent,
                               Colors.white,
                               _validateSendEmailInput),
                           height: 50,
                           width: MediaQuery.of(context).size.width,
                         ),
                       )


                     ],
                   )
               )
           ),
         ),


       ],
     );
  }

  Widget   AfterSendEmailWidget(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Container(
        child: Icon(Icons.face,size: 50,),
        ),
        Container(
          child: Text('Se envio un correo electronico para reestablecer la contraseña '),
        ),
        Container(
          child: Text('Verificar su bandeja de entrada '),
        )
      ],
    );
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
}
