import 'package:fitgympro/Riverpod/Controllers/HomeViewController/home_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/my_colors.dart';
import '../../Riverpod/Controllers/all_controllers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(AllControllers.homeViewController);

    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(homeState),
              const SizedBox(height: 20),
              _buildSearchBox(),
              const SizedBox(height: 25),
              _buildSectionTitle("Popular Workouts"),
              _buildPopularWorkouts(), // Yatay kaydırmalı slider
              const SizedBox(height: 25),
              _buildSectionTitle("Quick Training"),
              _buildTrainingCard(
                "Dumbbell Lateral Raise",
                "200kcal",
                "20 min.",
                "assets/images/dumbell_lateral.png",
              ),
              _buildTrainingCard(
                "Bench Press",
                "200kcal",
                "20 min.",
                "assets/images/bench_press.jpg",
              ),
              const SizedBox(height: 25),
              _buildAiBodyScanCard(), // Madde 8 [cite: 169]
              const SizedBox(height: 25),
              _buildSectionTitle("Lose Weight"),
              _buildLoseWeightList(),
              const SizedBox(height: 25),
              _buildWeeklyProgress(), // Madde 6 [cite: 138]
              const SizedBox(height: 25),
              if (!homeState.isPremium) _buildPremiumBanner(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(HomeState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Good Morning",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            Text(
              state.userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Row(
          children: [
            _badge(
              state.isPremium ? "PREMIUM" : "Get Pro",
              state.isPremium ? Colors.orange : MyColors.primaryRed,
            ),
            const SizedBox(width: 10),
            const Icon(Icons.notifications_none_outlined, size: 28),
          ],
        ),
      ],
    );
  }

  Widget _badge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          icon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Text(
          "See All",
          style: TextStyle(color: MyColors.primaryRed, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildPopularWorkouts() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _workoutCard(
            "Strength",
            "60 Exercises",
            "assets/images/training0.png",
          ),
          _workoutCard("Cardio", "10 Exercises", "assets/images/training1.jpg"),
        ],
      ),
    );
  }

  Widget _workoutCard(String title, String sub, String img) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black54,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              sub,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrainingCard(
    String title,
    String kcal,
    String time,
    String img,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(img, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "$kcal | $time",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryRed,
              padding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            child: const Text(
              "Start",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiBodyScanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset("assets/images/bodyscan.jpg", width: 100),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AI Body Scan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  "Scan your body in the best way possible.",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoseWeightList() {
    return const SizedBox(); /* Benzer yatay liste mantığı */
  }

  Widget _buildWeeklyProgress() {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: MyColors.darkBg,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(height: 100, color: Colors.redAccent);
  }
}
