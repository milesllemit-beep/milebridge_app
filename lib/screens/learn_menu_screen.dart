import 'package:flutter/material.dart';

class LearnMenuScreen extends StatefulWidget {
  const LearnMenuScreen({super.key});

  @override
  State<LearnMenuScreen> createState() => _LearnMenuScreenState();
}

class _LearnMenuScreenState extends State<LearnMenuScreen> {
  final TextEditingController _textController = TextEditingController();

  // State variables for dynamic layout tracking
  String _currentPlayingWord = "";
  String _currentGifUrl = "";
  String _currentLocalAssetPath = ""; // Handles local A-Z image files
  bool _isPlayingSentence = false;

  // Cloud Dictionary Network Engine (URLs for signs)
  final Map<String, String> _signLanguageApiDeck = const {
    "hello": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/l3q2zVr6cu95nF6O4/giphy.gif",
    "thank you": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M4/giphy.gif",
    "please": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M5/giphy.gif",
    "sorry": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M6/giphy.gif",
    "help": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M7/giphy.gif",
    "love": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M8/giphy.gif",
    "good morning": "https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXN6N2R6M3p0Y3BndXN6OHBqd3BndXN6OHBqd3BndXN6OHBqd3BndSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9cw/3o7qE4bWnzGvIQL9M9/giphy.gif",
  };

  // Quick Action Array Lists
  final List<String> _commonWordsList = const ["Hello", "Thank You", "Please", "Sorry", "Help", "Good Morning"];
  final List<String> _alphabetList = const ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];

  // Core Processing Method for parsing words or single character lookups
  Future<void> _playSentence(String input) async {
    if (input.trim().isEmpty) return;

    setState(() {
      _isPlayingSentence = true;
      _currentLocalAssetPath = "";
      _currentGifUrl = "";
    });

    List<String> words = input.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '').trim().split(RegExp(r'\s+'));

    for (String word in words) {
      if (!mounted) return;

      // Rule 1: Check if it's a full network word
      if (_signLanguageApiDeck.containsKey(word)) {
        setState(() {
          _currentLocalAssetPath = "";
          _currentPlayingWord = word.toUpperCase();
          _currentGifUrl = _signLanguageApiDeck[word]!;
        });
        await Future.delayed(const Duration(seconds: 3));
      } 
      // Rule 2: Fallback to spelling it out letter-by-letter with your local A-Z PNG files
      else {
        for (int i = 0; i < word.length; i++) {
          String letter = word[i];
          setState(() {
            _currentGifUrl = "";
            _currentPlayingWord = "${word.toUpperCase()} (${letter.toUpperCase()})";
            _currentLocalAssetPath = "assets/alphabet/$letter.png";
          });
          await Future.delayed(const Duration(milliseconds: 1300));
        }
      }
    }

    setState(() {
      _isPlayingSentence = false;
      _currentPlayingWord = "DONE DEMONSTRATING";
    });
  }

  // Directly sets up visual context when selecting chips instantly
  void _triggerDirectAsset(String target, {bool isAlphabet = false}) {
    if (_isPlayingSentence) return;
    
    setState(() {
      if (isAlphabet) {
        _currentGifUrl = "";
        _currentPlayingWord = "LETTER $target";
        _currentLocalAssetPath = "assets/alphabet/${target.toLowerCase()}.png";
      } else {
        _currentLocalAssetPath = "";
        _currentPlayingWord = target.toUpperCase();
        _currentGifUrl = _signLanguageApiDeck[target.toLowerCase()] ?? "";
      }
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
      backgroundColor: const Color(0xFFF4F7F6), // Smooth off-white/light gray canvas matching mockup
      appBar: AppBar(
        title: const Text(
          "Smart Sign Studio",
          style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                // 1. CLEAN HIGHER-FIDELITY STUDIO CARD
                Container(
                  height: 340,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBE5E7), // Beautiful backdrop green-blue bounding wrap
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF90C2C5), // Inner profile frame tint color matching image
                      borderRadius: BorderRadius.circular(24),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // RENDERING SYSTEM LOOKUPS BASED ON ACTIVE PAYLOAD
                        if (_currentGifUrl.isNotEmpty)
                          Image.network(_currentGifUrl, fit: BoxFit.cover, width: double.infinity, height: double.infinity)
                        else if (_currentLocalAssetPath.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image.asset(_currentLocalAssetPath, fit: BoxFit.contain),
                          )
                        else
                          // Empty/Idle Placeholder: Showing our friendly AI Sign companion icon
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.face_retouching_natural_rounded, size: 80, color: Colors.teal.shade800),
                              const SizedBox(height: 12),
                              Text(
                                "Studio Engine Live",
                                style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.teal.shade900, fontSize: 18),
                              ),
                            ],
                          ),

                        // IMMERSIVE DESIGN HUD TEXT BANNER OVER VIDEO INTERFACE
                        if (_currentPlayingWord.isNotEmpty)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withValues(alpha: 0.6),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                "'$_currentPlayingWord'",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. TEXT FIELD ENTRY FIELD BLOCK
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "TYPE YOUR SENTENCE",
                    style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 11, letterSpacing: 0.5),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        enabled: !_isPlayingSentence,
                        decoration: InputDecoration(
                          hintText: "e.g., Hello please sorry",
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 54,
                      width: 56,
                      child: ElevatedButton(
                        onPressed: _isPlayingSentence ? null : () => _playSentence(_textController.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade700,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Icon(Icons.play_arrow_rounded, size: 32),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 3. HORIZONTAL CHIP SYSTEM LIBRARIES (Alphabet Collection)
                const Text(
                  "TAP QUICK ALPHABET A-Z",
                  style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 11, letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _alphabetList.length,
                    itemBuilder: (context, index) {
                      final item = _alphabetList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(item, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.teal.shade900)),
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.teal.shade200),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onPressed: () => _triggerDirectAsset(item, isAlphabet: true),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // 4. HORIZONTAL CHIP SYSTEM LIBRARIES (Common Expressions Collection)
                const Text(
                  "OR TAP QUICK COMMON WORDS",
                  style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 11, letterSpacing: 0.5),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _commonWordsList.length,
                    itemBuilder: (context, index) {
                      final item = _commonWordsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ActionChip(
                          label: Text(item, style: const TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.black87)), // fixed here!
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          onPressed: () => _triggerDirectAsset(item, isAlphabet: false),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // NATIVE FLOATING BOTTOM NAVIGATION STRIP FOR CALL TO ACTION
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushNamed(context, '/translator'),
                icon: const Icon(Icons.videocam_rounded),
                label: const Text(
                  "LAUNCH PRACTICE CAM",
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}