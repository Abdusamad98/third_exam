import 'package:flutter/material.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/category_products/category_products_screen.dart';
import 'package:third_exam/presentation/tabs/categories/widgets/category_item.dart';
import 'package:third_exam/utils/constants.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key, required this.myRepository})
      : super(key: key);

  final MyRepository myRepository;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategoryalar ro'yxati"),
      ),
      body: FutureBuilder<List<CategoryItem>>(
        future: widget.myRepository.getAllCategories(),
        builder:
            (BuildContext context, AsyncSnapshot<List<CategoryItem>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<CategoryItem> data = snapshot.data!;
            return ListView(
              children: List.generate(data.length, (index) {
                return CategoryItemView(
                  categoryItem: data[index],
                  onTap: () {
                    Navigator.pushNamed(
                        context, categoriesProductsRoute, arguments: [widget
                        .myRepository, data[index],
                    ]);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) {
                    //       return CategoryProductsScreen(
                    //         category:,
                    //         myRepository: widget.myRepository,
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
