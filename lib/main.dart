import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../wifiItem.dart';
import 'package:wifi_ocr/sub/scanPage.dart';
import 'package:wifi_ocr/sub/wifiListPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Wifi connector OCR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Wifi> wifiList = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    wifiList.add(Wifi(
        name: '우찬 자취방',
        ssid: 'Bourbon',
        pw: 'examplePW',
        imagePath: 'assets/QR_wiki.svg',
        isFiveGhz: false));
    wifiList.add(Wifi(
        name: '현수 자취방',
        ssid: 'Bourbon',
        pw: 'examplePW',
        imagePath: 'assets/QR_wiki.svg',
        isFiveGhz: false));
    wifiList.add(Wifi(
        name: '인영 자취방',
        ssid: 'Bourbon',
        pw: 'examplePW',
        imagePath: 'assets/QR_wiki.svg',
        isFiveGhz: false));
    wifiList.add(Wifi(
        name: '수연 자취방',
        ssid: 'Bourbon',
        pw: 'examplePW',
        imagePath: 'assets/QR_wiki.svg',
        isFiveGhz: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: TabBarView(
          children: <Widget>[
            WifiListPage(list: wifiList),
            ScanPage(),
          ],
          controller: controller,
        ),
        bottomNavigationBar: TabBar(
          tabs: <Tab>[
            Tab(
              icon: Icon(Icons.format_list_bulleted, color: Colors.blue),
            ),
            Tab(
              icon: Icon(Icons.qr_code_scanner, color: Colors.blue),
            ),
          ],
          controller: controller,
        ));
  }
}
