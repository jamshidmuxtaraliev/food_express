import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_express/api/auth_viewmodel.dart';
import 'package:food_express/generated/assets.dart';
import 'package:food_express/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../utils/utils.dart';
import '../main/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController(text: "+998");
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  var phoneFormatter = MaskTextInputFormatter(mask: '+998 (##) ### ## ##');

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<LoginProvider>(context);
    return ViewModelBuilder.reactive(
      viewModelBuilder: () {
        return AuthViewModel();
      },
      builder: (BuildContext context, viewModel, child) {
        return Consumer<LoginProvider>(
          builder: (context, provider, child) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(gradient: backgroundGradiet()),
              child: Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(gradient: backgroundGradiet()),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 76, bottom: 60),
                          child: Image.asset(
                            Assets.imagesLogo,
                            height: 60,
                            width: 200,
                          ),
                        ),
                        const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Visibility(
                          visible: !provider.isLogin,
                          child: customTextField(titleFiled: "FullName", controller: fullNameController,),
                        ),
                        SizedBox(
                          height: (!provider.isLogin) ? 16 : 0,
                        ),
                        customTextField(
                            titleFiled: "Phone",
                            controller: phoneController,
                            inputFormatters: [phoneFormatter]),
                        const SizedBox(
                          height: 16,
                        ),
                        customTextField(titleFiled: "Password", controller: passwordController),
                        SizedBox(
                          height: (!provider.isLogin) ? 16 : 0,
                        ),
                        Visibility(
                          visible: !provider.isLogin,
                          child:
                              customTextField(titleFiled: "Reset Password", controller: rePasswordController),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        (viewModel.isProgress)
                            ? Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    gradient: buttonGradiet(), borderRadius: BorderRadius.circular(12)),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  if (provider.isLogin) {
                                    if (phoneController.text == "" || passwordController.text == "") {
                                      showWarning(context, "Barcha kerakli maydonlarni to'ldiring !");
                                    } else {
                                      viewModel.login(phoneController.text.replaceAll(" ", "").replaceAll("+", "").replaceAll("(", "").replaceAll(")", ""), passwordController.text);
                                    }
                                  } else {
                                    if (fullNameController.text == "" ||
                                        phoneController.text == "" ||
                                        passwordController.text == "") {
                                      showWarning(context, "Barcha kerakli maydonlarni to'ldiring !");
                                    } else if (passwordController.text != rePasswordController.text) {
                                      showWarning(context, "Parollar mosligini tekshiring");
                                    } else {
                                      viewModel.register(
                                          phoneController.text.replaceAll(" ", "").replaceAll("+", ""),
                                          fullNameController.text,
                                          passwordController.text);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      gradient: buttonGradiet(), borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Text(
                                      (provider.isLogin) ? "Login" : "Registration",
                                      style: const TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                        InkWell(
                          onTap: () {
                            print("Click Registration !!!");
                            provider.setLoginState();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: Text(
                              (provider.isLogin) ? "Registration" : "Login",
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      onViewModelReady: (viewModel) {
        viewModel.errorData.listen((event) {
          showError(context, event);
        });

        viewModel.registerData.listen((event) {
          print("login stream coming");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
        });
      },
    );
  }
}
