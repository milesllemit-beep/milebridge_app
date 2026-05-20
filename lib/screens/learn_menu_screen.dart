import 'package:flutter/material.dart';

class LearnMenuScreen extends StatelessWidget {
  const LearnMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6F8),
      appBar: AppBar(
        title: const Text("Learn Sign Language"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMenuCard(context, "Alphabet A-Z", Icons.abc, "/alphabet"),
          _buildMenuCard(context, "Common Words", Icons.wb_sunny_outlined, "/words"),
          _buildMenuCard(context, "Daily Phrases", Icons.record_voice_over, "/phrases"),
          const SizedBox(height: 30),
          
          // Practice Button
          SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/translator'),
              icon: const Icon(Icons.videocam),
              label: const Text("PRACTICE MODE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade50,
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}