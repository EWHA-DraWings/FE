import 'package:flutter/material.dart';
import 'package:sodam/screens/Guardian_membership/membership_screen.dart';
import 'package:sodam/screens/register_type_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MembershipScreen(),
    );
  }
}
