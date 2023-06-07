import 'package:chat_flutter_app/controller/loginscreen_controller.dart';
import 'package:chat_flutter_app/controller/numberscreen_contrioller.dart';
import 'package:get/get.dart';

class NumberScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NumberScreenController());
    // TODO: implement dependencies
  }
}
