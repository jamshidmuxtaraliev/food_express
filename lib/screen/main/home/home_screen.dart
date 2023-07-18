import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_express/api/main_viewmodel.dart';
import 'package:food_express/generated/assets.dart';
import 'package:food_express/screen/main/home/restuarant_detail.dart';
import 'package:food_express/utils/utils.dart';
import 'package:food_express/view/restuarant_item_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../view/category_item_view.dart';
import 'package:location/location.dart' as googleLocation;

import '../../../view/near_restuarant_item_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    // showCustomToast("Joylashuv malumotlari olinmoqda !", Icon(Icons.location_on_outlined));
    Fluttertoast.showToast(msg: "Joylashuv malumotlari olinmoqda!");
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) {
      googleLocation.Location location = googleLocation.Location();
      bool ison = await location.serviceEnabled();
      if (!ison) {
        //if defvice is off
        bool isturnedon = await location.requestService();
        if (isturnedon) {
          print("GPS device is turned ON");
        } else {
          print("GPS Device is still OFF");
        }
      }
    }
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () {
        return MainViewModel();
      },
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Container(
              color: AppColors.TRANSPARENT,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                        child: Image.asset(
                          Assets.imagesMenu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset(
                        Assets.imagesLogo,
                        width: 120,
                        height: 40,
                      ),
                      InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                          child: Image.asset(
                            Assets.imagesProfile,
                            color: Colors.white,
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20),
                            child: Row(
                              children: [
                                Image.asset(
                                  Assets.imagesLocation,
                                  width: 22,
                                  height: 22,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Fergana",
                                  style: TextStyle(color: Colors.white, fontFamily: "semibold", fontSize: 24),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                            ),
                            items: viewModel.offerList
                                .map((item) => InkWell(
                                      onTap: () {
                                        print(item.id);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                    color: AppColors.GREY, width: 1, style: BorderStyle.solid),
                                                gradient: LinearGradient(
                                                    colors: [Colors.black.withOpacity(0.3), Colors.white],
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter),
                                                image: DecorationImage(
                                                  image: NetworkImage("$BASE_IMAGE_URL${item.image}"),
                                                  fit: BoxFit.fill,
                                                )),
                                          ),
                                          Container(
                                            alignment: Alignment.bottomLeft,
                                            width: MediaQuery.of(context).size.width,
                                            height: 200,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              gradient: LinearGradient(
                                                  colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(bottom: 16.0, left: 16, right: 8),
                                              child: Text(
                                                item.title ?? "Top Maxsulot",
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 12),
                            child: Row(
                              children: [
                                const Text(
                                  "Category",
                                  style: TextStyle(color: Colors.white, fontFamily: "bold", fontSize: 24),
                                ),
                                Expanded(child: Container()),
                                Row(
                                  children: [
                                    const Text(
                                      "View all",
                                      style: TextStyle(color: Colors.white, fontFamily: "regular", fontSize: 22),
                                    ),
                                    Image.asset(
                                      Assets.imagesArrowRight,
                                      width: 24,
                                      height: 24,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 146,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 20),
                              itemCount: viewModel.categoryList.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                var item = viewModel.categoryList[index];
                                return CategoryItemView(
                                  item: item,
                                );
                              },
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 12),
                            child: Text(
                              "Nearby restuarants",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.white, fontFamily: "bold", fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 20),
                              itemCount: viewModel.nearRestuarants.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                var item = viewModel.nearRestuarants[index];
                                return NearRestuarantItemView(
                                  item: item,
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30, bottom: 12),
                            child: Row(
                              children: [
                                Image.asset(Assets.imagesAward),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Top restaurants",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(color: Colors.white, fontFamily: "bold", fontSize: 24),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 295,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(left: 20),
                              itemCount: viewModel.topRestuarants.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              primary: false,
                              itemBuilder: (context, index) {
                                var item = viewModel.topRestuarants[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RestuarantDetail(
                                                  restuarant: item, categoryList: viewModel.categoryList,
                                                )));
                                  },
                                  child: RestuarantItemView(
                                    item: item,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (viewModel.isProgress) showMyProgress()
          ],
        );
      },
      onViewModelReady: (viewModel) async {
        viewModel.errorData.listen((event) {
          showError(context, event);
        });

        await _getCurrentPosition();
        viewModel.getOffers();
        viewModel.getCategories();
        viewModel.getNearRestuarants(0, 0, 0, 0, "", "distance", 0, _currentPosition?.latitude ?? 0.0,
            _currentPosition?.longitude ?? 0.0);
        viewModel.getTopRestuarants(0, 0, 0, 0, "", "rating", 0, 0.0, 0.0);
      },
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // googleLocation.Location location = googleLocation.Location();
      // bool ison = await location.serviceEnabled();
      // if (!ison) { //if defvice is off
      //   bool isturnedon = await location.requestService();
      //   if (isturnedon) {
      //     print("GPS device is turned ON");
      //   }else{
      //     print("GPS Device is still OFF");
      //   }
      // }
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // googleLocation.Location location = googleLocation.Location();
        // bool ison = await location.serviceEnabled();
        // if (!ison) { //if defvice is off
        //   bool isturnedon = await location.requestService();
        //   if (isturnedon) {
        //     print("GPS device is turned ON");
        //   }else{
        //     print("GPS Device is still OFF");
        //   }
        // }
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // googleLocation.Location location = googleLocation.Location();
      // bool ison = await location.serviceEnabled();
      // if (!ison) { //if defvice is off
      //   bool isturnedon = await location.requestService();
      //   if (isturnedon) {
      //     print("GPS device is turned ON");
      //   }else{
      //     print("GPS Device is still OFF");
      //   }
      // }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
}
