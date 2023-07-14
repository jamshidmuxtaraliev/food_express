import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_colors.dart';

void startScreenR(BuildContext context, StatefulWidget stl){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>stl));
}

void startScreen(BuildContext context, Widget newScreen){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>newScreen));
}

void finishScreen(BuildContext context){
  Navigator.pop(context);
}

LinearGradient backgroundGradiet(){
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.LIGHT_GREY, AppColors.GREY]);
}

LinearGradient buttonGradiet(){
  return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppColors.ICON_COLOR_LIGHT, AppColors.ICON_COLOR]);
}


Future<void> showError(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.blueGrey.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withAlpha(500),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        gradient: const LinearGradient(
                            colors: [Colors.black45, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.error_outlined,
                              size: 36,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Xatolik !!!",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (pressOk != null) {
                                    pressOk();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "Ha",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showWarning(BuildContext context, String message,
    {Function? pressOk, bool? noButton, bool? forSingOut}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.blueGrey.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        gradient: const LinearGradient(
                            colors: [Colors.black45, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 8),
                            const Icon(
                              Icons.warning_rounded,
                              size: 36,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Diqqat !!!",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Visibility(
                                  visible: noButton != null ? true : false,
                                  child: const Text(
                                    "Нет",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                )),
                            TextButton(
                                onPressed: () async {
                                  if (pressOk != null) {
                                    pressOk();
                                    if (forSingOut != true) {
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "OK",
                                  style: const TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Future<void> showSuccess(BuildContext context, String message, {Function? pressOk}) async {
  var size = MediaQuery.of(context).size;
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.blueGrey.withAlpha(10), //this works
    builder: (BuildContext context) {
      return Align(
        alignment: Alignment.center,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                    padding: const EdgeInsets.all(8),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.withAlpha(500),
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        gradient: const LinearGradient(
                            colors: [Colors.black45, Colors.black87],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.cloud_done_outlined,
                              size: 36,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Muvaffaqiyatli.",
                                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(message,
                                      style: const TextStyle(color: Colors.white, fontSize: 16),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (pressOk != null) {
                                    pressOk();
                                    Navigator.pop(context);
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  "OK",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    )),
              ),
            ),
          ),
        ),
      );
    },
  );
}


customTextField(
    {
      String? titleFiled,
      TextEditingController? controller,
      String? label,
      String? fontFamily,
      Color? textColor,
      // String? hintText,
      TextStyle? hintStyle,
      BorderRadius? borderRadius,
      Color? fillColor,
      Color? focusedBorderColor,
      Color? borderColor,
      Color? labelColor,
      double? borderWidth,
      double? focusedBorderWidth,
      bool? borderVisibility,
      EdgeInsetsGeometry? contentPadding,
      bool? enabled,
      TextInputType? textInputType,
      ValueChanged<String>? onChanged,
      List<TextInputFormatter>? inputFormatters,
      TextStyle? textStyle,
      int? maxLength,
      bool? readOnly}) {
  fillColor ??= AppColors.TRANSPARENT;
  borderVisibility ??= true;
  borderWidth ??= borderVisibility ? 1 : 0;
  borderColor ??= borderVisibility ? Colors.black26 : fillColor;
  focusedBorderColor ??= borderVisibility ? Colors.black26 : fillColor;
  focusedBorderWidth ??= borderVisibility ? 1 : 0;
  inputFormatters ??= [];
  textStyle ??= TextStyle(
    color: Colors.white,
    fontSize: 14,
  );
  readOnly ??= false;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(titleFiled != "") Text(titleFiled??"", style: const TextStyle(color: Colors.white, fontSize: 16),),
      if(titleFiled != "") const SizedBox(height: 4,),
      TextFormField(
        enabled: enabled ?? true,
        controller: controller,
        obscureText: false,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        maxLength: maxLength,
        readOnly: readOnly,
        textInputAction: TextInputAction.next,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          counterText: "",

          labelStyle: TextStyle(
            fontFamily: fontFamily,
            color: labelColor ?? textColor,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          // hintText: hintText,
          hintStyle: hintStyle,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.TEXTFILED_COLOR,
              width: borderWidth,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.ICON_COLOR,
              width: focusedBorderWidth,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: fillColor,
          contentPadding: contentPadding ?? const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
        ),
        style: textStyle,
      ),
    ],
  );
}

Widget showMyProgress() {
  return Container(
      alignment: Alignment.center,
      color: AppColors.BLACK_COLOR.withAlpha(90),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.ICON_COLOR_LIGHT,
                blurRadius: 150,
                spreadRadius: 1,
                blurStyle: BlurStyle.normal)
          ],
          // border: Border.all(color: WHITE, width: 1),
          color: AppColors.ICON_COLOR.withAlpha(100),
          borderRadius: BorderRadius.circular(8),
        ),
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.grey,
        ),
      ));
}

showCustomToast(String msg, Icon icon, {Color? bgColor}) {
  FToast fToast = FToast();

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: (bgColor==null) ? Colors.greenAccent : bgColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon,
        const SizedBox(
          width: 12.0,
        ),
        Text(msg),
      ],
    ),
  );


  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}