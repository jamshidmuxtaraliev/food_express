import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_express/models/offer_model.dart';

import '../generated/assets.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class CategoryItemView extends StatefulWidget {
  OfferModel item;
  CategoryItemView({Key? key, required this.item}) : super(key: key);

  @override
  State<CategoryItemView> createState() => _CategoryItemViewState();
}

class _CategoryItemViewState extends State<CategoryItemView> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CachedNetworkImage(
            width: 158,
            height: 146,
            imageUrl: "$BASE_IMAGE_URL${widget.item.image}",
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
        Container(
          alignment: Alignment.bottomLeft,
          width: 158,
          height: 146,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.5),
              Colors.transparent
            ], begin: Alignment.bottomCenter, end: Alignment.center),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom:12.0, left: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.item.title ?? "Category",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontFamily: "semibold"),
                ),
                const Icon(CupertinoIcons.arrow_right, color: Colors.white,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
