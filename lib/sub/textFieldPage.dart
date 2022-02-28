import 'package:flutter/material.dart';
import 'package:wifi_connector/wifi_connector.dart';

class TextFieldPage extends StatefulWidget {
  TextFieldPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TextFieldPage();
}

class _TextFieldPage extends State<TextFieldPage> {
  final _ssidController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  var _isSucceed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wifi connector via text input'),
      ),
      body: Center(
        child: ListView(
          children: [
            _buildTextInput(
              'ssid',
              _ssidController,
            ),
            _buildTextInput(
              'password',
              _passwordController,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ElevatedButton(
                child: const Text(
                  'connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _onConnectPressed,
              ),
            ),
            Text(
              'Is wifi connected?: $_isSucceed',
              textAlign: TextAlign.center,
            )
          ],
        ),
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
    final ssid = _ssidController.text;
    final password = _passwordController.text;
    setState(() => _isSucceed = false);
    final isSucceed =
    await WifiConnector.connectToWifi(ssid: ssid, password: password);
    setState(() => _isSucceed = isSucceed);
  }
}
