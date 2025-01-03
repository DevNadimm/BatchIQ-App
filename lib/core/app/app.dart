import 'package:batchiq_app/core/bindings/initial_bindings.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/theme/elevated_button_theme.dart';
import 'package:batchiq_app/core/theme/text_form_field_theme.dart';
import 'package:batchiq_app/core/theme/text_theme.dart';
import 'package:batchiq_app/features/auth/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BatchIQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        textTheme: textTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      initialBinding: InitialBindings(),
    );
  }
}