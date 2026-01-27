import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/my_colors.dart';
import '../../Riverpod/Controllers/all_controllers.dart';
import '../BottomNavBarView/bottom_navbar_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // [cite: 192] Controllers altından veriyi çekiyoruz
    final homeState = ref.watch(AllControllers.homeViewController);

    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC), // [cite: 322]
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
              _buildPopularWorkouts(),
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
              _buildAiBodyScanCard(), // [cite: 169]
              const SizedBox(height: 25),
              _buildSectionTitle("Lose Weight"),
              _buildLoseWeightList(), // Yatay kaydırmalı
              const SizedBox(height: 25),
              _buildWeeklyProgressCard(homeState), // [cite: 138]
              const SizedBox(height: 25),
              _buildStrengthCountdownCard(), // Tasarımdaki geri sayım alanı
              const SizedBox(height: 25),
              _buildPremiumBanner(), // En alttaki upgrade kartı
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavbarView(
        selectedIndex: 0,
        onTap: (index) {
          // Sayfa değiştirme logic'i buraya gelecek
        },
      ),
    );
  }

  // HEADER [cite: 84, 87]
  Widget _buildHeader(homeState) {
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
              homeState.userName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Row(
          children: [
            _badge(
              homeState.isPremium ? "PREMIUM" : "Get Pro",
              homeState.isPremium
                  ? const Color(0xFFFFD700)
                  : MyColors.primaryRed,
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.notifications_none_outlined,
              size: 28,
              color: MyColors.darkBg,
            ),
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
          icon: Icon(Icons.search, color: Colors.grey),
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
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: MyColors.darkBg,
          ),
        ),
        const Text(
          "See All",
          style: TextStyle(
            color: MyColors.primaryRed,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // LOSE WEIGHT LIST
  Widget _buildLoseWeightList() {
    final List<Map<String, String>> items = [
      {"title": "Jumping\nRope", "img": "assets/images/jumping_rose.jpg"},
      {"title": "Running", "img": "assets/images/running.png"},
      {"title": "Stair\nClimber", "img": "assets/images/stair.png"},
    ];
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) => Container(
          width: 160,
          margin: const EdgeInsets.only(right: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
              image: AssetImage(items[index]['img']!),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black26,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[index]['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_circle_right,
                      color: MyColors.primaryRed,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // WEEKLY PROGRESS [cite: 138]
  Widget _buildWeeklyProgressCard(homeState) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColors.darkBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Text(
                      "Today • 25 Nov",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _ProgressRow(
                  Icons.nightlight_round,
                  "7h 13m",
                  "Sleep Time",
                  Colors.blue,
                ),
                _ProgressRow(
                  Icons.favorite,
                  "56 bpm",
                  "Avg. heart rate",
                  Colors.red,
                ),
                _ProgressRow(
                  Icons.rocket_launch,
                  "1h 20min",
                  "Exercise",
                  Colors.green,
                ),
              ],
            ),
          ),
          _buildCircularCharts(homeState),
        ],
      ),
    );
  }

  Widget _buildCircularCharts(homeState) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(
            value: homeState.sleepProgress,
            color: Colors.green,
            strokeWidth: 8,
            backgroundColor: Colors.white10,
          ),
        ),
        SizedBox(
          width: 75,
          height: 75,
          child: CircularProgressIndicator(
            value: 0.52,
            color: Colors.red,
            strokeWidth: 8,
            backgroundColor: Colors.white10,
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(
            value: 0.27,
            color: Colors.blue,
            strokeWidth: 8,
            backgroundColor: Colors.white10,
          ),
        ),
        const Column(
          children: [
            Icon(
              Icons.local_fire_department,
              color: MyColors.primaryRed,
              size: 20,
            ),
            Text(
              "2250 kcal",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // TRAINING CARDS
  Widget _buildTrainingCard(
    String title,
    String kcal,
    String time,
    String img,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(img, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department,
                      size: 12,
                      color: MyColors.primaryRed,
                    ),
                    Text(
                      " $kcal",
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.access_time, size: 12, color: Colors.grey),
                    Text(
                      " $time",
                      style: const TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: MyColors.primaryRed,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Start Training",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // AI SCAN CARD [cite: 169]
  Widget _buildAiBodyScanCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Image.asset("assets/images/bodyscan.jpg", width: 90),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Ai Body Scan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                const Text(
                  "Scan your body in the best way possible with AI",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.primaryRed.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Start Scan",
                      style: TextStyle(
                        color: MyColors.primaryRed,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // STRENGTH COUNTDOWN CARD
  Widget _buildStrengthCountdownCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
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
                    backgroundImage: AssetImage("assets/images/training0.png"),
                    radius: 25,
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Strength",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Full Body",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "Jan 23,\n2026",
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: MyColors.primaryRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CountdownItem("8", "Days"),
              _CountdownItem("21", "Hours"),
              _CountdownItem("24", "Minutes"),
              _CountdownItem("19", "Seconds"),
            ],
          ),
        ],
      ),
    );
  }

  // POPULAR WORKOUTS
  Widget _buildPopularWorkouts() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _popularItem(
            "Strength",
            "60 Exercises",
            "assets/images/training0.png",
          ),
          _popularItem("Cardio", "15 Exercises", "assets/images/training1.jpg"),
        ],
      ),
    );
  }

  Widget _popularItem(String t, String s, String i) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: DecorationImage(image: AssetImage(i), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black45,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(s, style: const TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [MyColors.darkBg, Color(0xFF4B0000)],
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Unlimited Access",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "Purchase to enjoy premium benefits",
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: MyColors.darkBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              "Upgrade Plan",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// YARDIMCI WIDGET'LAR
class _ProgressRow extends StatelessWidget {
  final IconData icon;
  final String val;
  final String label;
  final Color col;
  const _ProgressRow(this.icon, this.val, this.label, this.col);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: col, size: 18),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                val,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white54, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownItem extends StatelessWidget {
  final String val;
  final String label;
  const _CountdownItem(this.val, this.label);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          val,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: MyColors.primaryRed,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
