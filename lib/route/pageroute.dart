import 'package:chat_flutter_app/binding/loginscreenbinding.dart';
import 'package:chat_flutter_app/binding/number_screen_binding.dart';
import 'package:chat_flutter_app/screen/dashboardscreen.dart';
import 'package:chat_flutter_app/screen/introductionscreen.dart';
import 'package:chat_flutter_app/screen/number_screen.dart';
import 'package:chat_flutter_app/screen/splashscreen.dart';
import 'package:chat_flutter_app/screen/verification_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../binding/verification_binidng.dart';
import 'nameroute.dart';

class PageRoutes {
  static final pages = [
    // GetPage(
    //   name: NameRoutes.loginScreen,
    //   page: () => LoginScreen(),
    //   binding: LoginScreenBinding(),
    // ),

    GetPage(
      name: NameRoutes.numberScreen,
      page: () => NumberScreen(),
      binding: NumberScreenBinding(),
    ),
    GetPage(
      name: NameRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: NameRoutes.dashBoardScreen,
      page: () => DashBoardScreen(),
    ),
    GetPage(
      name: NameRoutes.verificationScreen,
      page: () => VerificationScreen(),
      binding: VerificationBinding(),
    ),

    GetPage(
      name: NameRoutes.introductionViewScreen,
      page: () => IntroductionScreen(),
    ),
  ];
}
