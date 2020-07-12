import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/HorarioApi.dart';
import 'package:tienda_mimi/Service/Model/HorarioModel.dart';
import 'package:tienda_mimi/src/Screen/CheckOutScreen.dart';
import 'package:http/http.dart' as http;
import 'package:tienda_mimi/src/Shared/ColorShared.dart';



class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {

  String horario1='8:00';
  String horario2='9:00';
  String horario3='18:00';
  String horario4='19:00';

  DateTime fecha=DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 25,
                color: Color.fromRGBO(5, 175, 242, 1),
              ),
              onPressed: (){
                Navigator.of(context).pop();

              }
          ),
          title: Container(
            alignment: AlignmentDirectional.center,
            width: MediaQuery.of(context).size.width*0.7,
            child: Text(' Horarios',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black38),),
          ),
          backgroundColor: Colors.white,
          elevation: 1.0,
          actions: <Widget>[
            /*
            Padding(
              padding: EdgeInsets.only(
                right: 20.0,
              ),
              child:  Icon(
                Icons.shopping_basket,
                size: 25,
                color: Colors.black38,
              ),
            )
          */
          ],

        ),

      body: CustomScrollView(
        slivers: <Widget>[

   /*       SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromRGBO(255, 216, 63, 1),
            actions: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:Padding(
                    padding: EdgeInsets.only(
                      right: 20.0,
                    ),
                    child:  Icon(
                      Icons.clear,
                      size: 25,
                      color: Colors.white,
                    ),
                  )
              )
            ],
          ),
*/
  /*
   SliverToBoxAdapter(
            child:  Container(
              height: 125.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/dateWallpaper3.png'),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(padding: EdgeInsets.all(10.0),
                child: Text('Horarios',style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
              /*
                        child: Card(
                        //color: Color.fromRGBO(5, 175, 242, 1),
                        color:Color.fromRGBO(88, 204, 167, 1),
                        child: ListTile(

                          subtitle: Text('Carrito de compra',style: TextStyle(fontSize: 25,color: Colors.white),),
                          trailing: Padding(
                              padding:EdgeInsets.only(bottom: 2.0),
                            child:Icon(Icons.clear,color: Colors.white,size: 25,),
                          ),
                        ),
                      ),
                      */

            ),
          ),
*/
/*
        SliverToBoxAdapter(

          child: Padding(padding:EdgeInsets.only(top:20.0),
          child: Container(
            height: 70.0,
            decoration: new BoxDecoration(
              color:Colors.white,
              borderRadius: new BorderRadius.only(
                topLeft:  const  Radius.circular(0.0),
                topRight: const  Radius.circular(0.0),
                bottomLeft: const  Radius.circular(0.0),
                bottomRight: const  Radius.circular(20.0),
              ),
            ),
            child: Row(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text('Horarios',style: TextStyle(fontSize: 30.0,color: Colors.black,fontWeight: FontWeight.bold),),
                ),
              ],
            ),
          ),
          )
        ),
*/
/*
          SliverToBoxAdapter(
            child:
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Elige el mejor momento para tu entrega',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.bold
                        ),),
                    )

                  ],
                ),
              ),
            ),
          ),
*/

SliverToBoxAdapter(
  child: SizedBox(
    height: 10.0,
  ),
),

          SliverToBoxAdapter(
            child:
            DatePickerTimeline(
              DateTime.now(),
              locale: "ES",

              onDateChange: (date) {
                // New date selected
                print(date.day.toString());
                fecha=date;
              },
            ),
          ),


          SliverToBoxAdapter(
             child: Container(
                height: 500.0,
                child: FutureBuilder<List<HorarioModel>>(
                  future: fetchHorarioModel(http.Client()),
                  builder: (context,snapshot){
                    if(snapshot.data != null){
                      return
                        ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context,index){
                              return GestureDetector(
                                onTap: (){
                                 /* Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                      CheckOutScreen(
                                        horarioModelCompleto:new HorarioModelCompleto(
                                            idhorario:snapshot.data[index].idhorario,
                                            horario_nombre: snapshot.data[index].horario_nombre,
                                            fecha:fecha
                                        ) ,
                                      )));
                                  */
                                  Navigator.of(context).pushNamed('/CheckOutScreen',
                                      arguments: new HorarioModelCompleto(
                                          idhorario:snapshot.data[index].idhorario,
                                          horario_nombre: snapshot.data[index].horario_nombre,
                                          fecha:fecha
                                      ) ,
                                  );
                                },
                                child: Card(
                                  child: Container(
                                      height: 50.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.access_time,color:Color.fromRGBO(5, 175, 242, 1),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left:8.0),
                                              child: Text(snapshot.data[index].horario_nombre),
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                ),
                              );
                            }
                        );

                    }else{
                      return Container(
                        child: Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.cyan,
                              strokeWidth: 5,
                            )),
                      );
                    }

                  },
                ),
              )
          ),

        ],
      )

    );
  }
}
