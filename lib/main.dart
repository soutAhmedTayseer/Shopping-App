import 'package:flutter/material.dart';
import 'package:shop_app/dio/cache_helper.dart';
import 'package:shop_app/shop/login_screen.dart';
import 'package:shop_app/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');

  Widget startWidget;

  if (onBoarding != null && onBoarding == true) {
    startWidget = const LoginScreen();  // Navigate to login if onboarding is done
  } else {
    startWidget = const OnBoardingScreen();  // Show onboarding if not done
  }

  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
    );
  }
}
