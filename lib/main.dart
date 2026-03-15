import 'package:crenno_huseyin_gur/product/initial/app_init.dart';
import 'package:crenno_huseyin_gur/product/navigation/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await ApplicationInitialize.initialize(); // Uygulama başlangıç işlemleri
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(410, 864),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: AppRoute.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            sliderTheme: SliderThemeData(
              trackHeight: 1,
              showValueIndicator: ShowValueIndicator.always,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.r),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            useMaterial3: false,
            textTheme: GoogleFonts.robotoTextTheme(),
          ),
          builder: (context, child) {
            return child!;
          },
        );
      },
    );
  }
}
