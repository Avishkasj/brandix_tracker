import 'package:brandix_tracker/Login.dart';
import 'package:flutter/material.dart';

class DrawerContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.green,
          ),
          child: Image(
            image: AssetImage(
              'assets/logob.png',
            ),
          ),
        ),
        ListTile(
          title: Text('Help'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Logout'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Login()),
            );
          },
        ),
        // Add more list tiles as needed
      ],
    );
  }
}
