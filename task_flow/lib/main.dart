import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/login.dart';
import 'package:task_flow/screens/register.dart';
import 'package:task_flow/screens/splash.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(30, 0, 50, 1),
);

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
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    ),
  );
}
