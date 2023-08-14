import 'package:flutter/material.dart';

import 'CheckList.dart';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String _barcodeResult = 'Scan a barcode';

  Future<void> _scanBarcode() async {
    String barcodeResult = await Future.delayed(Duration(seconds: 2), () {
      return "ScannedDataExample"; // Simulating barcode scan result
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CheckList(data: barcodeResult)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _barcodeResult,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Scan Barcode'),
            ),
          ],
        ),
      ),
    );
  }
}