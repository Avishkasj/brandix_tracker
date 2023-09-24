import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'CheckList.dart'; // Import your CheckList widget
import 'DrawerContent.dart'; // Import your DrawerContent widget

class SelectLine extends StatefulWidget {
  const SelectLine({Key? key}) : super(key: key);

  @override
  State<SelectLine> createState() => _SelectLineState();
}

class _SelectLineState extends State<SelectLine> {
  Future<void> _scanBarcode(int selectedButton) async {
    String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      "Back",// Remove the cancel button text
      true,
      ScanMode.DEFAULT,
    );


    if (barcodeResult == '-1') {
      // User canceled the scan, navigate back to SelectLine screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SelectLine()),
      );
    } else if (barcodeResult.isNotEmpty) {

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CheckList(data: barcodeResult,selectButtonValue:selectedButton)),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150), // Adjust the height as needed
        child: AppBar(
          flexibleSpace: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/hed.png'), // Replace with your background image path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 90, 70, 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'SELECT LINE',
                      // Replace with your desired text
                      style: TextStyle(
                        color: Colors.white, // Adjust text color as needed
                        fontSize: 28, // Adjust font size as needed
                        fontWeight: FontWeight.bold, // Adjust font weight as needed
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),



    ),
      drawer: Drawer(
        child: DrawerContent(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white38,
        ),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: 40,
                itemBuilder: (BuildContext context, int index) {
                  int buttonNumber = index + 1;
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 2,
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(10),
                      ),
                      onPressed: () => _scanBarcode(buttonNumber),
                      child: Text('$buttonNumber'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
