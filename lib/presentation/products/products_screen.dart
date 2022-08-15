import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/products/widgets/product_item_view.dart';
import 'package:third_exam/utils/utility_functions.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({
    Key? key,
    required this.myRepository,
    required this.category,
  }) : super(key: key);

  final MyRepository myRepository;
  final CategoryItem category;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder<List<ProductItem>>(
        future:
            widget.myRepository.getAllCategoryProducts(id: widget.category.id),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductItem>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<ProductItem> data = snapshot.data!;
            return GridView.count(
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
              children: List.generate(data.length, (index) {
                var item = data[index];
                return ProductsItemView(
                  item: item,
                  onTap: () async {
                    int count = 0;
                    List<CachedProduct> savedProducts =
                        await widget.myRepository.getAllCachedProducts();
                    bool beforeSaved = false;
                    int savedId = 0;
                    for (var element in savedProducts) {
                      if (element.productId == item.id) {
                        beforeSaved = true;
                        savedId = element.id!;
                        count = element.count;
                      }
                    }
                    if (beforeSaved) {
                      count += 1;
                      await widget.myRepository.updateCachedProductById(
                        id: savedId,
                        cachedProduct: CachedProduct(
                          imageUrl: item.imageUrl,
                          price: item.price,
                          count: count,
                          name: item.name,
                          productId: item.id,
                        ),
                      );
                    } else {
                      widget.myRepository.insertCachedProduct(
                        cachedProduct: CachedProduct(
                          imageUrl: item.imageUrl,
                          price: item.price,
                          count: 1,
                          name: item.name,
                          productId: item.id,
                        ),
                      );
                    }

                    UtilityFunctions.getMyToast(
                      message: "Mahsulot savatga muvaffaqqiyatli qo'shildi!",
                    );
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
