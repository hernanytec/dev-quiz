import 'package:dev_quiz/challenge/challenge_controller.dart';
import 'package:dev_quiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:dev_quiz/challenge/widgets/question_indicator_widget.dart';
import 'package:dev_quiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/result/result_page.dart';
import 'package:dev_quiz/shared/models/question_model.dart';
import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    super.initState();
  }

  void previousPage() {
    if (pageController.page == 0) return;

    pageController.previousPage(
      duration: Duration(milliseconds: 150),
      curve: Curves.linear,
    );
  }

  void nextPage() {
    if (pageController.page == widget.questions.length - 1) return;

    pageController.nextPage(
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  void onSelect(bool value) async {
    if (value) controller.countRight++;

    await Future.delayed(Duration(seconds: 1));
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(102),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: controller.currentPage,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map(
              (question) => QuizWidget(
                question: question,
                onSelect: onSelect,
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: NextButtonWidget.secondary(
                  label: "Voltar",
                  onTap: previousPage,
                ),
              ),
              SizedBox(
                width: 7,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: controller.currentPageNotifier,
                  builder: (context, value, _) =>
                      value == widget.questions.length
                          ? NextButtonWidget.primary(
                              label: "Confirmar",
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultPage(
                                            title: widget.title,
                                            length: widget.questions.length,
                                            result: controller.countRight,
                                          )),
                                );
                              },
                            )
                          : NextButtonWidget.secondary(
                              label: "Pular",
                              onTap: nextPage,
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
