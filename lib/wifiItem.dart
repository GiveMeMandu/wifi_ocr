class Wifi {
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
}
