import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Hata buradaydı, bu importu ekleyince AppRoutes hatası düzelecek:
import 'Core/Routes/app_routes.dart';
import 'View/SplashView/splash_view.dart';
import 'theme/my_colors.dart';

// Doküman Madde 10 & 13: Global key ve Navigator yönetimi [cite: 306, 317]
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Doküman Madde 13: Tasarım boyutlarına göre ScreenUtil [cite: 314, 315]
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'FitGYM Pro',

          // Rotalar AppRoutes üzerinden yönetiliyor [cite: 318]
          routes: AppRoutes.routes,

          // Doküman Madde 13: Genel tema ve arka plan rengi [cite: 320, 322]
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xffF2F5FC),

            // Yazı tipi olarak Nunito Sans [cite: 324]
            textTheme: GoogleFonts.nunitoSansTextTheme(
              Theme.of(context).textTheme,
            ),

            colorScheme: ColorScheme.fromSeed(
              seedColor: MyColors.primaryRed,
              primary: MyColors.primaryRed,
            ),
          ),

          // İlk açılış ekranı SplashView [cite: 327]
          home: const SplashView(),
        );
      },
    );
  }
}
