import 'package:flutter/material.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/category_products/category_products_screen.dart';
import 'package:third_exam/presentation/favourites/favourites_screen.dart';
import 'package:third_exam/presentation/tabs/tab_box/tab_box.dart';
import 'package:third_exam/utils/constants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case tabsRoute:
        return MaterialPageRoute(
          builder: (_) => TabBox(),
        );
      case favouritesRoute:
        return MaterialPageRoute(builder: (_) {
          MyRepository myRepository = settings.arguments as MyRepository;
          return FavouritesScreen(myRepository: myRepository);
        });
      case categoriesProductsRoute:
        return MaterialPageRoute(builder: (_) {
          var list = settings.arguments as List<dynamic>;
          MyRepository myRepository = list[0];
          CategoryItem categoryItem = list[1];
          return CategoryProductsScreen(
            myRepository: myRepository,
            category: categoryItem,
          );
        });
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
