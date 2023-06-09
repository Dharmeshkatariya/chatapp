import 'dart:html';

import 'package:chat_flutter_app/route/nameroute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../firebase/firebase.dart';
import '../utills/image.dart';

class VerificationController extends GetxController{


  RxBool isLoading = false.obs;
  final otpController = TextEditingController();
  final numberController = TextEditingController();
  String code = "+91";
  AppFirebase appFirebase = AppFirebase();
  late String number;
  RxString numberError =  "".obs;
  RxString nameError = "".obs;

  RxString pinError = "".obs;


  void sendOTP() async {
    if (numberController.text.isEmpty) {
      numberError("Field is required");
    } else if (numberController.text.length < 10) {
      numberError.value = "Invalid Number";
    } else {
      numberError("");
      number = code + numberController.text;
      await appFirebase.sendVerificationCode(number);
    }
  }

  void verifyOTP() async {
    if (otpController.text.isEmpty) {
      pinError.value = "Field is required";
    } else if (otpController.text.length < 6) {
      pinError.value = "Invalid Pin";
    } else {
      isLoading.value = true;
      await appFirebase.verifyOTP(otpController.text);
      isLoading.value = false;
     Get.offNamed(NameRoutes.userProfileScreen);
    }
  }
  // void getImage(ImageSource source) async {
  //   switch (source) {
  //     case ImageSource.camera:
  //       File file = (await imageFromCamera(true)) as File;
  //       selectedImage.value = file.path;
  //       break;
  //     case ImageSource.gallery:
  //       File file = await imageFromGallery(true);
  //       selectedImage.value = file.path;
  //       break;
  //   }
  // }


}