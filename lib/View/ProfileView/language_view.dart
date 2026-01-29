import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class LanguageView extends StatefulWidget {
  const LanguageView({super.key});

  @override
  State<LanguageView> createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  // Seçili dil (Varsayılan: English)
  String selectedLanguage = "English";

  final List<Map<String, String>> languages = [
    {"name": "Turkey", "flag": "🇹🇷"},
    {"name": "Korean", "flag": "🇰🇷"},
    {"name": "English", "flag": "🇬🇧"},
    {"name": "German", "flag": "🇩🇪"},
    {"name": "Italian", "flag": "🇮🇹"},
    {"name": "French", "flag": "🇫🇷"},
    {"name": "Japanese", "flag": "🇯🇵"},
    {"name": "Spanish", "flag": "🇪🇸"},
    {"name": "Russian", "flag": "🇷🇺"},
    {"name": "Portuguese", "flag": "🇵🇹"},
    {"name": "Hindi", "flag": "🇮🇳"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Otomatik back butonu var ama manuel ekleyelim (Tasarım uyumu için)
        leading: const BackButton(color: MyColors.darkBg),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Which language would you\nlike to continue in?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: MyColors.darkBg,
              ),
            ),
            const SizedBox(height: 30),

            // DİL LİSTESİ
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final lang = languages[index];
                  final isSelected = lang['name'] == selectedLanguage;
                  return GestureDetector(
                    onTap: () =>
                        setState(() => selectedLanguage = lang['name']!),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          Text(
                            lang['flag']!,
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Text(
                              lang['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // Radyo Butonu Görünümü
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? MyColors.primaryRed
                                    : Colors.grey,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: const BoxDecoration(
                                        color: MyColors.primaryRed,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // KAYDET BUTONU
            ElevatedButton(
              onPressed: () {
                // Dil değiştirme logic'i buraya (Get.updateLocale veya Riverpod ile)
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryRed,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
