import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ProfileState {
  final String name;
  final String email;
  final String photoUrl;
  final bool notificationsEnabled;
  final String weight;
  final String height;

  ProfileState({
    this.name = "Jhon Doe",
    this.email = "jhondoe@gmail.com",
    this.photoUrl =
        "assets/images/profile_user.png", // Assets'e bir profil fotosu eklemelisin
    this.notificationsEnabled = true,
    this.weight = "80",
    this.height = "186.5",
  });

  ProfileState copyWith({
    String? name,
    bool? notificationsEnabled,
    String? weight,
    String? height,
  }) {
    return ProfileState(
      name: name ?? this.name,
      email: email,
      photoUrl: photoUrl,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      weight: weight ?? this.weight,
      height: height ?? this.height,
    );
  }
}

class ProfileController extends StateNotifier<ProfileState> {
  ProfileController() : super(ProfileState());

  void toggleNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }

  void updateProfile({String? name, String? weight, String? height}) {
    state = state.copyWith(name: name, weight: weight, height: height);
  }
}
