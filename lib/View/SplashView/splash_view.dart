import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Core/Routes/app_routes.dart';
import '../../Riverpod/Controllers/all_controllers.dart';
import '../../theme/my_colors.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  // Sayfaları kontrol etmek için PageController ekliyoruz
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final splashState = ref.watch(AllControllers.splashViewController);
    final notifier = ref.read(AllControllers.splashViewController.notifier);

    return Scaffold(
      backgroundColor: MyColors.darkBg,
      body: Stack(
        children: [
          // 1. Kaydırılabilir Arka Plan ve İçerik Yapısı
          PageView.builder(
            controller: _pageController,
            itemCount: notifier.contents.length,
            onPageChanged: (index) {
              // Parmağınla kaydırdığında Controller'daki index'i güncelle
              notifier.updateIndex(index);
            },
            itemBuilder: (context, index) {
              final content = notifier.contents[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Arka Plan Resmi
                  Image.asset(content.image, fit: BoxFit.cover),
                  // Karartma Layer'ı
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                  ),
                  // Metin İçerikleri
                  Positioned(
                    bottom: 160, // Buton ve indicator için pay bırakıyoruz
                    left: 30,
                    right: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.nunitoSans(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(text: content.title),
                              TextSpan(
                                text: content.titleColored,
                                style: const TextStyle(
                                  color: MyColors.primaryRed,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          content.description,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // 2. Alt Sabit Alan (Indicator ve Buton)
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Sayfa Göstergesi (Indicator)
                Row(
                  children: List.generate(
                    notifier.contents.length,
                    (index) =>
                        _buildIndicator(index == splashState.currentIndex),
                  ),
                ),

                // Get Started / Next Butonu
                ElevatedButton(
                  onPressed: () {
                    if (splashState.currentIndex <
                        notifier.contents.length - 1) {
                      // Eğer son sayfada değilse bir sonraki sayfaya kaydır
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      // Son sayfadaysa Onboarding'e git
                      Navigator.pushNamed(context, AppRoutes.onboard);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    splashState.currentIndex == notifier.contents.length - 1
                        ? "Get Started"
                        : "Next",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

  Widget _buildIndicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      height: 4,
      width: isActive ? 24 : 12,
      decoration: BoxDecoration(
        color: isActive ? MyColors.primaryRed : Colors.white30,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
