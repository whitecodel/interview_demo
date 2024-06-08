import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:interview_demo/show_loader.dart';

import 'home_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String verificationId;

  const OtpVerificationPage({super.key, required this.verificationId});

  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _verifyOTP() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    showLoader(context);

    String smsCode = _otpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged in successfully')),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: _otpController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter OTP';
                  }
                  if (value.length < 6) {
                    return 'Please enter valid OTP';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: const InputDecoration(
                  hintText: 'Enter OTP',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verifyOTP,
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
