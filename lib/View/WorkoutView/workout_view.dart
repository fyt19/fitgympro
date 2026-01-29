import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';
import 'workout_category_view.dart'; // Detay sayfası

class WorkoutView extends StatelessWidget {
  const WorkoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Workout",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: MyColors.darkBg,
                ),
              ),
              const SizedBox(height: 20),

              _buildCategoryCard(
                context,
                "Strength",
                "60 Exercises",
                "assets/images/training0.png",
              ),
              _buildCategoryCard(
                context,
                "Cardio",
                "10 Exercises",
                "assets/images/training1.jpg",
              ),
              _buildCategoryCard(
                context,
                "Yoga, Stretching",
                "20 Exercises",
                "assets/images/yoga.jpg",
              ), // Görseli eklemelisin
              _buildCategoryCard(
                context,
                "Pilates",
                "10 Exercises",
                "assets/images/pilates.png",
              ),

              const SizedBox(height: 20),
              // Premium Banner (Alt Kısım)
              _buildAvoidMissingCard(),
              const SizedBox(height: 80), // Navbar boşluğu
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String subtitle,
    String imgPath,
  ) {
    return GestureDetector(
      onTap: () {
        // Kategori detayına git (Strength -> Full Body, Arm vs.)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutCategoryView(categoryName: title),
          ),
        );
      },
      child: Container(
        height: 160,
        margin: const EdgeInsets.only(bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(image: AssetImage(imgPath), fit: BoxFit.cover),
        ),
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.black38, // Görsel üstü karartma
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvoidMissingCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: MyColors.darkBg,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.lightbulb_outline,
            color: MyColors.primaryRed,
            size: 40,
          ),
          const SizedBox(height: 15),
          const Text(
            "How to avoid missing workouts",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "1- Don't Wait for Motivation: Waiting for the 'desire' to act creates the need for discipline.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: MyColors.darkBg,
            ),
            child: const Text("Get Premium"),
          ),
        ],
      ),
    );
  }
}
