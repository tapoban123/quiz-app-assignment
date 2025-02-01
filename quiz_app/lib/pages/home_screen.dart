import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/user_selection_model.dart';
import 'package:quiz_app/pages/results_page.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/theme/custom_colors.dart';
import 'package:quiz_app/utils/app_images.dart';
import 'package:quiz_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;

  @override
  void initState() {
    Provider.of<QuizProvider>(
      context,
      listen: false,
    ).fetchQuestions();

    _pageController = PageController(initialPage: 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Question ${Provider.of<QuizProvider>(context).currentQsNumber}"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.08),
            ),
            icon: const Icon(
              Icons.stop,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          final questions = quizProvider.questions;
          if (questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            allowImplicitScrolling: false,
            itemCount: questions.length,
            itemBuilder: (context, index) => QuestionContent(
              currentPageNumber: index,
              pageController: _pageController,
              questionData: questions[index],
            ),
          );
        },
      ),
    );
  }
}

class PreviousAndNextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;

  const PreviousAndNextButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomColors.blue3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: CustomFontFamily.rubikMedium.fontFamily,
        ),
      ),
    );
  }
}

class QuestionContent extends StatefulWidget {
  final int currentPageNumber;
  final QuestionModel questionData;
  final PageController pageController;

  const QuestionContent({
    super.key,
    required this.currentPageNumber,
    required this.questionData,
    required this.pageController,
  });

  @override
  State<QuestionContent> createState() => _QuestionContentState();
}

class _QuestionContentState extends State<QuestionContent> {
  final ValueNotifier<UserSelectionModel?> selectedOption = ValueNotifier(null);

  String getCurrentQsNumber() {
    final int currentQuestionNum =
        Provider.of<QuizProvider>(context).currentQsNumber;

    if ((currentQuestionNum - (currentQuestionNum % 10)) == 0) {
      return "0$currentQuestionNum";
    } else {
      return currentQuestionNum.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxQuestions =
        Provider.of<QuizProvider>(context, listen: false).questions.length;
    final currentQuestionNumber =
        Provider.of<QuizProvider>(context).currentQsNumber;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${getCurrentQsNumber()}/$maxQuestions"),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.questionData.description,
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(
            height: 26,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              width: double.infinity,
              height: screenWidth(context) * 0.55,
              child: Image.asset(
                AppImages.geneticsImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 240,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.questionData.options.length,
              itemBuilder: (context, index) {
                final option = widget.questionData.options[index];

                return ValueListenableBuilder(
                  valueListenable: selectedOption,
                  builder: (context, selectedOptionValue, child) =>
                      Consumer<QuizProvider>(
                    builder: (context, quizProvider, child) {
                      return ListTile(
                        onTap: () {
                          final userSelectedOption = UserSelectionModel(
                            questionNumber: widget.questionData.questionNumber!,
                            questionThumbnail: "",
                            question: widget.questionData.description,
                            chosenOption: option.description,
                            isCorrect: option.is_correct,
                          );

                          selectedOption.value = userSelectedOption;
                        },
                        leading: CircleAvatar(
                          child: Text("0${index + 1}"),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        tileColor: option.description ==
                                selectedOptionValue?.chosenOption
                            ? CustomColors.green
                            : Colors.transparent,
                        title: Text(
                          option.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: option.description ==
                                    selectedOptionValue?.chosenOption
                                ? Colors.black
                                : Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PreviousAndNextButton(
                buttonText: "Previous",
                onTap: () {
                  if (currentQuestionNumber > 1) {
                    Provider.of<QuizProvider>(context, listen: false)
                        .previousQuestion();

                    widget.pageController.animateToPage(
                      widget.currentPageNumber - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                    );
                  }
                },
              ),
              PreviousAndNextButton(
                buttonText: "Next",
                onTap: () {
                  // debugPrint(
                  //     "Current Page Number: ${widget.currentPageNumber}");
                  // debugPrint("Current Question Number: $currentQuestionNumber");
                  // debugPrint("Total Questions: $maxQuestions");

                  if (selectedOption.value != null) {
                    if (currentQuestionNumber == maxQuestions) {
                      Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const ResultsPage(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final position =
                              Tween(begin: const Offset(1, 0), end: Offset.zero)
                                  .animate(CurvedAnimation(
                            parent: animation,
                            curve: Curves.fastLinearToSlowEaseIn,
                          ));

                          return SlideTransition(
                            position: position,
                            child: child,
                          );
                        },
                      ));
                    } else {
                      widget.pageController.animateToPage(
                        widget.currentPageNumber + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.fastOutSlowIn,
                      );
                    }

                    Provider.of<QuizProvider>(
                      context,
                      listen: false,
                    ).acceptUserChoice(selectedOption.value!);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
