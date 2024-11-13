import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shopapplication/Themes/themes.dart';
import 'package:shopapplication/screens/Shop_Layout.dart';
import 'package:shopapplication/screens/login_screen.dart';
import 'package:shopapplication/screens/on_boarding_screen.dart';
import 'package:shopapplication/screens/splash_screen.dart';
import 'package:shopapplication/shop/cubit_shop.dart';
import 'dio/cache_helper.dart';
import 'dio/dio_helper.dart';
import 'login/cubit_observer.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token')??'';
  print(token);

  if(onBoarding != null)
  {
    if(token.isNotEmpty) widget = ShopLayout();
    else widget = LoginScreen();
  } else
  {
    widget = OnboardingScreen();
  }
  // CacheHelper.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(
        startWidget: widget,
      ),
    ),
  );}

class MyApp extends StatelessWidget {

  Widget? startWidget;


  MyApp({
    this.startWidget,
  });


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: lighttheme,
              darkTheme: darktheme,
              home: SplashScreen(),

            );
          }
      ),
    );
  }
}