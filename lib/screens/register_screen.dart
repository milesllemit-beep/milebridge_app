import 'dart:math';
import 'package:flutter/material.dart';
import 'verification_screen.dart'; // Ensure this matches your file name

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  void _generateAndSendCode() {
    // 1. Validation: Prevent empty fields
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill up all fields")),
      );
      return;
    }

    // 2. Generate a random 4-digit code
    String generatedCode = (Random().nextInt(9000) + 1000).toString();
    
    // DEBUG: View the code in your VS Code / Android Studio console
    debugPrint("DEBUG: Security code for ${_emailController.text} is: $generatedCode");

    // 3. Move to verification manually (to pass data)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerificationScreen(
          email: _emailController.text,
          correctCode: generatedCode,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create Account.", 
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(controller: _nameController, 
              decoration: const InputDecoration(labelText: "Full Name")),
            const SizedBox(height: 20),
            TextField(controller: _emailController, 
              decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity, height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D1B2A), 
                  shape: const StadiumBorder()
                ),
                onPressed: _generateAndSendCode,
                child: const Text("Register", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}