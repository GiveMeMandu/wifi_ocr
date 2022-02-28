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
                      //카메라 페이지로 이동
                    },
                  ),
                  ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      //편집가능한 텍스트 필드 있는 페이지로 이동
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
                  //wifi 연결 시도 후 성공 시 wifi클래스 정보 담은 QR생성 및 List에 추가
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}
