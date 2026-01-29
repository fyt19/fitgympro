import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';
import 'create_plan_view.dart'; // Birazdan oluşturacağız

class PlansView extends StatelessWidget {
  const PlansView({super.key});

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
                "Weekly Plan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: MyColors.darkBg,
                ),
              ),
              const SizedBox(height: 20),

              // KIRMIZI OLUŞTURMA BUTONU
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreatePlanView(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.primaryRed,
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  shadowColor: MyColors.primaryRed.withOpacity(0.4),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Create Weekly Plan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // KAYITLI PLANLAR BAŞLIĞI
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Saved Plans",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBg,
                    ),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: MyColors.primaryRed,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // YATAY KAYITLI PLAN LİSTESİ
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSavedPlanCard(
                      "1-6\nNov",
                      "My Weekly\nWorkout Plan",
                      "Deadlift, Pull Up, Squat,\nBench Press...",
                    ),
                    _buildSavedPlanCard(
                      "7-13\nNov",
                      "Bodyweight\nExercises",
                      "Push-Up, Pull Up,\nTriceps Dips...",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // İLERLEME ÖZETİ (SİYAH KART)
              const Text(
                "Progress Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.darkBg,
                ),
              ),
              const SizedBox(height: 15),
              _buildProgressSummaryCard(),

              const SizedBox(height: 30),

              // BUGÜNÜN PROGRAMI
              const Text(
                "Today's Schedule",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.darkBg,
                ),
              ),
              const SizedBox(height: 15),
              _buildTodayScheduleCard(),

              const SizedBox(height: 100), // Navbar payı
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSavedPlanCard(String date, String title, String subtitle) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: MyColors.primaryRed,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  date,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.more_horiz, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: MyColors.darkBg,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColors.darkBg,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: 20,
                    child: Text("T", style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Barbell Lateral Raise",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.fitness_center, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 20),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 12,
              backgroundColor: Colors.grey.shade800,
              color: MyColors.primaryRed,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            "65%",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgressStat("Start", "0\nkcal"),
              _buildProgressStat("Current", "1200\nkcal"),
              _buildProgressStat("Target", "2000\nkcal"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTodayScheduleCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "02:30 PM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: MyColors.darkBg,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shoulders Back",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: MyColors.primaryRed,
                    ),
                  ),
                  Text(
                    "Deadlift, Pull Up, Squat...",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.more_horiz, color: Colors.grey),
        ],
      ),
    );
  }
}
