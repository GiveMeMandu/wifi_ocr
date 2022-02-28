import 'package:flutter/material.dart';
import '../wifiItem.dart';

class WifiListPage extends StatelessWidget {
  final List<Wifi> list; // wifi List 선언
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
                        Image.asset(
                          list[position].imagePath!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.contain,
                        ),
                        Text(list[position].name!,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                        Column(
                          children: <Widget>[
                            Text("SSID : " + list[position].ssid!,
                            style: TextStyle(fontSize: 12),),
                            Text("Bands : 2.4Ghz",//getBandType()
                              style: TextStyle(fontSize: 12),),
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
