import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:projectuas/services/rest_api_service.dart';
import 'package:projectuas/themes/theme.dart';
import 'package:projectuas/widgets/item_detail.dart';
import 'package:projectuas/widgets/spinner.dart';

class PresenceDetailScreen extends StatefulWidget {
  String presenceID;

  PresenceDetailScreen({Key? key, required this.presenceID}) : super(key: key);

  @override
  State<PresenceDetailScreen> createState() => _PresenceDetailScreenState();
}

class _PresenceDetailScreenState extends State<PresenceDetailScreen> {
  String? _date, _shift, _type, _timeIn, _location, _description;
  bool _isLoading = true;

  @override
  void initState() {
    _getPresenceDetail();
    super.initState();
  }

  _getPresenceDetail() async {
    final response = await ApiService().getData('presences/get-data/${widget.presenceID}');
    final data = json.decode(response.body);
    print(data['data']);
    if (data['success'] == true) {
      setState(() {
        _date = data['data']['date'];
        _shift = data['data']['shift'];
        _type = data['data']['type'];
        _timeIn = data['data']['time_in'];
        _location = data['data']['location'];
        _description = data['data']['description'];
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
              backgroundColor: kBackgroundColor,
              appBar: AppBar(
                title: Text('Detail Absensi'),
                backgroundColor: kPrimaryColor,
              ),
              body: Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
                      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                        ],
                      ),
                      child: Column(
                        children: [
                          ItemDetailPresence(
                            icon: IconlyLight.calendar,
                            title: 'Tanggal',
                            value: _date ?? '-',
                          ),
                          ItemDetailPresence(
                            icon: IconlyLight.login,
                            title: 'Shift',
                            value: _shift ?? '-',
                          ),
                          ItemDetailPresence(
                            icon: IconlyLight.info_circle,
                            title: 'Jenis Absen',
                            value: _type ?? '-',
                          ),
                          ItemDetailPresence(
                            icon: IconlyLight.time_circle,
                            title: 'Jam',
                            value: _timeIn ?? '-',
                          ),
                          ItemDetailPresence(
                            icon: IconlyLight.location,
                            title: 'Lokasi',
                            value: _location ?? '-',
                          ),
                          ItemDetailPresence(
                            icon: IconlyLight.document,
                            title: 'Keterangan',
                            value: _description ?? '-',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
