import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express/models/product_model.dart';
import 'package:food_express/utils/app_colors.dart';

import '../generated/assets.dart';
import '../utils/constants.dart';

class FoodItemView extends StatefulWidget {
  ProductModel foodItem;
  FoodItemView({Key? key, required this.foodItem}) : super(key: key);

  @override
  _FoodItemViewState createState() => _FoodItemViewState();
}

class _FoodItemViewState extends State<FoodItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(color: AppColors.TEXT_COLOR, width: 1)
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              width: 134,
              height: 124,
              imageUrl: "$BASE_IMAGE_URL${widget.foodItem.image}",
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.grey,
                      ))),
              errorWidget: (context, url, error) => ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      color: Colors.grey.shade50,
                      child: Image.asset(
                        Assets.imagesDefaultImg,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
