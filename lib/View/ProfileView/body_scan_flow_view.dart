import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class BodyScanIntroView extends StatefulWidget {
  const BodyScanIntroView({super.key});

  @override
  State<BodyScanIntroView> createState() => _BodyScanIntroViewState();
}

class _BodyScanIntroViewState extends State<BodyScanIntroView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Elle kaydırmayı engelle
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          _buildIntroStep(),
          _buildValidationStep(),
          _buildInstructionsStep(),
          _buildCameraStep(), // Siyah arka planlı kamera ekranı
          _buildResultStep(),
        ],
      ),
    );
  }

  // 1. Intro
  Widget _buildIntroStep() {
    return _buildStepLayout(
      image: "assets/images/body_scan_1.png", // Beyaz manken
      title: "Welcome to\nBody Scan",
      desc:
          "Turn your device into an AI-powered body scanner.\nDiscover your body fat, muscle mass, and more.",
      btnText: "Next",
      onBtnTap: _nextPage,
    );
  }

  // 2. Validation
  Widget _buildValidationStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "How true is that?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          const Text(
            "The integration of depth camera technology ensures measurements comparable in accuracy to DXA scans.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 30),
          Image.asset("assets/images/texas_tech.png", height: 100), // Logo
          const SizedBox(height: 30),
          _buildCheckItem(
            "Industry-leading accuracy verified in university laboratories",
          ),
          _buildCheckItem(
            "0.20% absolute median error for body fat percentage",
          ),
          const Spacer(),
          _buildNextButton("Next", _nextPage),
        ],
      ),
    );
  }

  // 3. Instructions
  Widget _buildInstructionsStep() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Are you ready for the\nfirst scan?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _buildCheckItem("Turn up the volume"),
          _buildCheckItem("Cover your face"),
          _buildCheckItem("Wear clothes that fit your body"),
          _buildCheckItem("Find a spacious room"),
          const Spacer(),
          const Text(
            "What is your current weight?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "-  82 kg  +",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ), // Basit gösterim
          const SizedBox(height: 20),
          _buildNextButton("Get Started", _nextPage),
        ],
      ),
    );
  }

  // 4. Camera (Simulation)
  Widget _buildCameraStep() {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            "assets/images/body_scan_black.png",
            height: 400,
          ), // Siyah manken
          const Spacer(),
          const Text(
            "Place the phone where it can see your\nentire body.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _nextPage,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: MyColors.primaryRed,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  // 5. Result
  Widget _buildResultStep() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage("assets/images/profile_user.jpg"),
        ),
        const SizedBox(height: 20),
        const Text(
          "Your Analysis is Ready!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text(
          "We prepared a workout based\non the results",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 30),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: const Column(
            children: [
              ListTile(
                leading: Icon(Icons.fitness_center, color: Colors.red),
                title: Text("Body Type"),
                subtitle: Text(
                  "Balanced / Oily",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.flag, color: Colors.red),
                title: Text("Primary Goal"),
                subtitle: Text(
                  "Fat reduction",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Recommended Card (Basit)
        Container(
          margin: const EdgeInsets.all(20),
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage("assets/images/training1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Recommended: Cardio",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildNextButton("Back", () => Navigator.pop(context)),
        const SizedBox(height: 20),
      ],
    );
  }

  // --- Helpers ---
  Widget _buildStepLayout({
    required String image,
    required String title,
    required String desc,
    required String btnText,
    required VoidCallback onBtnTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            "Welcome to\nBody Scan",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
          Expanded(child: Image.asset(image)),
          _buildNextButton(btnText, onBtnTap),
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: MyColors.primaryRed),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildNextButton(String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryRed,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
