import 'dart:io';

import 'package:chat_flutter_app/route/nameroute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../firebase/firebase.dart';
import '../modal/usermodal.dart';
import '../utills/app_permission_handler.dart';

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

      networkImage.value =
          uploadImageToStorage("userfile", "/${auth.currentUser!.email}");
      var userModel = UserModel(
          uId: auth.currentUser!.uid,
          name: nameController.text,
          image: networkImage.value,
          number: number,
          status: "Hey I'm using this app",
          typing: "false",
          online: DateTime.now().toString());
      await appFirebase.createUser(userModel).then((value) => isLoading(false));
      Get.offAllNamed(NameRoutes.dashBoardScreen);
    }
  }

  uploadImageToStorage(String childName, String filepath) async {
    String storeImage = "";
    Reference ref =
        firebaseStorage.ref().child(childName).child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(File(filepath));
    await Future.value(uploadTask);
    storeImage = await ref.getDownloadURL();
    return storeImage;
  }

// void showPicker(BuildContext context) {
//   Get.bottomSheet(
//       SafeArea(
//         child: Container(
//           color: Theme.of(context).backgroundColor,
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: Icon(
//                   Icons.photo_library,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 title: const Text("Photo Library"),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   var status = await appPermission.isStoragePermissionOk();
//                   switch (status) {
//                     case PermissionStatus.denied:
//                       var status =
//                       await Permission.storage.request().isDenied;
//                       if (status) {
//                         getImage(ImageSource.gallery);
//                       } else {
//                         printError(info: "Storage Permission denied");
//                       }
//                       break;
//                     case PermissionStatus.granted:
//                       getImage(ImageSource.gallery);
//                       break;
//                     case PermissionStatus.restricted:
//                       printError(info: "Storage Permission denied");
//                       break;
//                     case PermissionStatus.limited:
//                       printError(info: "Storage Permission denied");
//                       break;
//                     case PermissionStatus.permanentlyDenied:
//                       await openAppSettings();
//                       break;
//                   }
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.photo_camera,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 title: const Text("Camera"),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   var status = await appPermission.isCameraPermissionOk();
//                   switch (status) {
//                     case  PermissionStatus.denied:
//                       var status = await Permission.camera.request().isDenied;
//                       if (status) {
//                         getImage(ImageSource.camera);
//                       } else {
//                         printError(info: "Camera Permission denied");
//                       }
//                       break;
//                     case PermissionStatus.granted:
//                       getImage(ImageSource.gallery);
//                       break;
//                     case PermissionStatus.restricted:
//                       printError(info: "Camera Permission denied");
//                       break;
//                     case PermissionStatus.limited:
//                       printError(info: "Camera Permission denied");
//                       break;
//                     case PermissionStatus.permanentlyDenied:
//                       await openAppSettings();
//                       break;
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Theme.of(context).backgroundColor,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)));
// }
}
