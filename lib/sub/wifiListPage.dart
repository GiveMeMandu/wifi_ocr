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
                        GestureDetector(
                          child: Image.asset(
                            list[position].imagePath!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.contain,
                          ),
                          onTap: () async {
                            //QR만 확대
                            await showDialog(
                                context: context,
                                builder: (_) => imageDialog(list[position].name!, list[position].imagePath!, context)
                            );
                          },
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
                    //세부정보 alert
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

Widget imageDialog(text, path, context) {
  return Dialog(
    // backgroundColor: Colors.transparent,
    // elevation: 0,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            alignment: Alignment.topRight,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close_rounded),
            color: Colors.redAccent,
          ),
        ),
        Container(
          width: 350,
          height: 350,
          child: Image.asset(
            path,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ),
  );}
