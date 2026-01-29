import 'package:fitgympro/View/ProfileView/profile_view.dart';
import 'package:flutter/material.dart';
import '../BottomNavBarView/bottom_navbar_view.dart';
import '../HomeView/home_view.dart';
import '../WorkoutView/workout_view.dart';
import '../PlansView/plans_view.dart';
// Plans ve Profile sayfalarını oluşturunca buraya import edeceksin.

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // Sayfaların Listesi
  final List<Widget> _pages = [
    const HomeView(), // 0: Home
    const WorkoutView(), // 1: Workout
    const PlansView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      // IndexedStack, sayfaların durumunu (scroll pozisyonu vb.) korur.
      body: IndexedStack(index: _currentIndex, children: _pages),
      // Senin verdiğin MyBottomNavbarView bileşeni burada kullanılıyor
      bottomNavigationBar: MyBottomNavbarView(
        selectedIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
