import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      _checkIfLoggedIn();
    });

    super.initState();
  }

  void _checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    if (token != null) {
      Navigator.pushNamed(context, 'page');
    } else {
      Navigator.pushNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Center(
                  child: Image.asset(
                    'assets/images/logo_light.png',
                    width: 180,
                    height: 100,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    'Absensi dengan menggunakan\nQRCode dan lokasi',
                    textAlign: TextAlign.center,
                    style: greyTextStyle1.copyWith(
                      fontSize: 13,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Center(
                  child: Text(
                    'Kelompok 1',
                    textAlign: TextAlign.center,
                    style: greyTextStyle1.copyWith(
                      fontSize: 12,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
