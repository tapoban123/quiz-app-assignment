import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/question_model.dart';
import 'package:quiz_app/models/user_selection_model.dart';
import 'package:quiz_app/pages/results_page.dart';
import 'package:quiz_app/pages/splash_screen.dart';
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noneAnswered =
        Provider.of<QuizProvider>(context).userAnswers.isNotEmpty &&
            Provider.of<QuizProvider>(context).userAnswers.any(
                  (element) => element.chosenOption != null,
                );
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Question ${Provider.of<QuizProvider>(context).currentQsNumber}"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              if (noneAnswered) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title:
                        const Text("Are you sure you want to exit the exam?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Provider.of<QuizProvider>(context, listen: false)
                              .resetProvider();

                          Navigator.of(context)
                              .pushReplacement(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const SplashScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              final position = Tween(
                                begin: const Offset(-1, 0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.fastLinearToSlowEaseIn,
                              ));

                              return SlideTransition(
                                position: position,
                                child: child,
                              );
                            },
                          ));
                        },
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: CustomFontFamily.rubikBold.fontFamily,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: CustomFontFamily.rubikBold.fontFamily,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                Provider.of<QuizProvider>(context, listen: false)
                    .resetProvider();
                Navigator.of(context).pushReplacement(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SplashScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    final position = Tween(
                      begin: const Offset(-1, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: animation,
                      curve: Curves.fastLinearToSlowEaseIn,
                    ));

                    return SlideTransition(
                      position: position,
                      child: child,
                    );
                  },
                ));
              }
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
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 5),
          child: SizedBox(
            height: 30,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Provider.of<QuizProvider>(context, listen: false)
                  .questions
                  .length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<QuizProvider>(
                      context,
                      listen: false,
                    ).setQsNumber(index + 1);

                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor:
                        Provider.of<QuizProvider>(context).userAnswers.any(
                                  (element) =>
                                      element.questionNumber == index + 1 &&
                                      element.chosenOption != null,
                                )
                            ? Colors.green
                            : Colors.grey,
                    child: Text((index + 1).toString()),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Consumer<QuizProvider>(
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
        ),
      ]),
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

    if (Provider.of<QuizProvider>(context, listen: false).userAnswers.any(
          (element) => element.question == widget.questionData.description,
        )) {
      selectedOption.value = Provider.of<QuizProvider>(context, listen: false)
          .userAnswers
          .firstWhere(
            (element) => element.question == widget.questionData.description,
          );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.questionData.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 18,
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
            height: 14,
          ),
          SizedBox(
            height: 230,
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
                          radius: 18,
                          child: Text(
                            "0${index + 1}",
                            style: const TextStyle(fontSize: 14),
                          ),
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
                            fontSize: 14,
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
                  selectedOption.value = selectedOption.value ??
                      UserSelectionModel(
                        questionNumber: widget.questionData.questionNumber!,
                        questionThumbnail: "",
                        question: widget.questionData.description,
                        chosenOption: null,
                        isCorrect: false,
                      );

                  if (currentQuestionNumber == maxQuestions) {
                    if (Provider.of<QuizProvider>(context, listen: false)
                        .hasUnansweredQuestion()) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Please answer all the questions."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Sure"),
                            ),
                          ],
                        ),
                      );
                    } else {
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
                    }
                  } else {
                    widget.pageController.animateToPage(
                      widget.currentPageNumber + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                    );
                  }

                  Provider.of<QuizProvider>(
                    context,
                    listen: false,
                  ).acceptUserChoice(selectedOption.value!);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
