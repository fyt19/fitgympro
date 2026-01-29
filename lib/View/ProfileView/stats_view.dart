import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: MyColors.darkBg),
        title: const Text(
          "Stats",
          style: TextStyle(color: MyColors.darkBg, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SOL BLOK: WALK KARTI
                Expanded(
                  child: _buildStatCard(
                    title: "Walk",
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            value: 0.7,
                            color: MyColors.primaryRed,
                            backgroundColor: Colors.grey.shade200,
                            strokeWidth: 8,
                          ),
                        ),
                        const Column(
                          children: [
                            Icon(Icons.directions_walk, color: MyColors.darkBg),
                            Text(
                              "3457",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "steps",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                // SAĞ BLOK: GYM VE CALORIES
                Expanded(
                  child: Column(
                    children: [
                      _buildStatCard(
                        title: "Gym",
                        icon: Icons.timer_outlined,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1200",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "min",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildStatCard(
                        title: "Calories",
                        icon: Icons.local_fire_department_outlined,
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: 0.6,
                                  color: MyColors.primaryRed,
                                  backgroundColor: Colors.grey.shade200,
                                  strokeWidth: 6,
                                ),
                              ),
                              const Column(
                                children: [
                                  Text(
                                    "1200",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "kcal",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            // SLEEP KARTI
            _buildStatCard(
              title: "Sleep",
              icon: Icons.bedtime_outlined,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "6:52",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    "hour",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // HEART RATE (KIRMIZI KART)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MyColors.primaryRed,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Heart",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.favorite_border, color: Colors.white),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Basit EKG Çizgisi (Temsili)
                  Icon(Icons.show_chart, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text(
                    "85 bpm",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // BEFORE / AFTER FOTOĞRAFLAR
            Row(
              children: [
                Expanded(
                  child: _buildPhotoCard("Before", "assets/images/before.png"),
                ), // Bu resmi assets'e ekle
                const SizedBox(width: 10),
                Expanded(
                  child: _buildPhotoCard("After", "assets/images/after.png"),
                ), // Bu resmi assets'e ekle
              ],
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    Widget? child,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (icon != null)
                Icon(icon, size: 18, color: MyColors.primaryRed),
            ],
          ),
          const SizedBox(height: 10),
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _buildPhotoCard(String label, String path) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.asset(
            path,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (c, o, s) =>
                Container(height: 150, color: Colors.grey),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Positioned(
            bottom: 10,
            left: 10,
            child: Icon(Icons.camera_alt, color: MyColors.primaryRed, size: 20),
          ),
        ],
      ),
    );
  }
}
