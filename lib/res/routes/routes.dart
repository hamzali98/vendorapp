import 'package:get/get.dart';
import 'package:vendor_app/res/routes/routes_name.dart';
import 'package:vendor_app/view/Signup/signUp.dart';
import 'package:vendor_app/view/home/home_view2.dart';

import '../../view/newDropOff/add_new_dropoff_view.dart';
import '../../view/home/dropoff_view.dart';
import '../../view/home/home_view.dart';
import '../../view/login/login_view.dart';
import '../../view/notification.dart';
import '../../view/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.loginView,
          page: () => LoginView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.signUpView,
          page: () => SignupScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.homeView,
          page: () => HomeView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.home2,
          page: () => HomeView2(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.addNew,
          page: () => AddNewDropOff(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: RouteName.dropOff,
          page: () => DropOffTab(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        // ✅ Add this

        GetPage(
          name: RouteName.notificationScreen,
          page: () => NotificationScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        // ✅ Add this
        GetPage(
          name: RouteName.newOrderScreen,
          page: () => NewOrderScreen(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.downToUp,
        ),
      ];
}
