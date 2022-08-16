import 'package:flutter/material.dart';
import 'package:third_exam/data/models/product_item.dart';
import 'package:third_exam/utils/colors.dart';
import 'package:third_exam/utils/styles.dart';

class ProductsItemView extends StatelessWidget {
  const ProductsItemView(
      {Key? key,
      required this.item,
      required this.onTap,
      required this.onFavouriteTap,
      required this.isFavourite})
      : super(key: key);

  final ProductItem item;
  final VoidCallback onTap;
  final VoidCallback onFavouriteTap;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.grey),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 8,
                    blurRadius: 5,
                    offset: const Offset(1, 3),
                    color: Colors.grey.shade300)
              ]),
          child: Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
                child: Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: MyTextStyle.interBold700.copyWith(
                    fontSize: 16,
                    color: MyColors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "USD ${item.price}",
                style: MyTextStyle.interSemiBold600.copyWith(
                  fontSize: 18,
                  color: MyColors.C_4047C1,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextButton(
                onPressed: onTap,
                style: TextButton.styleFrom(
                  backgroundColor: MyColors.black,
                ),
                child: Text(
                  "Savatga qo'shish",
                  style: MyTextStyle.interMedium500.copyWith(
                    color: MyColors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 30,
          child: IconButton(
            onPressed: onFavouriteTap,
            icon: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: isFavourite
                  ? const Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
