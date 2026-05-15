import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  final String email;
  final String correctCode;

  const VerificationScreen({
    super.key, 
    required this.email, 
    required this.correctCode
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final _codeController = TextEditingController();
  String? errorMessage;

  void _verify() {
    setState(() {
      if (_codeController.text.isEmpty) {
        errorMessage = "Please enter the verification code.";
      } else if (_codeController.text != widget.correctCode) {
        errorMessage = "Incorrect code. Please check your console/email.";
      } else {
        // SUCCESS: Move to Dashboard and delete the login history
        errorMessage = null;
        Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(), // Allows user to go back to fix their email
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mark_email_read_outlined, size: 80, color: Color(0xFF008080)),
            const SizedBox(height: 20),
            const Text("Verify Your Email", 
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Sent to: ${widget.email}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            TextField(
              controller: _codeController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "0 0 0 0",
                errorText: errorMessage,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _verify,
                child: const Text("Confirm & Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}