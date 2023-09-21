import 'dart:convert';

import 'package:brandix_tracker/Status.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChecklistItem {
  final String title;
  bool isChecked;
  bool isError;

  ChecklistItem(
      {required this.title, this.isChecked = false, this.isError = false});
}

class CheckList extends StatefulWidget {
  final String data;
  final int selectButtonValue; // Make sure it's not final

  CheckList({required this.data, required this.selectButtonValue, Key? key})
      : super(key: key);

  @override
  _CheckListState createState() => _CheckListState();
}


class _CheckListState extends State<CheckList> {
  List<ChecklistItem> checklist = [
    ChecklistItem(title: 'Machine Arrangement'),
    ChecklistItem(title: 'Machine Wise Air Regulator Arrangement'),
    ChecklistItem(title: 'Machine Wise & Module Air Leak'),
    ChecklistItem(title: 'Machine Wise Wire & Tube Arrangement'),
    ChecklistItem(title: 'Machine Table Top Cleaning Condition'),
    ChecklistItem(title: 'Machine Table Top Sticker Arrangement'),
    ChecklistItem(title: 'Blue Sheet Arrangement'),
    ChecklistItem(title: 'Machine Table Top Condition (Damage or Not)'),
    ChecklistItem(title: 'Machine Head Cleaning Condition'),
    ChecklistItem(title: 'Machine Head Paint Condition'),
    ChecklistItem(title: 'Missing Screws'),
    ChecklistItem(title: 'Thread Stand Condition'),
    ChecklistItem(title: 'Thread Path & Tension Post Condition'),
    ChecklistItem(title: 'Hook, Looper, Blade, Feeddog, Foot, Needle & ETC Conditions'),
    ChecklistItem(title: 'Monthly Check List Card Update'),
    ChecklistItem(title: 'Machine Condition'),
    ChecklistItem(title: 'Direct Air Line Solution Working Condition'),
    ChecklistItem(title: 'Auto Foot Lifting Working Condition'),
    ChecklistItem(title: 'Suction Unit Working Condition'),
    ChecklistItem(title: 'Dust Collector Conditions'),
    ChecklistItem(title: 'Chopper Working Condition'),
    ChecklistItem(title: 'Chain Cutter Working Condition'),
    ChecklistItem(title: 'Thread Wiper (Air) Working Conditions'),
    ChecklistItem(title: 'Synchronizer Cleaning & Working Condition'),
    ChecklistItem(title: 'DCV & Air Piston Condition'),
    ChecklistItem(title: 'Thread Trimmer Working Condition'),
    ChecklistItem(title: 'Head Supporter Availability'),
    ChecklistItem(title: 'Stand Rubber Bush'),
    ChecklistItem(title: 'Machine Head Rubber Bush'),
    ChecklistItem(title: 'Trimmer Spacer (F/L UBT)'),
    ChecklistItem(title: 'Bobbin Winder Condition'),
    ChecklistItem(title: 'Monthly Machine Card Update'),
    ChecklistItem(title: 'Oil Leak'),
    ChecklistItem(title: 'Idle Prevention Spring (Shuttle)'),
    ChecklistItem(title: 'Needle Sticker Update'),
    ChecklistItem(title: 'Timing Sticker Update'),
    ChecklistItem(title: 'Cooling Fan Update'),
    ChecklistItem(title: 'Caste Wheel Cleaning Maintenance'),
    ChecklistItem(title: 'Machine Wise Oil Level'),
    ChecklistItem(title: 'Machine Wise Oil Working Condition'),
    ChecklistItem(title: 'Cutter Unit Lubricated or Not'),
    ChecklistItem(title: 'Machine Are Greasing or Not'),
    ChecklistItem(title: 'Motor Box Cleaning Condition'),
    ChecklistItem(title: 'Visible Rust'),
    ChecklistItem(title: 'Critical Moving Parts Condition'),
    ChecklistItem(title: 'Thread Cam Area Cleaning Condition'),
    ChecklistItem(title: 'Machine Service Card Update'),
    ChecklistItem(title: 'Module Wise Stain Mark Update'),
    ChecklistItem(title: 'Safety'),
    ChecklistItem(title: 'Machine Wise Finger Guard Condition'),
    ChecklistItem(title: 'Machine Wise Eye Guard Condition'),
    ChecklistItem(title: 'Pully Guard & Belt Guard Condition'),
    ChecklistItem(title: 'Paddle Carpet & Stand Carpet Condition'),
    // ... Your checklist items
  ];




  Future<void> _sendChecklistData() async {

    // Create a list of checklist items with their checked and error statuses
    List<Map<String, dynamic>> checklistData = checklist.map((item) {
      return {
        'title': item.title,
        'isChecked': item.isChecked,
        'isError': item.isError,
      };
    }).toList();


    // Get the current date and time
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;

// Create a formatted string with year and month
    String formattedDate = '$year-$month';

    // Convert checklistData to a JSON string
    String jsonData = jsonEncode(checklistData);

    // Send the checklist data and date to the PHP backend
    final response = await http.post(
      Uri.parse('https://api.futuretechbay.com/brandixapi/save_checklist.php'),
      body: {
        'machine_number': widget.data,
        'line_number': widget.selectButtonValue.toString(), // Convert int to string
        'checklist_data': jsonData,
        'checklist_date': formattedDate,
      },
    );


    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      var uname = data['message'];

      if(uname == "Data inserted successfully.")
        {
          print(widget.selectButtonValue);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Status()),
          );
        }

      else{
        showErrorPopup(context, 'An error occurred. Please try again later.');
      }

      print(uname);
      // Successfully sent data to the server
      print('Data sent successfully ${response.statusCode}');
    } else {
      // Handle any errors here
      print('Failed to send data: ${response.statusCode}');
    }
  }


  void showErrorPopup(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Checklist'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Machine Number: ${widget.data}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),



          Expanded(
            child: ListView.builder(
              itemCount: checklist.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(checklist[index].title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: checklist[index].isChecked,
                            onChanged: (value) {
                              setState(() {
                                checklist[index].isChecked = value ?? false;
                              });
                            },
                          ),
                          Checkbox(
                            value: checklist[index].isError,
                            onChanged: (value) {
                              setState(() {
                                checklist[index].isError = value ?? false;
                              });
                            },
                            activeColor: Colors.red,
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (var item in checklist) {
                        item.isChecked = true;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the desired button color
                    fixedSize: Size(
                        double.infinity, 50), // Set the desired button height
                  ),
                  child: Text('Mark All Checked'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: _sendChecklistData, // Send data to the backend
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set the desired button color
                    fixedSize: Size(
                        double.infinity, 50), // Set the desired button height
                  ),
                  child: Text('Next'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
