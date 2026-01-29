import 'dart:async';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../theme/my_colors.dart';

class WorkoutPlayerView extends StatefulWidget {
  final String exerciseName;
  const WorkoutPlayerView({super.key, required this.exerciseName});

  @override
  State<WorkoutPlayerView> createState() => _WorkoutPlayerViewState();
}

class _WorkoutPlayerViewState extends State<WorkoutPlayerView> {
  bool isResting = false;
  late YoutubePlayerController _controller;

  // YouTube Linki
  final String videoUrl = "https://www.youtube.com/shorts/qyzWSrLC2jU";

  // Sayaç Değişkenleri
  Timer? _restTimer;
  static const int _totalRestTime = 30;
  int _timeLeft = _totalRestTime;

  @override
  void initState() {
    super.initState();
    final String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        loop: true,
        mute: true,
        hideControls: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _restTimer?.cancel();
    super.dispose();
  }

  // Sayacı Başlatan Fonksiyon
  void _startRestTimer() {
    setState(() {
      isResting = true;
      _timeLeft = _totalRestTime;
      _controller.pause(); // Dinlenmeye geçince videoyu durdur
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          _timeLeft--;
        });
      } else {
        _skipRest(); // Süre biterse otomatik olarak geri dön
      }
    });
  }

  // Dinlenmeyi Bitiren/Atlayan Fonksiyon
  void _skipRest() {
    _restTimer?.cancel(); // Sayacı durdur
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ÜST BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, size: 30),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Column(
                    children: [
                      Text(
                        widget.exerciseName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 150,
                        child: LinearProgressIndicator(
                          value: 0.3,
                          backgroundColor: Colors.grey.shade200,
                          color: MyColors.primaryRed,
                          minHeight: 4,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 40),
                  Text(
                    "STEP 1 OF 3",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),

            // ORTA ALAN (Video veya Dinlenme Sayacı)
            if (isResting)
              _buildRestView()
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: MyColors.primaryRed,
                    progressColors: const ProgressBarColors(
                      playedColor: MyColors.primaryRed,
                      handleColor: MyColors.primaryRed,
                    ),
                  ),
                ),
              ),

            const Spacer(),

            // ALT BAR
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: isResting
                  ? const SizedBox() // Dinlenirken alt butonları gizle
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "12 Reps",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: MyColors.darkBg,
                          ),
                        ),
                        // İLERİ BUTONU (Dinlenmeyi Başlatır)
                        GestureDetector(
                          onTap: _startRestTimer,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: MyColors.primaryRed.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.skip_next,
                              color: MyColors.primaryRed,
                              size: 35,
                            ),
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

  // SAYAÇ GÖRÜNÜMÜ
  Widget _buildRestView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: _timeLeft / _totalRestTime, // Süreye göre doluluk oranı
                strokeWidth: 8,
                color: MyColors.primaryRed,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            Column(
              children: [
                Text(
                  "$_timeLeft", // Geri sayan sayı
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: MyColors.darkBg,
                  ),
                ),
                const Text(
                  "Rest",
                  style: TextStyle(fontSize: 24, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),

        // SAYAÇ ATLAMA BUTONU
        TextButton(
          onPressed: _skipRest,
          child: const Text(
            "SKIP REST",
            style: TextStyle(
              color: MyColors.primaryRed,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
