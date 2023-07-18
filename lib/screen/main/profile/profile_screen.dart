import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_express/utils/app_colors.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../generated/assets.dart';
import '../../../utils/utils.dart';
import '../../../view/custom_clipper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double height = 180;
    TextEditingController phoneController = TextEditingController(text: "+998");
    TextEditingController passwordController = TextEditingController();
    TextEditingController rePasswordController = TextEditingController();
    var phoneFormatter = MaskTextInputFormatter(mask: '+998 (##) ### ## ##');
    OtpFieldController otpbox = OtpFieldController();

    return Scaffold(
        backgroundColor: AppColors.TRANSPARENT,
        body: SingleChildScrollView(
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
                          child: Text("Profile", style: TextStyle(color: AppColors.WHITE, fontFamily: "bold", fontSize: 28),)),
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Container(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              color: Color(0xFF323232),
                              border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR),
                              borderRadius: BorderRadius.all(Radius.circular(18))),
                          child: Image.asset(
                            Assets.imagesProfile,
                            color: Colors.white,
                            width: 50,
                            height: 50,
                          ),
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
                        child: const Text(
                          "FIO",
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )),
                    customTextField(
                        titleFiled: "Phone", controller: phoneController, inputFormatters: [phoneFormatter]),
                    const SizedBox(
                      height: 16,
                    ),
                    customTextField(
                        titleFiled: "Old Password",
                        controller: passwordController,
                        inputFormatters: [phoneFormatter]),
                    const SizedBox(
                      height: 16,
                    ),
                    customTextField(
                        titleFiled: "New Password",
                        controller: rePasswordController,
                        inputFormatters: [phoneFormatter]),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "Confirm with an SMS code",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: "regular"),
                    ),
                    SizedBox(height: 8,),
                    OTPTextField(
                      controller: otpbox,
                      length: 4,
                      width: MediaQuery.of(context).size.width,
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
                      onCompleted: (pin) {
                        print("Entered OTP Code: $pin");
                      },
                    ),
                    // SizedBox(height: 8,),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          margin: const EdgeInsets.only(top: 16),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: AppColors.TEXTFILED_COLOR),
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              "Reply",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),

                        Container(
                          height: 45,
                          margin: const EdgeInsets.only(left:18, top: 16),
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
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
