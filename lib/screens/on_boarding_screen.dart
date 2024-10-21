import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapplication/Shared/components.dart';
import 'package:shopapplication/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';

class Onboarding {
  final String image;
  final String title;
  final String body;

  Onboarding({required this.image, required this.title, required this.body});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Onboarding> boarding = [
    Onboarding(
      image: 'assets/images/1.png',
      title: ' Shop Millions of Products ',
      body:
          'Everything You Need, Delivered , millions of products across every category, from everyday essentials to the latest tech. Enjoy fast, reliable shipping, easy returns, and unbeatable prices.',
    ),
    Onboarding(
      image: 'assets/images/2.png',
      title: ' Don\'t Miss Out! Huge Savings on Thousands of Items.',
      body:
          'It\'s time to shop til you drop! Our massive sale is here, with incredible discounts on everything from fashion to electronics, home goods to beauty, and so much more.',
    ),
    Onboarding(
      image: 'assets/images/3.png',
      title: 'Shop & Checkout with Ease',
      body:
          'Your Seamless Shopping Journey Starts Here is designed for simplicity. Follow these steps to find your favorites and checkout in minutes',
    ),
  ];

  var swipeController = PageController();

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(themeProvider.themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          TextButton(
            onPressed: () {
              navigateandfinish(context, LoginScreen());
            },
            child: Text('SKIP',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: HexColor('#80532a'),
                      fontSize: 20,
                    )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: swipeController,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildOnBoarding(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: swipeController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    spacing: 3,
                    dotWidth: 13,
                    expansionFactor: 4,
                    activeDotColor: HexColor('#80532a'),
                  ),
                  count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateandfinish(context, LoginScreen());
                    } else {
                      swipeController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  elevation: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(Onboarding model) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image(
                image: AssetImage('${model.image}'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 25,
                color: HexColor('#80532a'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '${model.body}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: HexColor('#dba06b'), fontSize: 19),
            ),
          ],
        ),
      );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
