import 'package:flutter/material.dart';

topAppBar() => AppBar(
    centerTitle: true,
    backgroundColor: Colors.orange[400],
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/namaste.png'),
        const SizedBox(
          width: 10,
        ),
        const Text(
          'LaLa Ki दुकान',
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
          ),
        ),
      ],
    ));
