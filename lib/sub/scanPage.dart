import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanPage extends StatelessWidget {
  ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("카메라"),
        ),
      ),
    );
  }
}
