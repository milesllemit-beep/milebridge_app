import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F6F8), Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.handshake_rounded, size: 100, color: Color(0xFF008080)),
            const SizedBox(height: 20),
            const Text("MileBridge AI", 
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF008080))),
            const Text("Giving voice to silence", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 60),
            _buildBtn(context, "Sign In / Register", const Color(0xFF008080), Colors.white, '/register'),
            const SizedBox(height: 15),
            _buildBtn(context, "Continue as Guest", Colors.white, const Color(0xFF008080), '/dashboard', border: true),
          ],
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context, String txt, Color bg, Color textCol, String route, {bool border = false}) {
    return SizedBox(
      width: 280, height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          elevation: 0,
          side: border ? const BorderSide(color: Color(0xFF008080)) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(txt, style: TextStyle(color: textCol, fontWeight: FontWeight.bold)),
      ),
    );
  }
}