import 'package:flutter/material.dart';

class LocationModesScreen extends StatelessWidget {
  const LocationModesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contextual Modes")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _modeTile(context, "Hospital Mode", Icons.local_hospital, Colors.red, ["I need a doctor", "Where is the ER?", "I have an allergy"]),
          _modeTile(context, "School Mode", Icons.school, Colors.blue, ["I have a question", "Can you repeat that?", "Thank you"]),
          _modeTile(context, "Commuter Mode", Icons.directions_bus, Colors.orange, ["Stop here please", "How much is the fare?", "Thank you"]),
        ],
      ),
    );
  }

  Widget _modeTile(BuildContext context, String title, IconData icon, Color color, List<String> phrases) {
    return ExpansionTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: phrases.map((p) => ListTile(
        title: Text(p),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Sending: $p"))),
      )).toList(),
    );
  }
}