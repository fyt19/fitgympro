import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeState {
  final bool isPremium;
  final String userName;
  final bool hasNotification;

  HomeState({
    this.isPremium = false,
    this.userName = "Jhon Doe",
    this.hasNotification = true,
  });

  HomeState copyWith({
    bool? isPremium,
    String? userName,
    bool? hasNotification,
  }) {
    return HomeState(
      isPremium: isPremium ?? this.isPremium,
      userName: userName ?? this.userName,
      hasNotification: hasNotification ?? this.hasNotification,
    );
  }
}

class HomeViewController extends StateNotifier<HomeState> {
  HomeViewController() : super(HomeState());

  // Doküman Madde 4: 1 günlük premium verme ve bildirim mantığı [cite: 85]
  void checkInitialPremiumStatus() {
    // Logic: Uygulama ilk kez yüklendiyse state'i güncelle ve bildirim tetikle.
  }
}
