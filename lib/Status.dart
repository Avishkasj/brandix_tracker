import 'package:brandix_tracker/SlectLine.dart';
import 'package:flutter/material.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  void initState() {
    super.initState();

    // Add a delay of 5 seconds before navigating to the new screen
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SelectLine(), // Replace 'AnotherScreen' with your desired screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Icon(
                  Icons.done,
                  size: 100, // Adjust the size of the icon as needed
                  color: Colors.white, // Change the color of the icon
                ),
              ),
            ),
            SizedBox(height: 20), // Add some spacing between the icon and text
            Text(
              "Successful",
              style: TextStyle(
                fontSize: 34, // Adjust the font size as needed
                fontWeight: FontWeight.bold, // Adjust the font weight as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
