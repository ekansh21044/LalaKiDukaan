import 'package:flutter/material.dart';
import 'package:lalakidukaan_app/appbar.dart';

class AuthenticationConfirmed extends StatelessWidget {
  const AuthenticationConfirmed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topAppBar(),
        body: const Center(
          child: Text(
            'Authentication Confirmed',
            style: TextStyle(fontSize: 100),
          ),
        ));
  }
}
