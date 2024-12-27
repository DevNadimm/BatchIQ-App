import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/theme/elevated_button_theme.dart';
import 'package:batchiq_app/core/theme/text_theme.dart';
import 'package:batchiq_app/features/join_batch/screens/join_batch_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BatchIQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        textTheme: textTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        useMaterial3: true,
      ),
      home: const JoinBatchScreen(),
    );
  }
}