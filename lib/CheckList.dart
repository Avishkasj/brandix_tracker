import 'package:flutter/material.dart';

import 'Scanner.dart';
import 'SlectLine.dart';

class ChecklistItem {
  final String title;
  bool isChecked;
  bool isError;

  ChecklistItem({required this.title, this.isChecked = false, this.isError = false});
}


class CheckList extends StatefulWidget {
  final String data;

  const CheckList({required this.data, Key? key}) : super(key: key);
  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  List<ChecklistItem> checklist = [
    ChecklistItem(title: 'Machine Wise Air Regulator Arrangement'),
    ChecklistItem(title: 'Machine Wise & Module Air Leak'),
    ChecklistItem(title: 'Machine Wise wire & Tube Arrangement'),
    ChecklistItem(title: 'Machine Table Top Cleaning Condition'),
    ChecklistItem(title: 'Machine Table Top Sticker arrangement'),
    ChecklistItem(title: 'Blue Sheet Arrangement'),
    ChecklistItem(title: 'Machine Table Top Condition [damage or Not]'),
    ChecklistItem(title: 'Machine Head Cleaning Condition'),
    ChecklistItem(title: 'Machine Head Paint Condition'),
    ChecklistItem(title: 'Missing Screws'),
    ChecklistItem(title: 'Thread Stand Condition'),
    ChecklistItem(title: 'Thread Path & Tension Post Condition'),
    ChecklistItem(title: 'Hook, Looper, Blade, Feeddog, Foot, Needle & ETC Conditions'),
    ChecklistItem(title: 'Monthly check list Card Update'),
    ChecklistItem(title: 'Machine Condition'),
    ChecklistItem(title: 'Direct Air Line Solution Working Condition'),
    ChecklistItem(title: 'Auto Foot Lifting Working Condition'),
    ChecklistItem(title: 'Suction Unit Working Condition'),
    ChecklistItem(title: 'Dust Collector Conditions'),
    ChecklistItem(title: 'Chopper Working Condition'),
    ChecklistItem(title: 'Chain Cutter Working Condition'),
    ChecklistItem(title: 'Thread Wiper [Air] Working Conditions'),
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
    ChecklistItem(title: 'Caster Wheel Cleaning'),
    ChecklistItem(title: 'Maintenance'),
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
    ChecklistItem(title: 'Pulley Guard & Belt Guard Condition'),
    ChecklistItem(title: 'Paddle Carpet & Stand Carpet Condition')

    // ... Your checklist items
  ];

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
                    fixedSize: Size(double.infinity, 50), // Set the desired button height
                  ),
                  child: Text('Mark All Checked'),
                ),
              ),

              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen or perform other actions here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Set the desired button color
                    fixedSize: Size(double.infinity, 50), // Set the desired button height
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
