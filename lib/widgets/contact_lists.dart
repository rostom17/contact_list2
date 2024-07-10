import 'package:flutter/material.dart';

class ContactLists extends StatefulWidget {
  const ContactLists({super.key,required this.myContactList});

  final Map<String,dynamic> myContactList;

  @override
  State<ContactLists> createState() => _ContactListsState();
}

class _ContactListsState extends State<ContactLists> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Text(widget.myContactList['name']),
      ),
    );
  }
}
