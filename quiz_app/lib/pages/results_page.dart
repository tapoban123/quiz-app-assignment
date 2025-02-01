import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/providers/quiz_provider.dart';

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
      duration: const Duration(milliseconds: 300),
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
  Widget build(BuildContext context) {
    Provider.of<QuizProvider>(
      context,
      listen: false,
    ).calculateTotalScore();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Results"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text("${Provider.of<QuizProvider>(context).totalScore}"),
            // SizedBox(
            //   height: 20,
            // ),
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
                    ),
                    alignment: Alignment.center,
                    child: Text("${scoreValue.value.toInt()}"),
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
