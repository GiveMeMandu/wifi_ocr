import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanPage extends StatelessWidget {
  ScanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ElevatedButton(
                    child: Text('Scan Text/QR'),
                    onPressed: () {
                    },
                  ),
                  ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                    },
                  ),
                ],
              ),
              Image.asset('assets/QR_wiki.svg', width: 300,),
              Text('SSID : '),
              Text('PW   :'),
              ElevatedButton(
                child: Text('Connect & Save'),
                onPressed: () {
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}
