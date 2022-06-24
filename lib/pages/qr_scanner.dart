import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projectuas/services/rest_api_service.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:projectuas/pages/failed_scan.dart';
import 'package:projectuas/pages/success_scan.dart';
import 'package:projectuas/widgets/custom_button.dart';
import 'package:projectuas/widgets/spinner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    _getGeoLocationPosition();
    super.initState();
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> scanQR() async {
    String? qrScanRes;
    try {
      qrScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Batal', true, ScanMode.QR);
    } on PlatformException {
      qrScanRes = 'Failed to get QR code';
    }
    if (!mounted) return;
    setState(() {
      qrScanRes = qrScanRes;
      _isLoading = true;
    });
    if (qrScanRes != '-1') {
      await actionRequest(qrScanRes);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> actionRequest(String? qrCode) async {
    Position position = await _getGeoLocationPosition();
    var dataBody = {
      'qr_data': qrCode,
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
    var res = await ApiService().postData(dataBody, 'presences/store');
    var data = json.decode(res.body);
    setState(() {
      _isLoading = false;
    });
    if (data['success'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScanScreen(
            message: 'Kamu berhasil melakukan absensi ${data['data']['type'] == 'checkin' ? 'masuk' : 'pulang'} \npada tanggal ${data['data']['date']} pukul ${data['data']['time_in']}.',
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FailedScanScreen(
            message: data['message'],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading == true
          ? LoadingSpinner()
          : Scaffold(
              backgroundColor: kBackgroundColor,
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(defaultMargin),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13, bottom: 35),
                        child: Center(
                          child: Image.asset(
                            'assets/images/scan.png',
                            width: 253,
                          ),
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            'Yukk Absen!',
                            textAlign: TextAlign.center,
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Center(
                          child: Text(
                            'Scan QR Code yang ada pada website\ndan Wholaa kamu berhasil absen!',
                            textAlign: TextAlign.center,
                            style: greyTextStyle1.copyWith(fontSize: 13, fontWeight: medium),
                          ),
                        ),
                      ),
                      CustomButton(
                          text: 'Mulai Absen',
                          onPressed: () {
                            scanQR();
                          },
                          backgroundColor: kPrimaryColor),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
