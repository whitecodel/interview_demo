import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interview_demo/show_loader.dart';

import 'login_page.dart';
import 'root_check.dart';
import 'ssl_pinning_handler.dart' show getSSLPinningClient;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  bool isRooted = false;
  bool connectionSecure = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    isLoading = true;
    await checkRoot();
    await getData();
    setState(() {
      isLoading = false;
    });
  }

  checkRoot() async {
    try {
      isRooted = await RootChecker.isRooted();
    } catch (e) {
      log(e.toString());
    }
  }

  getData() async {
    try {
      final client = await getSSLPinningClient();
      final response = await client.get(Uri.parse(
          'https://uat-nftbe.metaspacechain.com/nftmarketplace/api/v1/test/get_all_nfts'));
      log(response.body);
      connectionSecure = true;
    } on TlsException catch (e) {
      log(e.toString());
      connectionSecure = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              showLoader(context);
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading)
              Column(
                children: [
                  Text("Rooted: $isRooted"),
                  Text("Connection Secure: $connectionSecure"),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showLoader(context);
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        },
        child: const Icon(Icons.logout),
      ),
    );
  }
}
