import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/pages/home_screen.dart';
import 'package:quiz_app/pages/splash_screen.dart';
import 'package:quiz_app/theme/custom_colors.dart';
import 'package:quiz_app/utils/utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: CustomColors.deepBlue1,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: CustomColors.deepBlue1,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: CustomFontFamily.rubikRegular.fontFamily,
                bodyColor: Colors.white,
              ),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent)),
      home: const SplashScreen(),
    );
  }
}
