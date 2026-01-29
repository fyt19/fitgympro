import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: MyColors.darkBg),
        title: const Text(
          "FAQ",
          style: TextStyle(color: MyColors.darkBg, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _FAQItem(
            "How does this app work?",
            "The app analyzes your goals and level to create an AI-powered personal training plan.",
            true,
          ),
          _FAQItem("How does real-time form analysis work?", "", false),
          _FAQItem("Is this app suitable for all levels?", "", false),
          _FAQItem("Who can use this app?", "", false),
        ],
      ),
    );
  }
}

class _FAQItem extends StatelessWidget {
  final String q, a;
  final bool isOpen;
  const _FAQItem(this.q, this.a, this.isOpen);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isOpen,
          title: Text(
            q,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.darkBg,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(a, style: const TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
