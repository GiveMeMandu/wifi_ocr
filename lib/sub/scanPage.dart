import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wifi_ocr/cameraModule.dart';
import 'package:wifi_connector/wifi_connector.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanPage();
}

class _ScanPage extends State<ScanPage> {
  final _ssidController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  String _data = "";

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
                      _ssidController.text = result['id'];
                      _passwordController.text = result['pw'];
                      // });
                    }
                  },
                ),
              ],
            ),
            QrImage(
              data: _data,
              version: QrVersions.auto,
              size: 300.0,
            ),
            Column(
              children: <Widget>[
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
                //wifi 연결 시도 후 성공 시 wifi클래스 정보 담은 QR생성 및 List에 추가
                _onConnectPressed();
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
    _data = "{ 'id':\'${ssid}\', 'pw':\'${password}\' }";
  }
}
