import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_express/api/main_viewmodel.dart';
import 'package:food_express/models/restuarant_model.dart';
import 'package:food_express/provider/main_provider.dart';
import 'package:food_express/utils/pref_utils.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../generated/assets.dart';
import '../../../models/offer_model.dart';
import '../../../models/product_model.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../view/food_item_view.dart';

class RestuarantDetail extends StatefulWidget {
  RestuarantModel restuarant;
  List<OfferModel> categoryList;

  RestuarantDetail({Key? key, required this.restuarant, required this.categoryList}) : super(key: key);

  @override
  _RestuarantDetailState createState() => _RestuarantDetailState();
}

class _RestuarantDetailState extends State<RestuarantDetail> {
  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    final provider = Provider.of<MainProvider>(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (context, viewModel, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(gradient: backgroundGradiet()),
          child: Scaffold(
            backgroundColor: AppColors.TRANSPARENT,
            appBar: AppBar(
              backgroundColor: AppColors.TRANSPARENT,
              elevation: 0,
              title: const Text(
                "Restaurant detail",
                style: TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 24),
              ),
              centerTitle: true,
              leading: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              leadingWidth: 52,
              actions: [
                InkWell(
                  child: Image.asset(
                    Assets.imagesProfile,
                    color: Colors.white,
                    width: 22,
                    height: 22,
                  ),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            width: 335,
                            height: 200,
                            imageUrl: "$BASE_IMAGE_URL${widget.restuarant.main_image}",
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
                          width: 335,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.5), Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  Assets.imagesLogo2,
                                  width: 40,
                                  height: 40,
                                ),
                                Text(
                                  widget.restuarant.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      const TextStyle(color: Colors.white, fontSize: 24, fontFamily: "bold"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18, bottom: 8, left: 20, right: 20),
                    child: Text(
                      "Address",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.imagesLocation,
                                width: 18,
                                height: 18,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.restuarant.address,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: AppColors.TEXT_COLOR, fontFamily: "regular", fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //google Map ga otish
                          },
                          child: Text(
                            "Open the Map",
                            style: TextStyle(
                                color: AppColors.ICON_COLOR,
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: AppColors.TEXT_COLOR,
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
                    child: Text(
                      "Distance",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
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
                            "${widget.restuarant.distance?.toStringAsFixed(2)} km",
                            style:
                                TextStyle(color: AppColors.TEXT_COLOR, fontFamily: "regular", fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: AppColors.TEXT_COLOR,
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
                    child: Text(
                      "Rating",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        RatingBar(
                          initialRating: widget.restuarant.rating,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 5,
                          itemSize: 26,
                          ratingWidget: RatingWidget(
                            // full: Image.asset(Assets.imagesStar),
                            full: const Icon(
                              Icons.star_rounded,
                              color: Color(0xFFCAFF37),
                            ),
                            half: const Icon(
                              Icons.star_half_rounded,
                              color: Color(0xFFCAFF37),
                            ),
                            // empty: Image.asset(Assets.imagesStarinactive),
                            empty: const Icon(
                              Icons.star_outline_rounded,
                              color: Color(0xFFCAFF37),
                            ),
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          widget.restuarant.rating.toStringAsFixed(1),
                          textAlign: TextAlign.start,
                          style: const TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 22),
                        ),
                        Expanded(child: Container()),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              barrierColor: Colors.black.withOpacity(0.3),
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (context, void Function(void Function()) setSTate) {
                                    return DraggableScrollableSheet(
                                        expand: false,
                                        initialChildSize: 0.62,
                                        maxChildSize: 0.62,
                                        builder: (context, scrollController) {
                                          double? rating;
                                          return Container(
                                            padding:
                                            const EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 20),
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.only(
                                                    topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                                                gradient: backgroundGradiet()),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    const Text(
                                                      "Your feedback",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "medium",
                                                          fontSize: 22),
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Icon(
                                                          CupertinoIcons.xmark,
                                                          color: Colors.white,
                                                        ))
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(top: 18.0, bottom: 8),
                                                  child: Text(
                                                    "Feedback",
                                                    style: TextStyle(
                                                        color: Color(0xFFABABAB),
                                                        fontFamily: "regular",
                                                        fontSize: 18),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: commentController,
                                                  minLines: 6,
                                                  maxLines: 6,
                                                  style: const TextStyle(color: Colors.white),
                                                  keyboardType: TextInputType.multiline,
                                                  decoration: InputDecoration(
                                                    hintText: "Write a review",
                                                    hintStyle: const TextStyle(
                                                        color: Colors.grey, fontFamily: "regular"),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors.TEXTFILED_COLOR,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: AppColors.ICON_COLOR,
                                                        width: 1,
                                                      ),
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(top: 16),
                                                  padding: const EdgeInsets.only(
                                                      top: 16, bottom: 18, left: 45, right: 45),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: 0.5, color: AppColors.TEXTFILED_COLOR),
                                                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      const Text(
                                                        "Put a Rating",
                                                        style: TextStyle(
                                                            color: Color(0xFFABABAB),
                                                            fontFamily: "regular",
                                                            fontSize: 18),
                                                      ),
                                                      const SizedBox(
                                                        height: 8,
                                                      ),
                                                      RatingBar(
                                                        initialRating: 0,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        ignoreGestures: false,
                                                        glowColor: CupertinoColors.systemYellow,
                                                        itemCount: 5,
                                                        itemSize: 40,
                                                        ratingWidget: RatingWidget(
                                                          full: const Icon(
                                                            Icons.star_rounded,
                                                            color: Color(0xFFCAFF37),
                                                          ),
                                                          half: const Icon(
                                                            Icons.star_half_rounded,
                                                            color: Color(0xFFCAFF37),
                                                          ),
                                                          empty: const Icon(
                                                            Icons.star_rounded,
                                                            color: Color(0xFF535353),
                                                          ),
                                                        ),
                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                                                        onRatingUpdate: (value) {
                                                          rating = value;
                                                          print(value);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                (viewModel.isProgress)
                                                    ? Container(
                                                  height: 50,
                                                  margin: const EdgeInsets.only(top: 16),
                                                  decoration: BoxDecoration(
                                                      gradient: buttonGradiet(),
                                                      borderRadius: BorderRadius.circular(12)),
                                                  child: const Center(
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                )
                                                    : InkWell(
                                                  onTap: () {
                                                    setSTate(){
                                                      viewModel.makeRatingRestaurant(widget.restuarant.id,
                                                          rating ?? 0, commentController.text ?? "");
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    margin: const EdgeInsets.only(top: 16),
                                                    decoration: BoxDecoration(
                                                        gradient: buttonGradiet(),
                                                        borderRadius: BorderRadius.circular(12)),
                                                    child: const Center(
                                                      child: Text(
                                                        "Leave a review",
                                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                );
                              },
                            );
                          },
                          child: Image.asset(
                            Assets.imagesEdit,
                            width: 24,
                            height: 24,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: AppColors.TEXT_COLOR,
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8, left: 20, right: 20),
                    child: Text(
                      "Contact info",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.imagesCall,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            widget.restuarant.phone,
                            style: TextStyle(color: AppColors.WHITE, fontFamily: "medium", fontSize: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: AppColors.TEXT_COLOR,
                    margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 12, left: 20, right: 20),
                    child: Text(
                      "Foods",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white, fontFamily: "medium", fontSize: 22),
                    ),
                  ),
                  SizedBox(
                    height: 21,
                    child: ListView.builder(
                        padding: const EdgeInsets.only(left: 20),
                        shrinkWrap: true,
                        primary: false,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.categoryList.length,
                        itemBuilder: (context, index) {
                          var item = widget.categoryList[index];
                          return InkWell(
                            onTap: () {
                              provider.setActivCat(widget.categoryList, item.id);
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  item.title ?? "Category",
                                  style: TextStyle(
                                      color: (item.active) ? AppColors.ICON_COLOR : AppColors.TEXT_COLOR,
                                      fontFamily: "regular",
                                      fontSize: 20),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  width: 1,
                                  height: 21,
                                  color: AppColors.ICON_COLOR,
                                )
                              ],
                            ),
                          );
                        }),
                  ),
                  Consumer<MainProvider>(
                    builder: (context, value, child) {
                      return GridView.builder(
                          primary: false,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            top: 18,
                          ),
                          itemCount: value.getProductsByCat(widget.restuarant.product_list ?? []).length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 20, // horizontal
                              crossAxisCount: 2,
                              childAspectRatio: 0.582,
                              mainAxisSpacing: 20 // vertical
                              ),
                          itemBuilder: (_, index) {
                            var foodItem =
                                value.getProductsByCat(widget.restuarant.product_list ?? [])[index];
                            return FoodItemView(foodItem: foodItem);
                          });
                    },
                  ),
                  Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
                    decoration:
                        BoxDecoration(gradient: buttonGradiet(), borderRadius: BorderRadius.circular(12)),
                    child: const Center(
                      child: Text(
                        "Order",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Click order to go to the shopping cart",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.TEXT_COLOR, fontSize: 15),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
