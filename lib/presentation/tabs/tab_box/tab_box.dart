import 'package:flutter/material.dart';
import 'package:third_exam/data/api/api_provider.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/tabs/all_products/all_products_screen.dart';
import 'package:third_exam/presentation/tabs/cart/cart_screen.dart';
import 'package:third_exam/presentation/tabs/categories/categories_screen.dart';

class TabBox extends StatefulWidget {
  const TabBox({Key? key}) : super(key: key);

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;
  late MyRepository myRepository;
  List<Widget> screens = [];

  @override
  void initState() {
    myRepository = MyRepository(
      apiProvider: ApiProvider(),
    );

    screens = [
      CategoriesScreen(myRepository: myRepository),
      AllProductsScreen(myRepository: myRepository,),
      CartScreen(myRepository: myRepository),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: screens[currentIndex],
      // IndexedStack(
      //   index: currentIndex,
      //   children: screens,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        iconSize: 24,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.white,
        selectedLabelStyle: const TextStyle(color: Colors.green),
        items: [
          getItem(icon: Icons.category_rounded, labelText: "Kategoriya"),
          getItem(icon: Icons.square_rounded, labelText: "Mahsulotlar"),
          getItem(icon: Icons.shopping_basket_rounded, labelText: "Savat"),
        ],
      ),
    );
  }

  BottomNavigationBarItem getItem(
      {required IconData icon, required String labelText}) {
    return BottomNavigationBarItem(
        label: labelText,
        icon: Icon(
          icon,
          color: Colors.black,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.white,
        ));
  }
}
