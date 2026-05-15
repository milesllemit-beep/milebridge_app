import 'package:flutter/material.dart';

class MessengerBridgeScreen extends StatefulWidget {
  const MessengerBridgeScreen({super.key});

  @override
  State<MessengerBridgeScreen> createState() => _MessengerBridgeScreenState();
}

class _MessengerBridgeScreenState extends State<MessengerBridgeScreen> {
  bool isFSL = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Messenger Bridge"),
        actions: [
          Row(
            children: [
              Text(isFSL ? "FSL" : "ASL", style: const TextStyle(fontWeight: FontWeight.bold)),
              Switch(
                value: isFSL,
                onChanged: (val) => setState(() => isFSL = val),
                // FIXED for Flutter 3.31+
                activeThumbColor: Colors.white,
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                _ChatBubble(text: "Hello! How can I help you today?", isMe: false),
                _ChatBubble(text: "[Sign Language Detected: I need water]", isMe: true),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt, color: Color(0xFF008080))),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(hintText: "Type to translate to sign...", border: InputBorder.none),
                  ),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send, color: Color(0xFF008080))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  const _ChatBubble({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF008080) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          // FIXED: Use withValues for modern transparency
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5)],
        ),
        child: Text(text, style: TextStyle(color: isMe ? Colors.white : Colors.black87)),
      ),
    );
  }
}