import 'package:flutter/material.dart';
import '../wifiItem.dart';

class WifiListPage extends StatefulWidget {
  final List<Wifi> list; // wifi List 선언
  WifiListPage({Key? key, required this.list}) : super(key: key);

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
                    child: Image.asset(
                      widget.list[position].imagePath!,
                      fit: BoxFit.contain,
                    ),
                    onTap: () async {
                      //QR만 확대
                      await showDialog(
                          context: context,
                          builder: (_) => qrDialog(
                              widget.list[position].imagePath!, context));
                    },
                  ),
                  title: GestureDetector(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            widget.list[position].name!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Column(children: <Widget>[
                            Text(
                              "SSID : " + widget.list[position].ssid!,
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Bands : 2.4Ghz", //getBandType()
                              style: TextStyle(fontSize: 12),
                            ),
                          ]),
                        ]),
                    onTap: () async {
                      //세부정보 표시
                      await showDialog(
                          context: context,
                          builder: (_) =>
                              detailDialog(widget.list[position], context));
                    },
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
              itemCount: widget.list.length),
        ),
      ),
    );
  }

  void _updateItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final item = widget.list.removeAt(oldIndex);
    widget.list.insert(newIndex, item);
  }
}

Widget qrDialog(path, context) {
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
