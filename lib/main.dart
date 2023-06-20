import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:user_firebase/user/view/commerce/buyscreen.dart';
import 'package:user_firebase/user/view/commerce/cartscreen.dart';
import 'package:user_firebase/user/view/commerce/details_screen.dart';
import 'package:user_firebase/user/view/commerce/homeScreen.dart';
import 'package:user_firebase/user/view/login/loginScreen.dart';
import 'package:user_firebase/user/view/login/signup.dart';
import 'package:user_firebase/user/view/login/spleshscreen.dart';
import 'package:user_firebase/user/view/login/welcomeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(
              name: '/',
              page: () => SpleshScreen(),
            ),
            GetPage(
              name: '/welcome',
              page: () => WelcomeScreen(),
            ),
            GetPage(
              name: '/login',
              page: () => LoginScreen(),
            ),
            GetPage(
              name: '/signup',
              page: () => SignupScreen(),
            ),
            GetPage(
              name: '/home',
              page: () => HomeScreen(),
            ),
            GetPage(
              name: '/detail',
              page: () => DetailsScreen(),
            ),
            GetPage(
              name: '/cart',
              page: () => cartscreen(),
            ),
            GetPage(
              name: '/buy',
              page: () => BuyScreen(),
            ),
          ],
        );
      },
    ),
  );
}
