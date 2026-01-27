import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeState {
  final bool isPremium;
  final String userName;

  HomeState({this.isPremium = false, this.userName = "Jhon Doe"});

  HomeState copyWith({bool? isPremium, String? userName}) {
    return HomeState(
      isPremium: isPremium ?? this.isPremium,
      userName: userName ?? this.userName,
    );
  }
}

class HomeViewController extends StateNotifier<HomeState> {
  HomeViewController() : super(HomeState());

  void togglePremium() => state = state.copyWith(isPremium: !state.isPremium);
}
