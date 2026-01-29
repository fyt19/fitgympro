import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';
import 'workout_detail_view.dart';

class WorkoutCategoryView extends StatelessWidget {
  final String categoryName;
  const WorkoutCategoryView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      body: SingleChildScrollView(
        // SafeArea kullanmıyoruz çünkü resmin en tepeye kadar çıkması lazım
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ÜST KISIM (Resim + Gradient + Back Button)
            _buildHeader(context),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Başlık
                  Text(
                    categoryName, // "Strength"
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBg,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Liste Elemanları (Tasarımdaki Kartlar)
                  _buildPlanItem(
                    context,
                    "Full Body",
                    "10 Exercises",
                    "assets/images/training0.png",
                  ),
                  _buildPlanItem(
                    context,
                    "Arm",
                    "14 Exercises",
                    "assets/images/arm_workout.jpg",
                  ),
                  _buildPlanItem(
                    context,
                    "Chest",
                    "8 Exercises",
                    "assets/images/chest_workout.jpg",
                  ),
                  _buildPlanItem(
                    context,
                    "Shoulders - Back",
                    "14 Exercises",
                    "assets/images/back_workout.jpg",
                  ),
                  _buildPlanItem(
                    context,
                    "Legs",
                    "14 Exercises",
                    "assets/images/leg.jpg",
                  ),
                  _buildPlanItem(
                    context,
                    "Abs",
                    "8 Exercises",
                    "assets/images/abs.jpg",
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        // 1. Arka Plan Resmi
        Container(
          height: 320, // Resim yüksekliği
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/training0.png",
              ), // Kategoriye özel resim
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
        ),

        // 2. Alt Kısım Gradient Fade (Resmin altına yumuşak geçiş)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 150, // Geçişin uzunluğu
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xffF2F5FC).withOpacity(0.0), // Tam şeffaf
                  const Color(0xffF2F5FC), // Arka plan rengi (Tam örtücü)
                ],
              ),
            ),
          ),
        ),

        // 3. Back Button (Sol Üst)
        Positioned(
          top: 60, // Safe Area payı
          left: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Tasarımdaki Kart Yapısı
  Widget _buildPlanItem(
    BuildContext context,
    String title,
    String subtitle,
    String img,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutDetailView(planName: title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Sol Resim
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                img,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                // Resim yoksa gri kutu göster (Hata almamak için)
                errorBuilder: (c, o, s) =>
                    Container(width: 70, height: 70, color: Colors.grey[200]),
              ),
            ),
            const SizedBox(width: 15),

            // Orta Metin Alanı
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: MyColors.darkBg,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Kırmızı Kapsül Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: MyColors.primaryRed,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Sağ Ok İkonu (Yuvarlak arka planlı)
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: MyColors.primaryRed.withOpacity(0.1), // Açık kırmızı
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: MyColors.primaryRed,
                size: 16,
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
