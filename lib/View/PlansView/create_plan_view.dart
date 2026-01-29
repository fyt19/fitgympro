import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class CreatePlanView extends StatelessWidget {
  const CreatePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: const Color(0xffF2F5FC),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: MyColors.darkBg),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Weekly Plan",
          style: TextStyle(color: MyColors.darkBg, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // TARİH SEÇİCİ (YATAY)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const Text(
                    "November 2025",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDateChip("1-6\nNov", true),
                  _buildDateChip("7-13\nNov", false),
                  _buildDateChip("14-20\nNov", false),
                  _buildDateChip("21-26\nNov", false),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // GÜNLÜK PROGRAM LİSTESİ
            _buildDaySection(context, "01 Nov 2025", [
              {
                "time": "04:30 PM",
                "title": "Full Body Workout",
                "color": MyColors.primaryRed,
              },
            ]),

            _buildDaySection(context, "02 Nov 2025", []), // Boş gün örneği

            _buildDaySection(context, "04 Nov 2025", [
              {
                "time": "05:30 PM",
                "title": "Legs & Glutes Workout",
                "color": MyColors.primaryRed,
              },
              {
                "time": "06:30 PM",
                "title": "Chest",
                "color": MyColors.primaryRed,
              },
            ]),

            _buildDaySection(context, "06 Nov 2025", [
              {
                "time": "06:30 PM",
                "title": "Shoulders - Back Workout",
                "color": MyColors.primaryRed,
              },
            ]),

            const SizedBox(height: 20),

            // KAYDET BUTONU
            ElevatedButton(
              onPressed: () {},
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
                  Icon(Icons.bookmark_border, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    "Save Weekly Plan",
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

  Widget _buildDateChip(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: isSelected ? MyColors.primaryRed : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildDaySection(
    BuildContext context,
    String date,
    List<Map<String, dynamic>> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          _buildAddButton()
        else
          ...items.map((item) => _buildScheduleCard(context, item)).toList(),

        // Dolu günlerin altına da ekleme butonu koyuyoruz
        if (items.isNotEmpty) _buildAddButton(),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildScheduleCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                item['time'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.darkBg,
                ),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'].length > 18
                        ? item['title'].substring(0, 18) + "..."
                        : item['title'],
                    style: TextStyle(
                      color: item['color'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // DELETE POPUP MENU
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            onSelected: (value) {},
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(
                      Icons.delete_outline,
                      color: MyColors.primaryRed,
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Delete",
                      style: TextStyle(
                        color: MyColors.primaryRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Icon(Icons.add, color: MyColors.primaryRed),
    );
  }
}
