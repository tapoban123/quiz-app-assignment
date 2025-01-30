import 'package:flutter/material.dart';
import 'package:quiz_app/theme/custom_colors.dart';
import 'package:quiz_app/utils/app_images.dart';
import 'package:quiz_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> options = [
    "DNA was transforming agent",
    "RNA was transforming agent",
    "Protein was transforming agent",
    "All are correct",
  ];
  ValueNotifier<String> selectedOption = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Question 1"),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const Text("01/10"),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Avery, MacLeod and Mc Carty used the S(virulent) and R (avirulent) strains of streptococcus pneumoniae. They isolated and purified protein, DNA, RNA from the bacteria and treated them with related enzymes. They concluded that :",
              style: TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 26,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: SizedBox(
                width: screenWidth(context) * 0.8,
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
                itemCount: options.length,
                itemBuilder: (context, index) {
                  return ValueListenableBuilder(
                    valueListenable: selectedOption,
                    builder: (context, selectedOptionValue, child) => ListTile(
                      onTap: () {
                        selectedOption.value = options[index];
                      },
                      leading: CircleAvatar(
                        child: Text("0${index + 1}"),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      tileColor: options[index] == selectedOptionValue
                          ? CustomColors.green
                          : Colors.transparent,
                      title: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 16,
                          color: options[index] == selectedOptionValue
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
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
                  onTap: () {},
                ),
                PreviousAndNextButton(
                  buttonText: "Next",
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
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
