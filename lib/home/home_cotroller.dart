import 'package:DevQuiz/core/app_images.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/shared/models/answer_model.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:DevQuiz/shared/models/quiz_model.dart';
import 'package:DevQuiz/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizzes;

  void getuser() async {
    state = HomeState.loading;
    await Future.delayed(Duration(seconds: 1));

    user = UserModel(
      name: "Hernany",
      photoUrl: "https://avatars.githubusercontent.com/u/31345577?v=4",
    );
    state = HomeState.success;
  }

  void getQuizzes() async {
    state = HomeState.loading;
    await Future.delayed(Duration(seconds: 1));

    quizzes = [
      QuizModel(
        title: "NLW 5 flutter",
        questions: [
          QuestionModel(title: "Está curtindo o flutter?", answers: [
            AnswerModel(title: "Sim! Muito Show!", isRight: true),
            AnswerModel(title: "Não"),
            AnswerModel(title: "Mais ou menos"),
            AnswerModel(title: "Nadinha")
          ])
        ],
        imagem: AppImages.blocks,
        level: Level.facil,
      )
    ];
    state = HomeState.success;
  }
}
