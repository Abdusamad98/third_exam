import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_product.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/presentation/tabs/cart/widgets/cart_item_view.dart';
import 'package:third_exam/utils/colors.dart';
import 'package:third_exam/utils/styles.dart';
import 'package:third_exam/utils/utility_functions.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, required this.myRepository}) : super(key: key);

  final MyRepository myRepository;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Savatcha"),
        actions: [
          TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          "Rostdan ham savatchadi barcha mahsulotlarni o'chirmoqchimisiz?"),
                      actions: [
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () async {
                            await widget.myRepository.clearAllCachedProducts();
                            setState(() {});
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
            child: Text(
              "Tozalash",
              style: MyTextStyle.interSemiBold600.copyWith(
                color: MyColors.white,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<CachedProduct>>(
        future: widget.myRepository.getAllCachedProducts(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CachedProduct>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            List<CachedProduct> data = snapshot.data!;
            var totalPrice = data.isNotEmpty?data.map((e) => (e.price * e.count)).reduce(
                  (value, element) => value + element,
                ):0;
            return Column(
              children: [
                Expanded(
                    child: ListView(
                  children: List.generate(data.length, (index) {
                    var cachedItem = data[index];
                    return CartItemView(
                      cachedProduct: cachedItem,
                      onItemTap: () async {
                        await widget.myRepository.deleteCachedProductById(
                          id: cachedItem.id!,
                        );
                        UtilityFunctions.getMyToast(message: "O'chirildi!");
                        setState(() {});
                      },
                    );
                  }),
                )),
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          spreadRadius: 7,
                          color: Colors.grey.shade300,
                          offset: const Offset(1, 4),
                        )
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Umumiy summa  --->",
                        style: MyTextStyle.interSemiBold600.copyWith(
                          fontSize: 20,
                          color: MyColors.black,
                        ),
                      ),
                      Text(
                        "\$ $totalPrice",
                        style: MyTextStyle.interSemiBold600.copyWith(
                          fontSize: 20,
                          color: MyColors.C_4047C1,
                        ),
                      )
                    ],
                  ),
                )
              ],
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
