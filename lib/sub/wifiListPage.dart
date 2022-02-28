import 'package:flutter/material.dart';
import '../wifiItem.dart';

class WifiListPage extends StatelessWidget {
  final List<Wifi> list; // Animal List 선언
  WifiListPage({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ListView.builder(
              itemBuilder: (context, position) {
                return GestureDetector(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Text(list[position].ssid!),
                      ],
                    ),
                  ),
                  onTap: () {
                    AlertDialog dialog = AlertDialog(
                      /*
                      content: Text(
                        '이 동물은 ${list[position].kind} 입니다',
                        style: TextStyle(fontSize: 30.0),
                      ),
                       */
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => dialog);
                  },
                  onLongPress: () {
                    list.removeAt(position);
                  },
                );
              },
              itemCount: list.length),
        ),
      ),
    );
  }
}
