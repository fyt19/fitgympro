import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../theme/my_colors.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Doküman: Premium kullanıcılar için tasarlanan homepage açılmalı [cite: 87]
    return Scaffold(
      backgroundColor: const Color(
        0xFFF2F5FC,
      ), // Dokümandaki scaffold rengi [cite: 322]
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBox(),
              const SizedBox(height: 25),
              _buildSectionTitle("Popular Workouts"),
              _buildPopularWorkouts(), // Yatay slider
              const SizedBox(height: 25),
              _buildSectionTitle("Quick Training"),
              _buildTrainingCard(
                "Dumbbell Lateral Raise",
                "200kcal",
                "20 min.",
              ),
              const SizedBox(height: 25),
              _buildAiBodyScanCard(), // Madde 8: Vücut analizi özelliği [cite: 169]
              const SizedBox(height: 25),
              _buildWeeklyProgress(), // Dinamik grafik yapısı [cite: 138]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good Morning",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              "Jhon Doe",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
        Row(
          children: [
            // Get Pro Butonu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: MyColors.primaryRed,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.stars, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Get Pro",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.notifications_none_outlined,
              color: MyColors.darkBg,
            ),
          ],
        ),
      ],
    );
  }
}

// Arama kutusu tasarımı
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

// Bölüm başlıkları
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

// Popüler Antrenmanlar Slider'ı
Widget _buildPopularWorkouts() {
  return SizedBox(
    height: 180,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        width: 280,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: const DecorationImage(
            image: AssetImage("assets/images/workout_placeholder.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

// Hızlı Antrenman Kartı
Widget _buildTrainingCard(String title, String kcal, String time) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Row(
      children: [
        Container(width: 50, height: 50, color: Colors.grey[200]),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              "$kcal - $time",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ],
    ),
  );
}

// Madde 8: Vücut Analizi Kartı [cite: 169]
Widget _buildAiBodyScanCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Column(
      children: [
        Icon(Icons.camera_alt, color: MyColors.primaryRed, size: 40),
        SizedBox(height: 10),
        Text("AI Body Scan", style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          "Scan your body in the best way possible",
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Madde 6: Haftalık İlerleme Grafiği [cite: 138]
Widget _buildWeeklyProgress() {
  return Container(
    height: 150,
    width: double.infinity,
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      color: MyColors.darkBg,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const Center(
      child: Text(
        "Weekly Progress Chart",
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}
