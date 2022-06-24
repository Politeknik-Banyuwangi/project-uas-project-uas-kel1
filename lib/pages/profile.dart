import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:projectuas/services/rest_api_service.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:projectuas/widgets/list_setting.dart';
import 'package:projectuas/widgets/spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name, username, email;
  bool _isLoading = true;

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var user = json.decode(prefs.getString('user') ?? '');
    setState(() {
      name = user['name'];
      username = user['username'];
      email = user['email'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading == true
          ? LoadingSpinner()
          : Scaffold(
              backgroundColor: kBackgroundColor,
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/background_home.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, bottom: 35, left: defaultMargin, right: defaultMargin),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/user.png'),
                              // radius: 20,
                              minRadius: 20,
                              maxRadius: 40,
                            ),
                          ),
                          Text(
                            '$name',
                            style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
                          ),
                          Text(
                            '$username | $email',
                            style: whiteTextStyle.copyWith(fontSize: 11, fontWeight: medium),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.3,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: defaultMargin,
                      ),
                      child: Column(
                        children: [
                          ListSetting(
                            onTap: () {},
                            title: 'Account',
                            icon: IconlyBold.profile,
                          ),
                          ListSetting(
                            onTap: () {},
                            title: 'Password',
                            icon: IconlyBold.unlock,
                          ),
                          ListSetting(
                            onTap: () {},
                            title: 'Tentang Aplikasi',
                            icon: IconlyBold.category,
                          ),
                          ListSetting(
                            onTap: () {
                              _logout();
                            },
                            title: 'Keluar',
                            icon: IconlyBold.logout,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void _logout() async {
    var res = await ApiService().getData('auth/logout');
    var body = json.decode(res.body);
    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('user');
      localStorage.remove('token');
      Navigator.pushNamed(context, '/login');
    }
  }
}
