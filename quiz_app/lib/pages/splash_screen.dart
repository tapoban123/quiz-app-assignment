import 'package:flutter/material.dart';
import 'package:quiz_app/api/api_service.dart';
import 'package:quiz_app/pages/home_screen.dart';
import 'package:quiz_app/theme/custom_colors.dart';
import 'package:quiz_app/utils/app_images.dart';
import 'package:quiz_app/utils/utils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ApiService().fetchQuestions();
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 450,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                color: CustomColors.deepBlue4,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          CustomColors.blue2,
                          CustomColors.pink,
                          CustomColors.red,
                          CustomColors.orange,
                          CustomColors.yellow,
                          CustomColors.lightOrange,
                        ],
                      ).createShader(bounds),
                      child: Image.asset(
                        AppImages.bulbImage,
                        fit: BoxFit.fill,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: Text(
                      "Quizzles",
                      style: TextStyle(
                        fontFamily: CustomFontFamily.rubikSemiBold.fontFamily,
                        fontSize: 45,
                        color: CustomColors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: Column(
                children: [
                  Text(
                    "Let's Play!",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: CustomFontFamily.rubikMedium.fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Get smarter everyday",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: CustomFontFamily.rubikRegular.fontFamily,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomeScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final offset = Tween(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastEaseInToSlowEaseOut,
                          ));

                          return SlideTransition(
                            position: offset,
                            child: child,
                          );
                        },
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.blue3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      "Play Now",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(
                            color: CustomColors.blue1, width: 1.5),
                      ),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      "About",
                      style: TextStyle(
                        color: CustomColors.blue1,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
