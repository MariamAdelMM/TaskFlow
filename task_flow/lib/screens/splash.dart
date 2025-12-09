import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 30), () {
      Navigator.pushReplacementNamed(context, '/home');
      // pushReplacement() removes the splash screen from stack so user can’t return to it by clicking back.
      // Navigator.pushReplacement( => Pushes HomeScreen() as the new first screen.
      //   context,
      //   MaterialPageRoute(builder: (context) => HomeScreen()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(30, 0, 50, 1),
              Color.fromRGBO(15, 0, 40, 1),
              Color.fromRGBO(5, 0, 20, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),

              Icon(
                Icons.check_box_outlined,
                size: 90,
                color: const Color.fromARGB(255, 135, 43, 235),
              ),
              const SizedBox(height: 24),

              Text(
                "TaskFlow",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                "Organize your life, one task at a time.",
                style: TextStyle(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildBottomItem(
                    Icons.calendar_today,
                    "Plan",
                    Colors.redAccent,
                  ),
                  _buildBottomItem(
                    Icons.check_box,
                    "Track",
                    Colors.greenAccent,
                  ),
                  _buildBottomItem(
                    Icons.self_improvement,
                    "Focus",
                    Colors.amber,
                  ),
                  _buildBottomItem(
                    Icons.pie_chart,
                    "Achieve",
                    Colors.blueAccent,
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
