import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/pages/home_screen.dart';
import 'package:quiz_app/pages/results_page.dart';
import 'package:quiz_app/pages/splash_screen.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
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

    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      builder: (context, child) => MaterialApp(
        title: 'Quiz App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: CustomColors.deepBlue1,
          textTheme: Theme.of(context).textTheme.apply(
                fontFamily: CustomFontFamily.rubikRegular.fontFamily,
                bodyColor: Colors.white,
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.transparent,
            titleTextStyle: TextStyle(
              fontFamily: CustomFontFamily.rubikMedium.fontFamily,
              fontSize: 24,
              color: CustomColors.green,
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
