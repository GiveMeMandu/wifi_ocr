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
                        //Image,
                        Text(list[position].name!),
                        Row(
                          children: <Widget>[
                            Text(list[position].ssid!),
                            //Text(list[position].band!),
                          ]
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    //QR 확대 + 하단에 세부정보
                  },
                  onLongPress: () {
                    //리스트뷰 내 카드 위치 편집
                  },
                );
              },
              itemCount: list.length),
        ),
      ),
    );
  }
}
