import 'package:flutter/material.dart';
import 'package:projectuas/themes/theme.dart';

class ItemDetailPresence extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;

  ItemDetailPresence({Key? key, required this.icon, required this.title, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Icon(
                icon,
                color: kBlackColor,
                size: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5, top: 10),
              child: Text(
                title,
                style: blackTextStyle.copyWith(),
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(right: 15, top: 10),
          child: Text(
            value!,
            style: greyTextStyle1.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
