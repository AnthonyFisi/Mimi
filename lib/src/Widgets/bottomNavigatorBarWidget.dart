
import 'package:flutter/material.dart';
import 'package:tienda_mimi/src/Screen/OrderScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Shared/ColorShared.dart';

Widget bottomNavigatorBarWidget(context){

  var _curIndex = 0;
  var contents = "Home";


  return BottomNavigationBar(
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
              fontSize: 10, color: _curIndex == 0 ? RED : TEXT_BLACK_LIGHT),
        ),
        activeIcon: Icon(
          Icons.home,
          size: 20,
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
          "Articles",
          style: TextStyle(
              fontSize: 10, color: _curIndex == 1 ? RED : TEXT_BLACK_LIGHT),
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
          "User",
          style: TextStyle(
              fontSize: 10, color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
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
          "User",
          style: TextStyle(
              fontSize: 10, color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
        ),
        activeIcon: Icon(
          Icons.favorite_border,
          size: 20,
          color: RED,
        ),
      ),

      BottomNavigationBarItem(
        icon: Icon(
          Icons.library_books,
          size: 20,
          color: TEXT_BLACK_LIGHT,
        ),
        title: Text(
          "User",
          style: TextStyle(
              fontSize: 10, color: _curIndex == 2 ? RED : TEXT_BLACK_LIGHT),
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
            contents = "Home";

            break;
          case 1:
            contents = "Articles";
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShoppingCartScreen(idUsuario: 1,),
              ),
            );
            break;
          case 3:

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
  );
}

void setState(Null Function() param0) {

}