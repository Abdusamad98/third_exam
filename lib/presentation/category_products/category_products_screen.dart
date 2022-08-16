import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_favourite_product.dart';
import 'package:third_exam/data/local_data/db/cached_product.dart';
import 'package:third_exam/data/models/category_item.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/category_products/widgets/product_item_view.dart';
import 'package:third_exam/utils/utility_functions.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({
    Key? key,
    required this.myRepository,
    required this.category,
  }) : super(key: key);

  final MyRepository myRepository;
  final CategoryItem category;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<CachedFavouriteProduct> favourites = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder<dynamic>(
        future: Future.wait([
          widget.myRepository.getAllFavouriteProducts(),
          widget.myRepository.getAllCategoryProducts(id: widget.category.id)
        ]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            favourites = snapshot.data[0]! as List<CachedFavouriteProduct>;
            List<ProductItem> data = snapshot.data[1]! as List<ProductItem>;
            return GridView.count(
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
              children: List.generate(data.length, (index) {
                var item = data[index];
                return ProductsItemView(
                  onFavouriteTap: () => addToFavourites(item),
                  isFavourite: isFavouriteProduct(item),
                  item: item,
                  onTap: () => addToBasket(item),
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

  Future<void> addToBasket(ProductItem item) async {
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
  }

  Future<void> addToFavourites(ProductItem item) async {
    if (favourites.map((e) => e.productId).toList().contains(item.id)) {
      widget.myRepository.deleteFavouriteProductById(
        id: favourites.where((e) => e.productId == item.id).toList()[0].id!,
      );
      setState(() {});
    } else {
      widget.myRepository.insertFavouriteProduct(
        favouriteProduct: CachedFavouriteProduct(
            imageUrl: item.imageUrl,
            price: item.price,
            name: item.name,
            productId: item.id),
      );
      UtilityFunctions.getMyToast(
        message: "Added to favourites!",
      );
      setState(() {});
    }
  }

  bool isFavouriteProduct(ProductItem item) =>
      favourites.map((e) => e.productId).toList().contains(item.id);
}


