import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Wifi {
  static List<Wifi> wifiList = List.empty(growable: true);
  String? imagePath;
  String? name;
  String? ssid;
  String? pw;
  bool? isFiveGhz = false;
  bool? isConnected = false;

  Wifi(
      {required this.name,
      required this.ssid,
      required this.pw,
      this.imagePath,
      this.isFiveGhz,
      this.isConnected});

  Wifi.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        ssid = json['ssid'],
        pw = json['pw'],
        imagePath = json['imagePath'],
        isFiveGhz = json['isFiveGhz'],
        isConnected = json['isConnected'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'ssid': ssid,
        'pw': pw,
        'imagePath': imagePath,
        'isFiveGhz': isFiveGhz,
        'isConnected': isConnected,
      };

  static void addWifi(
      String name, String ssid, String pw, String imagePath, bool isFiveGhz) {
    wifiList.add(Wifi(
        name: name,
        ssid: ssid,
        pw: pw,
        imagePath: imagePath,
        isFiveGhz: isFiveGhz,
        isConnected: false));
    Wifi.saveList();
  }

  static void saveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'wifiList', wifiList.map((wifi) => jsonEncode(wifi.toJson())).toList());
  }
}
