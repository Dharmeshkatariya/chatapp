import 'package:chat_flutter_app/controller/verificationcontroller.dart';
import 'package:get/get.dart';

class VerificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(VerificationController());
    // TODO: implement dependencies
  }

}