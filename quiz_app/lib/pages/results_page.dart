import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/pages/home_screen.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/theme/custom_colors.dart';
import 'package:quiz_app/utils/utils.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scoreValue;

  @override
  void initState() {
    Provider.of<QuizProvider>(
      context,
      listen: false,
    ).calculateTotalScore();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    scoreValue = Tween<double>(
      begin: 0.0,
      end: Provider.of<QuizProvider>(
        context,
        listen: false,
      ).totalScore.toDouble(),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));

    super.initState();

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<QuizProvider>(
      context,
      listen: false,
    ).calculateTotalScore();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Total correct answers:",
              style: TextStyle(
                fontSize: 16,
                fontFamily: CustomFontFamily.rubikRegular.fontFamily,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${Provider.of<QuizProvider>(context).totalScore ~/ 10} out of ${Provider.of<QuizProvider>(context).questions.length} Questions.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: CustomFontFamily.rubikRegular.fontFamily,
                color: CustomColors.green,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xff785df8),
                        Color(0xff44348c),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Your final score is:",
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: CustomFontFamily.rubikBold.fontFamily,
                        ),
                      ),
                      AnimatedBuilder(
                        animation: scoreValue,
                        builder: (context, child) => Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 30,
                              color: Colors.red,
                              backgroundColor: Colors.grey.shade400,
                              value: scoreValue.value / 100,
                              strokeCap: StrokeCap.round,
                              strokeAlign: 6,
                            ),
                            Container(
                              width: 150,
                              height: 150,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amber,
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xfffbc82b),
                                      Color(0xfffab12c),
                                    ],
                                  )),
                              alignment: Alignment.center,
                              child: Text(
                                "${scoreValue.value.toInt()}",
                                style: TextStyle(
                                  fontSize: 52,
                                  fontFamily:
                                      CustomFontFamily.rubikMedium.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: ElevatedButton(
                  onPressed: () {
                    Provider.of<QuizProvider>(context, listen: false)
                        .resetProvider();
                    Navigator.of(context).pushAndRemoveUntil(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const HomeScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final position =
                              Tween(begin: const Offset(0, 1), end: Offset.zero)
                                  .animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.linearToEaseOut,
                          ));

                          return SlideTransition(
                            position: position,
                            child: child,
                          );
                        },
                      ),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.blue1,
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.repeat,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Try Again",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: CustomFontFamily.rubikMedium.fontFamily,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
