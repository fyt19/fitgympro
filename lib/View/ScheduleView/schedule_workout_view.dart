import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../theme/my_colors.dart';

class ScheduleWorkoutView extends StatefulWidget {
  const ScheduleWorkoutView({super.key});

  @override
  State<ScheduleWorkoutView> createState() => _ScheduleWorkoutViewState();
}

class _ScheduleWorkoutViewState extends State<ScheduleWorkoutView> {
  String selectedTime = "08:30 AM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F5FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: MyColors.darkBg),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Schedule Workout",
          style: TextStyle(color: MyColors.darkBg, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TAKVİM KARTI
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "November 2025",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.chevron_left),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Basit takvim satırı (Örnek)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(7, (index) {
                      int day = 11 + index;
                      bool isSelected = day == 14;
                      return Column(
                        children: [
                          Text(
                            ["MO", "TU", "WE", "TH", "FR", "SA", "SU"][index],
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? MyColors.primaryRed
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "$day",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? Colors.white
                                    : MyColors.darkBg,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SEÇİLİ ANTRENMAN KARTI
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      "assets/images/training0.png",
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Body Workout",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "45 Min  |  350 kcal",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: MyColors.primaryRed.withOpacity(0.5),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              "Select Time",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 15),

            // SAAT SEÇİMİ
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["07:00 AM", "08:30 AM", "10:00 AM", "11:00 AM"].map((
                  time,
                ) {
                  bool isSelected = time == selectedTime;
                  return GestureDetector(
                    onTap: () => setState(() => selectedTime = time),
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? MyColors.primaryRed : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.transparent),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : MyColors.darkBg,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),

            // HATIRLATICI
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.notifications_active_outlined,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Get Reminder",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Get notified 15 min before",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    value: true,
                    activeColor: MyColors.primaryRed,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // BUTON
            ElevatedButton(
              onPressed: () {
                // Programı kaydetme işlemi burada yapılır
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
                  Icon(Icons.calendar_today, color: Colors.white, size: 20),
                  SizedBox(width: 10),
                  Text(
                    "Schedule Workout",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
