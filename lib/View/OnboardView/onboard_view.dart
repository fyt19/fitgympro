import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Riverpod/Controllers/all_controllers.dart';
import '../../theme/my_colors.dart';
import '../../Core/Routes/app_routes.dart';

class OnboardView extends ConsumerStatefulWidget {
  const OnboardView({super.key});

  @override
  ConsumerState<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends ConsumerState<OnboardView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final onboardState = ref.watch(AllControllers.onboardViewController);
    final notifier = ref.read(AllControllers.onboardViewController.notifier);
    final int safeIndex = onboardState.currentIndex >= notifier.steps.length
        ? notifier.steps.length - 1
        : onboardState.currentIndex;
    final currentStep = notifier.steps[safeIndex];

    return Scaffold(
      backgroundColor: MyColors.darkBg,
      body: Stack(
        children: [
          // Arka Plan Resmi
          Image.asset(
            currentStep.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(color: Colors.black.withOpacity(0.5)), // Karartma

          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentStep.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Seçenekler (Grid veya Liste)
                currentStep.isDoubleColumn
                    ? _buildGridOptions(currentStep.options, notifier)
                    : _buildListOptions(currentStep.options, notifier),

                const SizedBox(height: 30),

                // Navigasyon Butonları
                Row(
                  children: [
                    if (onboardState.currentIndex > 0)
                      Expanded(
                        child: _navButton(
                          "Back",
                          Colors.white,
                          Colors.black,
                          () => notifier.back(),
                        ),
                      ),
                    if (onboardState.currentIndex > 0)
                      const SizedBox(width: 15),
                    Expanded(
                      child: _navButton(
                        "Next",
                        MyColors.primaryRed,
                        Colors.white,
                        () {
                          if (onboardState.currentIndex <
                              notifier.steps.length - 1) {
                            notifier.next();
                          } else {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.home,
                            ); // Ekipmanlardan sonra Home
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListOptions(List<String> options, dynamic notifier) {
    return Column(
      children: options.map((opt) => _optionButton(opt, notifier)).toList(),
    );
  }

  Widget _buildGridOptions(List<String> options, dynamic notifier) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: options
          .map(
            (opt) => SizedBox(
              width: (MediaQuery.of(context).size.width - 50) / 2,
              child: _optionButton(opt, notifier),
            ),
          )
          .toList(),
    );
  }

  Widget _optionButton(String text, dynamic notifier) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.white30),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () => notifier.next(), // Şimdilik her tıklama ilerletir
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _navButton(String text, Color bg, Color textCol, VoidCallback tap) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      onPressed: tap,
      child: Text(
        text,
        style: TextStyle(color: textCol, fontWeight: FontWeight.bold),
      ),
    );
  }
}
