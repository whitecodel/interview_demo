import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:interview_demo/show_loader.dart';

import 'otp_verification_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      showLoader(context);
      String phoneNumber = "+91${_phoneController.text.trim()}";

      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully'),
            ),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to send OTP'),
            ),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('OTP sent successfully'),
            ),
          );
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => OtpVerificationPage(
                    verificationId: verificationId,
                  )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  // only 10 digits can be entered
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  hintText: 'Phone number',
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.phone),
                      Text(
                        '+91',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  border:
                      OutlineInputBorder(), // Changed from InputBorder.none to OutlineInputBorder
                  focusedBorder:
                      OutlineInputBorder(), // Changed from InputBorder.none to OutlineInputBorder
                  errorBorder:
                      OutlineInputBorder(), // Changed from InputBorder.none to OutlineInputBorder
                  focusedErrorBorder:
                      OutlineInputBorder(), // Changed from InputBorder.none to OutlineInputBorder
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendOTP,
                child: const Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
