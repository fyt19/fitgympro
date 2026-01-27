import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class MyBottomNavbarView extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const MyBottomNavbarView({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      height: 70,
      decoration: BoxDecoration(
        color: MyColors.darkBg,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(Icons.home, "Home", selectedIndex == 0, 0),
          _navItem(Icons.rocket_launch, "Workout", selectedIndex == 1, 1),
          _navItem(Icons.calendar_month, "Plans", selectedIndex == 2, 2),
          _navItem(Icons.person, "Profile", selectedIndex == 3, 3),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, bool isSelected, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: MyColors.primaryRed,
                borderRadius: BorderRadius.circular(25),
              )
            : null,
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
