
import 'dart:io';

import 'package:chat_flutter_app/route/nameroute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../firebase/firebase.dart';
import '../modal/usermodal.dart';
import '../utills/app_permission_handler.dart';
import '../utills/image.dart';

class UserProfileController extends GetxController {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  RxBool isLoading = false.obs;
  late String number;
  var selectedImage = "".obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  AppPermission appPermission = AppPermission();
  RxString networkImage = "".obs;
  final nameController = TextEditingController();
  RxString nameError = "".obs;

  void uploadUserData() async {
    if (nameController.text.isEmpty) {
      nameError("Field is required");
    } else if (selectedImage.value == "") {
      printError(info: "Image is required");
    } else {
      nameError.value = "";
      isLoading.value = true;

      AppFirebase appFirebase = AppFirebase();
      // String link = await appFirebase.uploadUserImage(
      //     "profile/image", "2", File(selectedImage.value));
      //  String id = auth.currentUser!.uid ?? "";

      var userModel = UserModel(
          uId: "12",
          name: nameController.text,
          image: selectedImage.value,
          number: number,
          status: "Hey I'm using this app",
          typing: "false",
          online: DateTime.now().toString());
      await appFirebase.createUser(userModel).then((value) => isLoading(false));
      Get.offAllNamed(NameRoutes.dashBoardScreen);
    }
  }



  getImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      var file = await imageFromCamera(true);
      selectedImage.value = file.path;
    } else if (source == ImageSource.gallery) {
      File file = await imageFromGallery(true);
      selectedImage.value = file.path;
    }
  }

  void skipInfo() {
    AppFirebase appFirebase = AppFirebase();
    isLoading.value = true;
    var userModel = UserModel(
        uId: auth.currentUser!.uid,
        name: "",
        image: "",
        number: number,
        status: "Hey i'm using this app",
        typing: "false",
        online: DateTime.now().toString());
    appFirebase.createUser(userModel).then((value) => isLoading(false));
    Get.offAllNamed(NameRoutes.dashBoardScreen);
  }

  void showPicker(BuildContext context) {
    Get.bottomSheet(
        SafeArea(
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.photo_library,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text("Photo Library"),
                  onTap: () async {
                    Navigator.pop(context);
                    var status = await appPermission.isStoragePermissionOk();

                    if (status == PermissionStatus.denied) {
                      var stat = await Permission.storage.request().isDenied;
                      if (stat) {
                        getImage(ImageSource.gallery);
                      } else {
                        printError(info: "Storage Permission denied");
                      }
                    } else if (status == PermissionStatus.granted) {
                      getImage(ImageSource.gallery);
                    } else if (status == PermissionStatus.restricted) {
                      printError(info: "Storage Permission denied");
                    } else if (status == PermissionStatus.limited) {
                      printError(info: "Storage Permission denied");
                    } else if (status == PermissionStatus.permanentlyDenied) {
                      await openAppSettings();
                    }
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.photo_camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  title: const Text("Camera"),
                  onTap: () async {
                    Navigator.pop(context);
                    var status = await appPermission.isCameraPermissionOk();

                    if (status == PermissionStatus.denied) {
                      var status = await Permission.camera.request().isDenied;
                      if (status) {
                        getImage(ImageSource.camera);
                      } else {
                        printError(info: "Camera Permission denied");
                      }
                    } else if (status == PermissionStatus.granted) {
                      getImage(ImageSource.camera);
                    } else if (status == PermissionStatus.restricted) {
                      printError(info: "Camera Permission denied");
                    } else if (status == PermissionStatus.limited) {
                    } else if (status == PermissionStatus.permanentlyDenied) {
                      await openAppSettings();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
  }
}
