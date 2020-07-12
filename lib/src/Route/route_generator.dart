import 'package:flutter/material.dart';
import 'package:tienda_mimi/Mimi/Login-Register.dart';
import 'package:tienda_mimi/Mimi/home.dart';
import 'package:tienda_mimi/Service/Model/CategoriesModel.dart';
import 'package:tienda_mimi/Service/Model/HorarioModel.dart';
import 'package:tienda_mimi/Service/Model/ProductoJOINCategoriaJOINImagenModel.dart';
import 'package:tienda_mimi/Service/Model/SubCategoriaModel.dart';
import 'package:tienda_mimi/src/Screen/AfterCheckoutScreen.dart';
import 'package:tienda_mimi/src/Screen/CheckOutScreen.dart';
import 'package:tienda_mimi/src/Screen/DetailProductScreen.dart';
import 'package:tienda_mimi/src/Screen/HomeScreen.dart';
import 'package:tienda_mimi/src/Screen/ListCategoriesScreen.dart';
import 'package:tienda_mimi/src/Screen/ListSubcategoriesProductsScreen.dart';
import 'package:tienda_mimi/src/Screen/OrderScreen.dart';
import 'package:tienda_mimi/src/Screen/PerfilScreen.dart';
import 'package:tienda_mimi/src/Screen/ScheduleScreen.dart';
import 'package:tienda_mimi/src/Screen/SearchResultScreen.dart';
import 'package:tienda_mimi/src/Screen/SearchScreen.dart';
import 'package:tienda_mimi/src/Screen/ShoppingCartScreen.dart';
import 'package:tienda_mimi/src/Screen/SuccsesfullSellScreen.dart';
import 'package:tienda_mimi/src/Widgets/LoaderScreen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());


      case '/ListCategoriesScreen':
      // Validation of correct data type
        if (args is CategoriesModel) {
          return MaterialPageRoute(
            builder: (_) => ListCategoriesScreen(
              categoriesModel: args,
            ),
          );
        }
        return _errorRoute();


      case '/SuccsesfullScreen':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => SuccsesfullSellScreen(
          ),
        );

      case '/homeProof':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => Home(
          ),
        );


      case '/LoginRegister':
      // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => LoginRegister(
          ),
        );

    // If args is not of the correct type, return an error page.
    // You can also throw an exception while in development.
      case '/ListSubCategoriesProductsScreen':

        if (args is SubCategoriaModel) {
          return MaterialPageRoute(
            builder: (_) => ListSubCategoriesProductsScreen(
              subCategoriaModel: args,
            ),
          );
        }
        return _errorRoute();

      case '/DetailProductScreen':

        if (args is ProductoJOINCategoriaJOINImagenModel) {
          return MaterialPageRoute(
            builder: (_) => DetailProductScreen(
              productoJOINCategoriaJOINImagenModel: args,
            ),
          );
        }
        return _errorRoute();


      case '/ShoppingCartScreen':

        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => ShoppingCartScreen(
              idUsuario: args,
            ),
          );
        }
        return _errorRoute();

      case '/ScheduleScreen':

        return MaterialPageRoute(
          builder: (_) => ScheduleScreen(
          ),
        );

      case '/CheckOutScreen':

        if (args is HorarioModelCompleto) {
          return MaterialPageRoute(
            builder: (_) => CheckOutScreen(
              horarioModelCompleto : args,
            ),
          );
        }
        return _errorRoute();


      case '/OrderScreen':

        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => OrderScreen(
              idUsuario: args,
            ),
          );
        }
        return _errorRoute();

      case '/SearchScreen':
        return MaterialPageRoute(
          builder: (_) => SearchScreen(
          ),
        );


      case '/LoaderScreen':
        return MaterialPageRoute(
          builder: (_) => LoaderScreen(
          ),
        );

      case '/AfterCheckoutScreen':
        return MaterialPageRoute(
          builder: (_) => AfterCheckoutScreen(
          ),
        );

      case '/PerfilScreen':
        return MaterialPageRoute(
          builder: (_) => PerfilScreen(
          ),
        );


      case '/SearchResultScreen':

        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SearchResult1Screen(
              palabraClave: args,
            ),
          );
        }
        return _errorRoute();
      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}