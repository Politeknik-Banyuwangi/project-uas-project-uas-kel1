import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:projectuas/themes/theme.dart';

class OverViewCardWidget extends StatelessWidget {
  final String countPresent;
  final String countAbsent;
  final String month;

  OverViewCardWidget({required this.countPresent, required this.countAbsent, required this.month});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15, left: defaultMargin, right: defaultMargin),
      height: 142,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  'Ringkasan',
                  style: blackTextStyle.copyWith(fontSize: 14, fontWeight: semiBold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Text(
                  month,
                  style: greyTextStyle3.copyWith(fontSize: 10, fontWeight: regular),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      FeatherIcons.checkCircle,
                      color: kPrimaryColor,
                      size: 34,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${countPresent} Hadir',
                      style: blackTextStyle.copyWith(fontSize: 11, fontWeight: medium),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 40,
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      FeatherIcons.xCircle,
                      color: kPrimaryColor,
                      size: 34,
                    ),
                  ),
                  Container(
                    child: Text(
                      '${countAbsent} Tidak hadir',
                      style: blackTextStyle.copyWith(fontSize: 11, fontWeight: medium),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
