import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectuas/services/rest_api_service.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:projectuas/pages/presence_detail.dart';
import 'package:projectuas/widgets/list_presence.dart';
import 'package:projectuas/widgets/overview_card.dart';
import 'package:projectuas/widgets/spinner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _name;
  String? _attendace;
  String? _absence;
  String? _currentMonth;
  List<dynamic>? _listPresences;
  bool _isLoading = true;

  @override
  void initState() {
    _getUserData();
    _getCountPresence();
    _setCurrentMonth();
    _getPresences();
    super.initState();
  }

  _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    var user = json.decode(prefs.getString('user') ?? '');
    setState(() {
      _name = user['name'];
    });
  }

  _setCurrentMonth() {
    var now = DateTime.now().toString();
    final DateFormat formater = DateFormat('MMM yyyy');
    final String formated = formater.format(DateTime.parse(now));
    setState(() {
      _currentMonth = formated;
    });
  }

  _getPresences() async {
    final response = await ApiService().getData('presences/get-data?limit=10');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _listPresences = data['data'];
        _isLoading = false;
      });
    }
  }

  _getCountPresence() async {
    var res = await ApiService().getData('presences/count');
    var data = json.decode(res.body);
    if (data['success'] == true) {
      setState(() {
        _attendace = data['data']['attendance'].toString();
        _absence = data['data']['absence'].toString();
      });
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
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04, bottom: 35, left: defaultMargin, right: defaultMargin),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello',
                                style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
                              ),
                              Text(
                                'Welcome back, $_name!',
                                style: whiteTextStyle.copyWith(fontSize: 11, fontWeight: medium),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/user.png'),
                              radius: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    OverViewCardWidget(
                      countPresent: '$_attendace',
                      countAbsent: '$_absence',
                      month: '$_currentMonth',
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.38,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: defaultMargin,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'Riwayat Presensi',
                                  style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
                                ),
                              ),
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, '/presence-history');
                                  },
                                  child: Text(
                                    'Lihat Semua',
                                    style: blackTextStyle.copyWith(fontSize: 10, fontWeight: regular),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          for (var item in _listPresences ?? [])
                            ListPresence(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PresenceDetailScreen(presenceID: item['id'].toString()),
                                  ),
                                );
                              },
                              isCheckin: item['type'] == 'checkin' ? true : false,
                              presenceDate: item['date'],
                              presenceTime: item['time_in'],
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
}
