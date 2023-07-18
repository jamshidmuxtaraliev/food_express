import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_express/models/cart_model.dart';
import 'package:food_express/models/product_model.dart';
import 'package:food_express/provider/main_provider.dart';
import 'package:food_express/utils/app_colors.dart';
import 'package:provider/provider.dart';

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
    return Consumer<MainProvider>(

      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppColors.TEXTFILED_COLOR, width: 1)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
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
              ),
              const SizedBox(
                height: 6,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.foodItem.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 18),
                      ),
                    ),
                    Icon(
                      Icons.arrow_right_alt_sharp,
                      color: AppColors.ICON_COLOR,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  "${widget.foodItem.price} so'm",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Color(0xFFCAFF37), fontFamily: "medium", fontSize: 18),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                height: 0.5,
                color: AppColors.TEXTFILED_COLOR,
              ),
              (provider.getCartCount(widget.foodItem.id) == 0)
                  ? InkWell(
                      onTap: () {
                        provider.addToCart(CartModel(widget.foodItem.id, 1, widget.foodItem.name,
                            widget.foodItem.price, widget.foodItem.image));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: const Text("Add To Cart", style: TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            var cartCount = provider.getCartCount(widget.foodItem.id);
                            cartCount--;
                            print(cartCount.toString());
                            provider.addToCart(CartModel(widget.foodItem.id, cartCount, widget.foodItem.name,
                                widget.foodItem.price, widget.foodItem.image));
                          },
                          child: Icon(
                            Icons.remove,
                            size: 40,
                            color: AppColors.TEXT_COLOR,
                          ),
                        ),
                        Text(
                          provider.getCartCount(widget.foodItem.id).toString(),
                          style: const TextStyle(fontSize: 24, color: Color(0xFFCAFF37)),
                        ),
                        InkWell(
                          onTap: () {
                            var cartCount = provider.getCartCount(widget.foodItem.id);
                            cartCount++;
                            print(cartCount.toString());
                            provider.addToCart(CartModel(widget.foodItem.id, cartCount, widget.foodItem.name,
                                widget.foodItem.price, widget.foodItem.image));
                          },
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: AppColors.TEXT_COLOR,
                          ),
                        ),
                      ],
                    )
            ],
          ),
        );
      },
    );
  }
}
