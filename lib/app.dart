import 'package:contact_list2/ui/home_screen.dart';
import 'package:flutter/material.dart';

class MyContactList extends StatelessWidget {
  const MyContactList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: const HomeScreen(),
    );
  }
}
