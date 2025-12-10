import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/login.dart';
import 'package:task_flow/screens/splash.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(30, 0, 50, 1),
);

class ScreenWrapper extends StatelessWidget {
  final Widget child;
  final String title;

  const ScreenWrapper({required this.child, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: child,
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Color.fromRGBO(30, 0, 50, 1),
          foregroundColor: Colors.white,
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondary,
            fontSize: 18,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) =>
            const ScreenWrapper(title: '', child: SplashScreen()),
        '/home': (context) =>
            const ScreenWrapper(title: 'HomeScreen', child: HomeScreen()),
        '/login': (context) =>
            const ScreenWrapper(title: '', child: LoginScreen()),
      },
    ),
  );
}
