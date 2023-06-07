import 'package:chat_flutter_app/screen/dashboardscreen.dart';
import 'package:chat_flutter_app/screen/loginscreen.dart';
import 'package:chat_flutter_app/screen/splashscreen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'nameroute.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: NameRoutes.loginscreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: NameRoutes.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: NameRoutes.dashBoardScreen,
      page: () => DashBoardScreen(),
    ),
  ];
}
