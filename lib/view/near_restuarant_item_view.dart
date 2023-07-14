import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express/models/restuarant_model.dart';

import '../generated/assets.dart';
import '../utils/app_colors.dart';
import '../utils/constants.dart';

class NearRestuarantItemView extends StatefulWidget {
  RestuarantModel item;

  NearRestuarantItemView({Key? key, required this.item}) : super(key: key);

  @override
  _NearRestuarantItemViewState createState() => _NearRestuarantItemViewState();
}

class _NearRestuarantItemViewState extends State<NearRestuarantItemView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 18),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              width: 158,
              height: 146,
              imageUrl: "$BASE_IMAGE_URL${widget.item.main_image}",
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                  child: Container(
                      height: 20,
                      width: 20,
                      child: const CircularProgressIndicator(
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
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Text(
              widget.item.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 20),
            ),
          ),
          // Row(
          //   children: [
          //     Image.asset(
          //       Assets.imagesLocation,
          //       width: 18,
          //       height: 18,
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Expanded(
          //       child: Text(
          //         widget.item.address,
          //         style: const TextStyle(color: Colors.white, fontFamily: "regular", fontSize: 18),
          //       ),
          //     ),
          //   ],
          // ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 135,
            height: 1,
            color: AppColors.TEXTFILED_COLOR,
          ),
          Row(
            children: [
              Image.asset(
                Assets.imagesRouting,
                width: 18,
                height: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  "${widget.item.distance?.toStringAsFixed(2)} km",
                  style: const TextStyle(color: Colors.white, fontFamily: "regular", fontSize: 18),
                ),
              ),
            ],
          ),
          // Container(
          //   margin: const EdgeInsets.symmetric(vertical: 8),
          //   width: 135,
          //   height: 1,
          //   color: AppColors.TEXTFILED_COLOR,
          // ),
          // Row(
          //   children: [
          //     Image.asset(
          //       Assets.imagesStarinactive,
          //       width: 18,
          //       height: 18,
          //     ),
          //     const SizedBox(
          //       width: 8,
          //     ),
          //     Expanded(
          //       child: Text(
          //         widget.item.rating.toStringAsFixed(1),
          //         style: const TextStyle(color: Colors.white, fontFamily: "regular", fontSize: 18),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
