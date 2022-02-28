import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wifi_ocr/cameraModule.dart';
import 'package:wifi_connector/wifi_connector.dart';

import '../wifiItem.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanPage();
}

class _ScanPage extends State<ScanPage> {
  final _nameController = TextEditingController(text: '');
  final _ssidController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  QrImage? image;

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
                  onPressed: () async {
                    final cameras = await availableCameras();
                    final firstCamera = cameras.first;

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TakePictureScreen(
                          camera: firstCamera,
                        ),
                      ),
                    );

                    if (result != null) {
                      // Future.delayed(Duration.zero, () {
                      _nameController.text = result['id'].toString();
                      _ssidController.text = result['id'].toString();
                      _passwordController.text = result['pw'].toString();
                      // });
                    }
                  },
                ),
              ],
            ),
            QrImage(
              data:
                  "WIFI:S:${_ssidController.text};T:WPA;P:${_passwordController.text};;",
              version: QrVersions.auto,
              size: 200.0,
            ),
            Column(
              children: <Widget>[
                _buildTextInput(
                  'name',
                  _nameController,
                ),
                _buildTextInput(
                  'ssid',
                  _ssidController,
                ),
                _buildTextInput(
                  'password',
                  _passwordController,
                ),
              ],
            ),
            ElevatedButton(
              child: Text('Connect & Save'),
              onPressed: () {
                Wifi.addWifi(_nameController.text, _ssidController.text,
                    _passwordController.text, 'assets/QR_wiki.svg', false);
                _ssidController.text = '';
                _passwordController.text = '';
                //wifi 연결 시도 후 성공 시 wifi클래스 정보 담은 QR생성 및 List에 추가
              },
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildTextInput(String title, TextEditingController controller) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Container(width: 80.0, child: Text(title)),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: TextField(
              controller: controller,
              onChanged: (value) => setState(
                () {},
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _onConnectPressed() async {
    final ssid = _ssidController.text; //maxLength: 32
    final password = _passwordController.text; //minLength: 8, maxLength: 16(WEP)/63(WPA1,2)
    await WifiConnector.connectToWifi(ssid: ssid, password: password);
  }
}
