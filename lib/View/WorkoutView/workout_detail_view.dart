import 'package:fitgympro/View/ScheduleView/schedule_workout_view.dart';
import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';
// import 'schedule_workout_view.dart'; // Takvim Sayfası
import 'workout_player_view.dart'; // Oynatıcı Sayfası

class WorkoutDetailView extends StatelessWidget {
  final String planName;
  const WorkoutDetailView({super.key, required this.planName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      body: CustomScrollView(
        slivers: [
          // ÜST RESİM VE APPBAR
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: MyColors.darkBg,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                planName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset("assets/images/training0.png", fit: BoxFit.cover),
                  // Resmin üzerine hafif karartma (yazı okunsun diye)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // İÇERİK KISMI
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // İstatistik Rozetleri
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatBadge(Icons.access_time, "45 Min"),
                      _StatBadge(Icons.local_fire_department, "350 kcal"),
                      _StatBadge(Icons.fitness_center, "10 Exercises"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Exercises",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBg,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // EGZERSİZ LİSTESİ (Tıklanabilir)
                  _buildExerciseItem(
                    context,
                    "Deadlift",
                    "3 Sets x 10 Reps",
                    "assets/images/deadlift_thumb.jpg",
                    true,
                  ),
                  _buildExerciseItem(
                    context,
                    "Squat",
                    "3 Sets x 10 Reps",
                    "assets/images/squat_thumb.png",
                    false,
                  ),
                  _buildExerciseItem(
                    context,
                    "Push-Up",
                    "3 Sets x 8 Reps",
                    "assets/images/pushup_thumb.png",
                    false,
                  ),

                  const SizedBox(height: 30),

                  // ALT BUTONLAR (Start & Takvim)
                  Row(
                    children: [
                      // Start Workout Butonu
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WorkoutPlayerView(
                                exerciseName: "Full Body Workout",
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryRed,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 5,
                            shadowColor: MyColors.primaryRed.withOpacity(0.4),
                          ),
                          child: const Text(
                            "Start Workout",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // Takvim Butonu
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScheduleWorkoutView(),
                            ),
                          );
                        },
                        child: Container(
                          height: 55, // Butonla aynı yükseklik
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.grey.shade200),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.calendar_today_outlined,
                            color: MyColors.darkBg,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30), // Alt boşluk
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Egzersiz Kartı (Tıklama Özelliği Eklendi)
  Widget _buildExerciseItem(
    BuildContext context,
    String title,
    String sets,
    String img,
    bool isActive,
  ) {
    return GestureDetector(
      onTap: () {
        // Kartın kendisine tıklanınca da Player açılır
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutPlayerView(exerciseName: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Görsel
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                img,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) =>
                    Container(width: 70, height: 70, color: Colors.grey[200]),
              ),
            ),
            const SizedBox(width: 15),
            // Metinler
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: MyColors.darkBg,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sets,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            // İkon (Play veya Lock)
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? MyColors.primaryRed : Colors.grey.shade300,
                ),
              ),
              child: Icon(
                isActive ? Icons.play_arrow : Icons.lock_outline,
                color: isActive ? MyColors.primaryRed : Colors.grey.shade300,
                size: 20,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}

// İstatistik Rozeti
class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  const _StatBadge(this.icon, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: MyColors.primaryRed),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: MyColors.darkBg,
            ),
          ),
        ],
      ),
    );
  }
}
