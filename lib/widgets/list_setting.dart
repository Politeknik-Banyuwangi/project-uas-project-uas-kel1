import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iconly/iconly.dart';
import 'package:projectuas/themes/theme.dart';

class ListSetting extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ListSetting({required this.icon, required this.title, required this.onTap});

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 57,
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: kWhiteColor,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 30),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: defaultMargin, right: 8),
                  child: Icon(
                    icon,
                    size: 18,
                    color: kBlackColor,
                  ),
                ),
                Container(
                  child: Text(
                    title,
                    style: blackTextStyle.copyWith(
                      fontSize: 15,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                FeatherIcons.chevronRight,
                size: 20,
                color: kBlackColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
