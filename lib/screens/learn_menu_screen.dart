import 'package:flutter/material.dart';

class LearnMenuScreen extends StatefulWidget {
  const LearnMenuScreen({super.key});

  @override
  State<LearnMenuScreen> createState() => _LearnMenuScreenState();
}

class _LearnMenuScreenState extends State<LearnMenuScreen> {
  final TextEditingController _textController = TextEditingController();

  // State variables alang sa Dynamic AI Studio Player
  String _currentPlayingWord = "";
  String _currentGifUrl = "";
  bool _isPlayingSentence = false;

  // Cloud Network Dictionary Engine (API Links)
  final Map<String, String> _signLanguageApiDeck = const {
    // Alphabet Fallback Assets
    "a": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE1YN7aBOFPRw8E/giphy.gif",
    "b": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE1YN7aBOFPRw8F/giphy.gif",
    "c": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE1YN7aBOFPRw8G/giphy.gif",

    // Common Words / Phrases
    "hello": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/l3q2zVr6cu95nF6O4/giphy.gif",
    "thank you": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M4/giphy.gif",
    "please": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M5/giphy.gif",
    "sorry": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M6/giphy.gif",
    "help": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M7/giphy.gif",
    "love": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M8/giphy.gif",
    "good morning": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M9/giphy.gif",
  };

  // LOGIC ENGINE: Mo-split sa sentence ug mo-play sa GIF word-by-word
  Future<void> _playSentence(String input) async {
    if (input.trim().isEmpty) return;

    setState(() {
      _isPlayingSentence = true;
    });

    // Gitangtang ang bantas ug gi-split pinaagi sa spaces
    List<String> words = input.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim().split(RegExp(r'\s+'));

    for (String word in words) {
      if (!mounted) return;

      if (_signLanguageApiDeck.containsKey(word)) {
        setState(() {
          _currentPlayingWord = word.toUpperCase();
          _currentGifUrl = _signLanguageApiDeck[word]!;
        });
        // I-play ang tibuok pulong sulod sa 3 ka segundo
        await Future.delayed(const Duration(seconds: 3));
      } else {
        // Kon wala ang tibuok pulong sa diksyonaryo, i-spelling kini gamit ang A-Z letters
        for (int i = 0; i < word.length; i++) {
          String letter = word[i];
          if (_signLanguageApiDeck.containsKey(letter)) {
            setState(() {
              _currentPlayingWord = "${word.toUpperCase()} (${letter.toUpperCase()})";
              _currentGifUrl = _signLanguageApiDeck[letter]!;
            });
            await Future.delayed(const Duration(milliseconds: 1300));
          }
        }
      }
    }

    setState(() {
      _isPlayingSentence = false;
      _currentPlayingWord = "DONE DEMONSTRATING";
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F6F8), // Imong light teal background
      appBar: AppBar(
        title: const Text(
          "Learn Sign Language",
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // 1. DYNAMIC AI STUDIO DISPLAY COMPONENT (Kini katong naay image prototype logo)
          Container(
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
              border: Border.all(color: Colors.teal.shade100, width: 1.5),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_currentGifUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.network(
                      _currentGifUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const CircularProgressIndicator(color: Colors.teal);
                      },
                    ),
                  )
                else
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.smart_toy_outlined, size: 55, color: Colors.teal.shade300),
                      const SizedBox(height: 12),
                      const Text(
                        "AI Sign Studio Ready",
                        style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Color(0xFF2C3E50), fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Type a custom sentence below to view tracking.",
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                    ],
                  ),

                // DYNAMIC SUBTITLE RIBBON BAND
                if (_currentPlayingWord.isNotEmpty)
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _currentPlayingWord,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // 2. SMART TEXT INPUT FIELD FOR GENERATION
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  enabled: !_isPlayingSentence,
                  style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
                  decoration: InputDecoration(
                    hintText: "Type sentence (e.g., hello please a)",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 48,
                width: 52,
                child: ElevatedButton(
                  onPressed: _isPlayingSentence ? null : () => _playSentence(_textController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: _isPlayingSentence
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.play_arrow_rounded, size: 26),
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),

          // 3. SEPARATOR HEADER
          const Text(
            "LEARN LIBRARIES",
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 11, letterSpacing: 1),
          ),
          const SizedBox(height: 10),

          // 4. IMONG KASAMTANGANG MENU CARDS
          _buildMenuCard(context, "Alphabet A-Z", Icons.abc, "/alphabet"),
          _buildMenuCard(context, "Common Words", Icons.wb_sunny_outlined, "/words"),
          _buildMenuCard(context, "Daily Phrases", Icons.record_voice_over, "/phrases"),
          
          const SizedBox(height: 20),

          // 5. IMONG PRACTICE MODE FLOATING ACTION BUTTON
          SizedBox(
            height: 55,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/translator'),
              icon: const Icon(Icons.videocam),
              label: const Text(
                "PRACTICE MODE",
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, String route) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.5,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
        leading: CircleAvatar(
          backgroundColor: Colors.teal.shade50,
          child: Icon(icon, color: Colors.teal),
        ),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 15, color: Color(0xFF2C3E50)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black38),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}