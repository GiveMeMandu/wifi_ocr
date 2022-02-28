import 'package:flutter/material.dart';

class Wifi {
  String? ssid;
  String? pw;
  bool? isConnected = false;

  Wifi(
      { required this.ssid,
        required this.pw,
        this.isConnected});
}