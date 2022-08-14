import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/data/my_repository.dart';
import 'package:third_exam/utils/colors.dart';
import 'package:third_exam/utils/styles.dart';

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
        title: const Text("Cart"),
        actions: [
          TextButton(
            onPressed: () async {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                          "Are you sure you want to delete all products in cart"),
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
              "Clear all",
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
            return ListView(
              children: List.generate(data.length, (index) {
                var cachedItem = data[index];
                return ListTile(
                  title: Text(cachedItem.name),
                  subtitle: Text(
                    "Count:  ${cachedItem.count}",
                    style:
                        MyTextStyle.interMedium500.copyWith(color: Colors.red),
                  ),
                  trailing: SizedBox(
                    width: 115,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(cachedItem.imageUrl),
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  ),
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
