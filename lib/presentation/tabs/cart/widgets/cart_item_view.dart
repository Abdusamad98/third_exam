import 'package:flutter/material.dart';
import 'package:third_exam/data/local_data/db/cached_category.dart';
import 'package:third_exam/utils/colors.dart';
import 'package:third_exam/utils/styles.dart';


class CartItemView extends StatelessWidget {
  const CartItemView({Key? key, required this.cachedProduct, required this.onItemTap}) : super(key: key);

  final CachedProduct cachedProduct;
  final VoidCallback onItemTap;


  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(cachedProduct.name),
      subtitle: Text(
        "Mahsulotlar soni:  ${cachedProduct.count} x ${cachedProduct.price}",
        style:
        MyTextStyle.interMedium500.copyWith(color: MyColors.C_4047C1),
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
                child: Image.network(cachedProduct.imageUrl),
              ),
            ),
            const SizedBox(width: 5),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed:onItemTap,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
