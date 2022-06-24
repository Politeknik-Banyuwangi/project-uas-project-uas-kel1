import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:projectuas/themes/theme.dart';

class ListPresence extends StatelessWidget {
  final bool isCheckin;
  final String presenceDate;
  final String presenceTime;
  final VoidCallback onTap;
  // final String latitude;
  // final String longitude;

  ListPresence({this.isCheckin = true, required this.presenceDate, required this.presenceTime, required this.onTap});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 65,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 30),
          ],
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin),
              child: Icon(
                IconlyBold.scan,
                size: 35,
                color: kPrimaryColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Absensi ${isCheckin == true ? 'Datang' : 'Pulang'}',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'Tanggal ${presenceDate} Pukul ${presenceTime}',
                    style: blackTextStyle.copyWith(
                      fontSize: 9,
                      fontWeight: regular,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
