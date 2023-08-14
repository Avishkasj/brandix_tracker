import 'package:flutter/material.dart';


class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Text('User Profile'),
        ),
        ListTile(
          title: Text('Help'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Info'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        // Add more list tiles as needed
      ],
    );
  }
}

