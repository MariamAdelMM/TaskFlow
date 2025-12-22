import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/screens/edit.dart';
import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/login.dart';
import 'package:task_flow/screens/register.dart';
import 'package:task_flow/screens/splash.dart';
import 'package:task_flow/widgets/tabs.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(30, 0, 50, 1),
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/tabs': (context) => const Tabs(),
        '/edit': (context) => const EditTasksScreen(),
      },
    );
  }
}
