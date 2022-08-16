import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_favourite_product.dart';
import 'package:third_exam/data/local_data/db/cached_product.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/favourites/widgets/favourite_product_view.dart';
import 'package:third_exam/utils/utility_functions.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key, required this.myRepository})
      : super(key: key);

  final MyRepository myRepository;

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sevimlilar"),
      ),
      body: FutureBuilder<List<CachedFavouriteProduct>>(
        future: widget.myRepository.getAllFavouriteProducts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CachedFavouriteProduct>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<CachedFavouriteProduct> data = snapshot.data!;
            return GridView.count(
              padding: const EdgeInsets.all(10),
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6,
              children: List.generate(data.length, (index) {
                var item = data[index];
                return FavouriteProductView(
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

  Future<void> addToBasket(CachedFavouriteProduct item) async {
    int count = 0;
    List<CachedProduct> savedProducts =
        await widget.myRepository.getAllCachedProducts();
    bool beforeSaved = false;
    int savedId = 0;
    for (var element in savedProducts) {
      if (element.productId == item.productId) {
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
          productId: item.productId,
        ),
      );
    } else {
      widget.myRepository.insertCachedProduct(
        cachedProduct: CachedProduct(
          imageUrl: item.imageUrl,
          price: item.price,
          count: 1,
          name: item.name,
          productId: item.productId,
        ),
      );
    }
    UtilityFunctions.getMyToast(
      message: "Mahsulot savatga muvaffaqqiyatli qo'shildi!",
    );
  }
}
