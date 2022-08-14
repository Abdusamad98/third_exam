import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/products/widgets/product_item_view.dart';
import 'package:third_exam/utils/utility_functions.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen(
      {Key? key, required this.myRepository, required this.categoryId})
      : super(key: key);

  final MyRepository myRepository;
  final int categoryId;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
      ),
      body: FutureBuilder<List<ProductItem>>(
        future:
            widget.myRepository.getAllCategoryProducts(id: widget.categoryId),
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
                    if (savedProducts
                        .map((e) => e.productId == item.id)
                        .isNotEmpty) {
                      for (var element in savedProducts) {
                        if (element.productId == item.id) {
                          count = element.count;
                        }
                      }
                    }
                    count += 1;
                    await widget.myRepository.insertCachedProduct(
                      cachedProduct: CachedProduct(
                        imageUrl: item.imageUrl,
                        price: item.price,
                        count: count,
                        name: item.name,
                        productId: item.id,
                      ),
                    );
                    UtilityFunctions.getMyToast(
                      message: "Product added successfully to cart!",
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
