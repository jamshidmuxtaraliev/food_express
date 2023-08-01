import 'package:flutter/material.dart';
import 'package:food_express/api/main_viewmodel.dart';
import 'package:food_express/provider/main_provider.dart';
import 'package:food_express/screen/splash/splash_page.dart';
import 'package:food_express/utils/app_colors.dart';
import 'package:food_express/utils/pref_utils.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'dart:ffi';
import 'dart:io';
import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../../view/custom_clipper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double height = 180;
  TextEditingController phoneController =
  TextEditingController(text: PrefUtils
      .getUserData()
      ?.phone ?? "+998");
  TextEditingController nameController =
  TextEditingController(text: PrefUtils
      .getUserData()
      ?.fullname ?? "Unknown User");
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: '+998 (##) ### ## ##');
  OtpFieldController otpbox = OtpFieldController();
  var smsCode = "";

  String imageFile = "";

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      var croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressQuality: 60,
          aspectRatioPresets: [CropAspectRatioPreset.square]
      );
      if (croppedImage != null) {
        setState(() {
          imageFile = croppedImage.path;
        });
      }
    }
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      var croppedImage = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          compressQuality: 60,
          aspectRatioPresets: [CropAspectRatioPreset.square]);
      if (croppedImage!=null) {
        setState(() {
          imageFile = croppedImage.path;
        });
      }
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Scaffold(
            backgroundColor: AppColors.TRANSPARENT,
            body: ViewModelBuilder<MainViewModel>.reactive(
              viewModelBuilder: () {
                return MainViewModel();
              },
              builder: (BuildContext context, viewModel, child) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            clipper: RoundedClipper(height),
                            child: Container(
                              height: height,
                              decoration: BoxDecoration(gradient: buttonGradiet()),
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(top: 12, left: 20),
                                  child: Text(
                                    "Profile",
                                    style:
                                    TextStyle(color: AppColors.WHITE, fontFamily: "bold", fontSize: 28),
                                  )),
                            ),
                          ),
                          Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: Container(
                                alignment: Alignment.center,
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(8),
                                      alignment: Alignment.center,
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFF323232),
                                          border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR),
                                          borderRadius: const BorderRadius.all(Radius.circular(18))),
                                      child: (imageFile == "")
                                          ? Image.asset(
                                        Assets.imagesProfile,
                                        color: Colors.white,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                          : Image.file(
                                        File(imageFile),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: AppColors.ACCENT_AS,
                                            child: const Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(top: 12, bottom: 16),
                                alignment: Alignment.center,
                                child: Text(
                                  PrefUtils
                                      .getUserData()
                                      ?.fullname ?? "FIO",
                                  style: TextStyle(color: Colors.white, fontSize: 24),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                            if (provider.rePasScreen != true)
                              customTextField(
                                  titleFiled: "Name Fullname",
                                  controller: nameController,
                                  readOnly: (!provider.rePasScreen && !provider.updtScreen)),
                            SizedBox(
                              height: (provider.rePasScreen != true) ? 16 : 0,
                            ),
                            customTextField(
                                titleFiled: "Phone",
                                controller: phoneController,
                                inputFormatters: [phoneFormatter],
                                readOnly: !(provider.rePasScreen == false && provider.updtScreen == true)),
                            const SizedBox(
                              height: 24,
                            ),

                            if (provider.rePasScreen == false && provider.updtScreen == false)
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      provider.updateScreen(true);
                                      provider.resetPaswordScreen(false);
                                    },
                                    child: Container(
                                      height: 45,
                                      margin: const EdgeInsets.only(top: 16),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: const Center(
                                        child: Text(
                                          "Update Profile",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20, fontFamily: "medium"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      provider.resetPaswordScreen(true);
                                    },
                                    child: Container(
                                      height: 45,
                                      margin: const EdgeInsets.only(top: 16),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR),
                                          borderRadius: BorderRadius.circular(12)),
                                      child: const Center(
                                        child: Text(
                                          "Update Password",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20, fontFamily: "medium"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      PrefUtils.clearAll();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(builder: (context) => SplashPage()),
                                              (route) => false);
                                    },
                                    child: Container(
                                      height: 45,
                                      margin: const EdgeInsets.only(top: 16, bottom: 16),
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          gradient: buttonGradiet(), borderRadius: BorderRadius.circular(12)),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.logout,
                                              color: AppColors.WHITE,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Text(
                                              "Log  Out",
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 20, fontFamily: "medium"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            //parolni tiklash
                            if (provider.rePasScreen == true)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customTextField(
                                    titleFiled: "Old Password",
                                    controller: passwordController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  customTextField(
                                    titleFiled: "New Password",
                                    controller: rePasswordController,
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  const Text(
                                    "Confirm with an SMS code",
                                    style:
                                    TextStyle(color: Colors.white, fontSize: 20, fontFamily: "regular"),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  OTPTextField(
                                    controller: otpbox,
                                    length: 4,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fieldWidth: 44,
                                    style: const TextStyle(color: Colors.white, fontSize: 17),
                                    textFieldAlignment: MainAxisAlignment.start,
                                    margin: const EdgeInsets.only(right: 18),
                                    fieldStyle: FieldStyle.box,
                                    otpFieldStyle: OtpFieldStyle(
                                        borderColor: AppColors.TEXTFILED_COLOR,
                                        disabledBorderColor: AppColors.TEXTFILED_COLOR,
                                        enabledBorderColor: AppColors.TEXTFILED_COLOR,
                                        focusBorderColor: AppColors.ICON_COLOR),
                                    onChanged: (pin) {
                                      smsCode = pin;
                                    },
                                    onCompleted: (pin) {
                                      smsCode = pin;
                                    },
                                  ),
                                  // SizedBox(height: 8,),
                                ],
                              ),
                            if (provider.updtScreen || provider.rePasScreen)
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        passwordController.clear();
                                        rePasswordController.clear();
                                        nameController.text =
                                            PrefUtils
                                                .getUserData()
                                                ?.fullname ?? "Unknown User";
                                        phoneController.text = PrefUtils
                                            .getUserData()
                                            ?.phone ?? "+998";
                                        provider.resetPaswordScreen(false);
                                        provider.updateScreen(false);
                                      },
                                      child: Container(
                                        height: 45,
                                        margin: const EdgeInsets.only(top: 16),
                                        padding: const EdgeInsets.symmetric(horizontal: 24),
                                        decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: const Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        if (provider.rePasScreen) {
                                          if (passwordController.text == "" ||
                                              rePasswordController.text == "" ||
                                              smsCode == "") {
                                            showError(context, "Kerakli maydonlarni to'ldiring");
                                          } else {
                                            viewModel.resetPassword(passwordController.text,
                                                rePasswordController.text, int.parse(smsCode.toString()));
                                          }
                                        }
                                        if (provider.updtScreen) {}
                                      },
                                      child: Container(
                                        height: 45,
                                        margin: const EdgeInsets.only(left: 18, top: 16),
                                        padding: EdgeInsets.symmetric(horizontal: 24),
                                        decoration: BoxDecoration(
                                            gradient: buttonGradiet(),
                                            borderRadius: BorderRadius.circular(12)),
                                        child: const Center(
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              onViewModelReady: (viewModel) {
                viewModel.errorData.listen((event) {
                  showError(context, event);
                });

                viewModel.rePasswordData.listen((event) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return Container(
                          width: 300,
                          height: 280,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Assets.imagesCertificate),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "You have changed your password",
                                style: TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  passwordController.clear();
                                  rePasswordController.clear();
                                  nameController.text = PrefUtils
                                      .getUserData()
                                      ?.fullname ?? "Unknown User";
                                  phoneController.text = PrefUtils
                                      .getUserData()
                                      ?.phone ?? "+998";
                                  provider.resetPaswordScreen(false);
                                  provider.updateScreen(false);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 45,
                                  margin: const EdgeInsets.only(top: 16),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      gradient: buttonGradiet(), borderRadius: BorderRadius.circular(12)),
                                  child: const Center(
                                    child: Text(
                                      "Update Profile",
                                      style:
                                      TextStyle(color: Colors.white, fontSize: 20, fontFamily: "medium"),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
                });
              },
            ));
      },
    );
  }
}
