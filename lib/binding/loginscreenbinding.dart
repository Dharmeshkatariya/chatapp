import 'package:chat_flutter_app/controller/loginscreen_controller.dart';
import 'package:get/get.dart';

class LoginScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginScreenController());
    // TODO: implement dependencies
  }
}
