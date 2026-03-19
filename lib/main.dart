import 'package:daily_spark/core/constants/strings.dart';
import 'package:daily_spark/features/home/screens/home_screen.dart';
import 'package:daily_spark/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(){
    setState(() {
      themeMode =
      themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: HomeScreen(toggleTheme: toggleTheme,)
    );
  }
}
