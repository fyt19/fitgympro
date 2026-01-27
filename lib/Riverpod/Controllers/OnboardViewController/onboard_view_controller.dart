import 'package:fitgympro/Models/onboard_content_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OnboardViewModel {
  final int currentIndex;
  OnboardViewModel({this.currentIndex = 0});

  OnboardViewModel copyWith({int? currentIndex}) =>
      OnboardViewModel(currentIndex: currentIndex ?? this.currentIndex);
}

class OnboardViewController extends StateNotifier<OnboardViewModel> {
  OnboardViewController(Ref ref) : super(OnboardViewModel());

  final List<OnboardStep> steps = [
    OnboardStep(
      title: "Gender",
      image: "assets/images/onboarding_0.jpg",
      options: ["Male", "Female", "I don't want to mention it"],
    ),
    OnboardStep(
      title: "What is your body type?",
      image: "assets/images/onboarding_1.jpg",
      options: ["Ectomorph", "Mesomorph", "Endomorph"],
    ),
    OnboardStep(
      title: "What are your goals?",
      image: "assets/images/onboarding_2.jpg",
      options: [
        "Losing weight",
        "Build muscle",
        "Tone up",
        "Get in shape",
        "Increase endurance",
        "Stay healthy",
        "Other",
      ],
      isDoubleColumn: true,
    ),
    OnboardStep(
      title: "How many days a week can you train?",
      image: "assets/images/onboarding_3.jpg",
      options: ["2 days", "3 days", "4 days", "5 days", "Every Day"],
      isDoubleColumn: true,
    ),
    OnboardStep(
      title: "What equipment do you have?",
      image: "assets/images/onboarding_4.jpg",
      options: [
        "None",
        "Dumbbell",
        "Resistance band",
        "Mat",
        "Barbell/kettlebell",
        "All equipment for home workouts",
      ],
      isDoubleColumn: true,
    ),
  ];

  void next() => state = state.copyWith(currentIndex: state.currentIndex + 1);
  void back() => state = state.copyWith(currentIndex: state.currentIndex - 1);
}
