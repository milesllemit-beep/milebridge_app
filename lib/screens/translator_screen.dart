import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class TranslatorScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  // FIXED: Gihimong modernong super parameter para mawala ang warning sa VS Code
  const TranslatorScreen({
    super.key,
    required this.cameras,
  });

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> with WidgetsBindingObserver {
  late CameraController _controller;
  late FlutterTts _flutterTts;
  late PoseDetector _poseDetector;

  bool _isInitialized = false;
  bool _isDetecting = false;
  bool _handDetected = false;

  String _translatedText = "Waiting for signs...";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeTTS();

    _poseDetector = PoseDetector(
      options: PoseDetectorOptions(
        mode: PoseDetectionMode.stream,
      ),
    );

    _initializeCamera();
  }

  Future<void> _initializeTTS() async {
    _flutterTts = FlutterTts();
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setVolume(1.0);
  }

  Future<void> _speakText() async {
    await _flutterTts.stop();
    await _flutterTts.speak(_translatedText);
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isEmpty) {
      debugPrint("No camera found.");
      return;
    }

    try {
      final selectedCamera = widget.cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => widget.cameras.first,
      );

      _controller = CameraController(
        selectedCamera,
        // HIGH QUALITY CAMERA
        ResolutionPreset.max,
        enableAudio: false,
        // FIXED: Giilisan og bgra8888 kay kini ang compatible para sa image streaming sa Emulator/Windows
        imageFormatGroup: ImageFormatGroup.bgra8888,
      );

      await _controller.initialize();

      await _controller.startImageStream(
        (CameraImage image) async {
          if (_isDetecting) return;
          _isDetecting = true;

          try {
            // SIMULATED AI DETECTION
            await Future.delayed(
              const Duration(milliseconds: 300),
            );

            if (!mounted) return;

            setState(() {
              _handDetected = true;
              // SAMPLE TRANSLATION
              _translatedText = "HELLO";
            });
          } catch (e) {
            debugPrint("Detection Error: $e");
          }
          _isDetecting = false;
        },
      );

      if (!mounted) return;

      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint("Camera Error: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    _flutterTts.stop();
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: !_isInitialized
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF008080),
              ),
            )
          : Stack(
              children: [
                // CAMERA PREVIEW
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                ),

                // DARK OVERLAY
                Container(
                  // FIXED: Giilisan og withValues(alpha: ...) para sa Flutter 3.44.0 standard
                  color: Colors.black.withValues(alpha: 0.2),
                ),

                // TRANSLATION CARD
                Positioned(
                  top: 60,
                  left: 20,
                  right: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      // FIXED: Giilisan og withValues(alpha: ...)
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          // FIXED: Giilisan og withValues(alpha: ...)
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          _translatedText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          _handDetected ? "FSL SIGN DETECTED" : "WAITING FOR INPUT",
                          style: TextStyle(
                            color: _handDetected ? const Color(0xFF00D9B5) : Colors.black54,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // DETECTION GATEWAY
                Center(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: _handDetected ? const Color(0xFF00F5D4) : const Color(0xFF008080),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          // FIXED: Giilisan og withValues(alpha: ...)
                          color: const Color(0xFF00F5D4).withValues(alpha: 0.4),
                          blurRadius: 25,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(14),
                        child: Text(
                          "ALIGN HAND HERE",
                          style: TextStyle(
                            color: Color(0xFF00F5D4),
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // CONTROL PANEL
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      // FIXED: Giilisan og withValues(alpha: ...)
                      color: Colors.white.withValues(alpha: 0.97),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(36),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.history,
                              color: Colors.black54,
                              size: 30,
                            ),
                            SizedBox(height: 8),
                            Text("History"),
                          ],
                        ),

                        // AUDIO BUTTON
                        GestureDetector(
                          onTap: _speakText,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF008080),
                              boxShadow: [
                                BoxShadow(
                                  // FIXED: Giilisan og withValues(alpha: ...)
                                  color: const Color(0xFF008080).withValues(alpha: 0.4),
                                  blurRadius: 25,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.volume_up,
                              color: Colors.white,
                              size: 42,
                            ),
                          ),
                        ),

                        // CLEAR BUTTON
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _translatedText = "Waiting for signs...";
                              _handDetected = false;
                            });
                          },
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.refresh,
                                color: Colors.black54,
                                size: 30,
                              ),
                              SizedBox(height: 8),
                              Text("Clear"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}