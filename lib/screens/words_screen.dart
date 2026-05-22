import 'package:flutter/material.dart';

class WordsScreen extends StatelessWidget {
  const WordsScreen({super.key});

  final List<Map<String, String>> commonWords = const [
    {"word": "Hello / Hi", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/l3q2zVr6cu95nF6O4/giphy.gif", "desc": "Wave your hand from side to side near your temple."},
    {"word": "Thank You", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M4/giphy.gif", "desc": "Touch fingertips to your chin, then bring hand forward towards the person."},
    {"word": "Please", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M5/giphy.gif", "desc": "Place flat hand on chest and move it in a circular motion clockwise."},
    {"word": "Sorry", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M6/giphy.gif", "desc": "Make a fist with your thumb over fingers, place on chest, and make circles."},
    {"word": "Help", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M7/giphy.gif", "desc": "Place closed fist with thumb up on your flat open hand palm, lift up together."},
    {"word": "Love", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M8/giphy.gif", "desc": "Cross both arms over your chest with fists resting near your shoulders."},
    {"word": "Good Morning", "gif": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M9/giphy.gif", "desc": "Touch chin down, then raise your other hand outward like a rising sun."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6F8),
      appBar: AppBar(
        title: const Text("Common Words Dictionary", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: commonWords.length,
        itemBuilder: (context, index) {
          final item = commonWords[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              leading: CircleAvatar(backgroundColor: Colors.teal.shade50, child: Text("${index + 1}", style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold))),
              title: Text(item["word"]!, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF2C3E50))),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              onTap: () => _showSignLanguageDetail(context, item["word"]!, item["gif"]!, item["desc"]!),
            ),
          );
        },
      ),
    );
  }

  void _showSignLanguageDetail(BuildContext context, String word, String gifUrl, String description) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 20),
              Text(word.toUpperCase(), style: const TextStyle(fontFamily: 'Montserrat', fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF008080), letterSpacing: 1.5)),
              const SizedBox(height: 20),
              Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(color: const Color(0xFFE8F6F8), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.teal.shade100, width: 2)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    gifUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(child: CircularProgressIndicator(color: Colors.teal));
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("HOW TO SIGN:", style: TextStyle(fontFamily: 'Montserrat', fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
              const SizedBox(height: 8),
              Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15, color: Color(0xFF555555), height: 1.4)),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                  child: const Text("GOT IT", style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}