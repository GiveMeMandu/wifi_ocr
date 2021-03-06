import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:wifi_connector/wifi_connector.dart';

import '../wifiItem.dart';

class WifiListPage extends StatefulWidget {
  WifiListPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WifiListPage();
}

class _WifiListPage extends State<WifiListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: ReorderableListView.builder(
              itemBuilder: (context, position) {
                return ListTile(
                  key: Key('$position'),
                  leading: GestureDetector(
                    child: QrImage(
                      data:
                          "WIFI:S:${Wifi.wifiList[position].ssid};T:WPA;P:${Wifi.wifiList[position].pw};;",
                      version: QrVersions.auto,
                      // size: 200.0,
                      // fit: BoxFit.contain,
                    ),
                    onTap: () async {
                      //QR만 확대
                      await showDialog(
                          context: context,
                          builder: (_) => qrDialog(
                              "WIFI:S:${Wifi.wifiList[position].ssid};T:WPA;P:${Wifi.wifiList[position].pw};;",
                              context));
                    },
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          Wifi.wifiList[position].name!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        onTap: () async {
                          //wifi 연결
                          _onNamePressed(position);
                        },
                        onLongPress: () {
                          //삭제 여부 알러드다이어그램
                          AlertDialog dialog = AlertDialog(
                            title: Text('목록에서 제거하기'),
                            content: Text(
                              '${Wifi.wifiList[position].name} 을/를 목록에서 제거하시겠습니까?',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    Wifi.wifiList.removeAt(position);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text('예'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  print(position);
                                  Navigator.of(context).pop();
                                },
                                child: Text('아니요'),
                              ),
                            ],
                          );
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => dialog);
                        },
                      ),
                      GestureDetector(
                        child: Column(children: <Widget>[
                          Text(
                            "SSID : " + Wifi.wifiList[position].ssid!,
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            "Bands : 2.4Ghz", //getBandType()
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                        onTap: () async {
                          //세부정보 표시
                          await showDialog(
                              context: context,
                              builder: (_) => detailDialog(
                                  Wifi.wifiList[position], context));
                        },
                      ),
                    ],
                  ),
                  trailing: ReorderableDragStartListener(
                    index: position,
                    child: const Icon(Icons.drag_handle),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  _updateItems(oldIndex, newIndex);
                });
              },
              itemCount: Wifi.wifiList.length),
        ),
      ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = Wifi.wifiList.removeAt(oldIndex);
    Wifi.wifiList.insert(newIndex, item);

    Wifi.saveList();
  }
}

Widget qrDialog(data, context) {
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
          child: QrImage(
            data: data,
            version: QrVersions.auto,
            // size: 200.0,
            // fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}

Widget detailDialog(wifi, context) {
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
            child: Column(
              children: <Widget>[
                Text('Name: ${wifi.name}'),
                Text('SSID: ${wifi.ssid}'),
                Text('PW  : ${wifi.pw}'),
                // 이후 추가되는 속성들 추가해주세요
              ],
            )),
      ],
    ),
  );
}

Future<void> _onNamePressed(position) async {
  final ssid = Wifi.wifiList[position].ssid; //maxLength: 32
  final password = Wifi.wifiList[position].pw; //minLength: 8, maxLength: 16(WEP)/63(WPA1,2)
  print(ssid);
  await WifiConnector.connectToWifi(ssid: ssid!, password: password);
}
