import 'package:flutter/material.dart';
import 'package:tienda_mimi/Service/Api/ProductoJOINCategoriaJOINImagenApi.dart';
import 'package:http/http.dart' as http;


class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black54,
          ),
        ),
        backgroundColor: Colors.white,
        title: Text('Busca lo que deseas',style: TextStyle(
            fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.black54),),
        actions: <Widget>[

          FutureBuilder<List<String>>(
              future: fetchLista(http.Client()),
             builder: ( context,  snapshot) {
              if(snapshot.data != null){
               return IconButton(

                   icon:Icon(Icons.search,color: Colors.black54,),
                   onPressed: (){
                     showSearch(context: context, delegate: DataSearch(snapshot.data));
                   }
               );
              }else{
                return IconButton(

                    icon:Icon(Icons.search,color: Colors.black54,),
                   onPressed: (){},
                );
              }
             }
          ),

        ],
      ),
      drawer: Drawer(),
    );
  }
}


class DataSearch extends SearchDelegate<String>{

  final List<String> lista;
  bool rpta=false;

   var recentCities =[
    "Fresas",
     "Arroz"
  ];
  var recentCities2 =[];
  DataSearch(
      this.lista,
      );


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
          query="";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation),
      onPressed: (){
          close(context,null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(rpta==false){
      for(int i=0;i<lista.length;i++){
        recentCities2.add(lista.toList().removeAt(i));
        rpta=true;
      }
    }
   //Prima 932875907

    final suggestionList= query.isEmpty
        ?recentCities
        :recentCities2.where((p)=> p.toLowerCase().contains(query)).toList();

    return ListView.builder(itemBuilder: (context,index)=> GestureDetector(
      onTap: (){

        Navigator.of(context).pushNamedAndRemoveUntil('/SearchResultScreen', ModalRoute.withName('/'),arguments: suggestionList[index]);
      },
      child: ListTile(
        leading: Icon(Icons.search,color: Colors.black54,),
        title: Text(suggestionList[index]),

      ),
    ),
      itemCount: suggestionList.length,
    );

  
  }

}