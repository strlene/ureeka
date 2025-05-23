import 'package:flutter/material.dart';
import '../presentation/screen/home.dart';
import '../presentation/screen/cart.dart';
import '../presentation/screen/search.dart';
import '../presentation/screen/detail.dart';
import '../../models/perfume.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => CartScreen());
      case '/search':
        return MaterialPageRoute(builder: (_) => SearchScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
