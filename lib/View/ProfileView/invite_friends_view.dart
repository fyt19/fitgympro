import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class InviteFriendsView extends StatelessWidget {
  const InviteFriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(
        0.5,
      ), // Yarı saydam arka plan efekti için Dialog gibi davranabilir
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Invite People",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primaryRed,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Copy the link to invite your friends",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "https://fitgym.app/invite?frie...",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryRed,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Share",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Buraya diğer menü itemlerini koyabilirsin ama genellikle modal olarak çıkar.
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
