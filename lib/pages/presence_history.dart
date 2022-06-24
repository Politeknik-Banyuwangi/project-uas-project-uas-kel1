import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projectuas/services/rest_api_service.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:projectuas/pages/presence_detail.dart';
import 'package:projectuas/widgets/list_presence.dart';
import 'package:projectuas/widgets/spinner.dart';

class PresenceHistoryScreen extends StatefulWidget {
  const PresenceHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PresenceHistoryScreen> createState() => _PresenceHistoryScreenState();
}

class _PresenceHistoryScreenState extends State<PresenceHistoryScreen> {
  bool _isLoading = true;
  List<dynamic>? listPresences;

  @override
  void initState() {
    _getPresences();
    super.initState();
  }

  _getPresences() async {
    final response = await ApiService().getData('presences/get-data');
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        listPresences = data['data'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: _isLoading == true
          ? LoadingSpinner()
          : Scaffold(
              appBar: AppBar(
                title: Text('Riwayat Absensi'),
                backgroundColor: kPrimaryColor,
              ),
              backgroundColor: kBackgroundColor,
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: defaultMargin,
                        right: defaultMargin,
                        bottom: defaultMargin,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          for (var item in listPresences ?? [])
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
