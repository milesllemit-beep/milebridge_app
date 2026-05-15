import 'package:flutter/material.dart';

class EmotionalSupportScreen extends StatelessWidget {
  const EmotionalSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Check My Mood")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Container(
                width: 150, height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const RadialGradient(colors: [Colors.cyanAccent, Color(0xFF008080)]),
                  // FIXED: Updated glow effect for new Flutter standards
                  boxShadow: [BoxShadow(color: Colors.cyan.withValues(alpha: 0.5), blurRadius: 30)],
                ),
                child: const Center(child: Text("AI", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold))),
              ),
            ),
            const SizedBox(height: 60),
            _chatBubble("You look a little frustrated today. Want to sign about it?"),
            const Spacer(),
            TextField(
              decoration: InputDecoration(
                hintText: "[Sign or Type your feelings...]",
                filled: true, fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF008080),
                minimumSize: const Size(double.infinity, 55),
                shape: const StadiumBorder()
              ),
              onPressed: () {}, 
              child: const Text("Start Visual Mood Check (Camera)", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chatBubble(String txt) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Text(txt, style: const TextStyle(color: Colors.black87)),
    );
  }
}