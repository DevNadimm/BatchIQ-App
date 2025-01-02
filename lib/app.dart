import 'package:batchiq_app/core/binders/controller_binders.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/theme/elevated_button_theme.dart';
import 'package:batchiq_app/core/theme/text_form_field_theme.dart';
import 'package:batchiq_app/core/theme/text_theme.dart';
import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
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
      home: const SignInScreen(),
      initialBinding: ControllerBinders(),
    );
  }
}