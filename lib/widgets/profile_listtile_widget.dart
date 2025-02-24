import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile(
      {super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: ListTile(
          leading: Icon(CupertinoIcons.person_fill),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}
