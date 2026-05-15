import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TranslatorScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const TranslatorScreen({super.key, required this.cameras});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  late CameraController _controller;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera(); // Initializes the camera for MileBridge AI
  }

  Future<void> _initCamera() async {
    if (widget.cameras.isEmpty) return;
    _controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    await _controller.initialize();
    if (!mounted) return;
    setState(() => _isReady = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for camera focus
      appBar: AppBar(
        title: const Text("AI Sign Translator"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Expanded Camera View
          Expanded(
            child: _isReady 
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30), // Professional mobile look
                  child: CameraPreview(_controller),
                )
              : const Center(child: CircularProgressIndicator()),
          ),
          
          // AI Result Drawer (Floating at the bottom)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("AI PREDICTION", style: TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 10),
                const Text(
                  "Hello World", // This will be dynamic once you plug in your AI logic
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF008080)),
                ),
                const SizedBox(height: 20),
                _buildControlRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        CircleAvatar(
          radius: 30,
          backgroundColor: const Color(0xFF008080),
          child: IconButton(icon: const Icon(Icons.volume_up, color: Colors.white), onPressed: () {}),
        ),
        IconButton(icon: const Icon(Icons.copy), onPressed: () {}),
      ],
    );
  }
}