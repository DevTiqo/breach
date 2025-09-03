import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Widget> icons;
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomTabBar({
    Key? key,
    required this.icons,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TabBar(
        dividerHeight: 0,
        indicator: BoxDecoration(),
        tabs: icons
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                Padding(
                  padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                  child: e,
                ),
              ),
            )
            .values
            .toList(),
        onTap: onTap,
      ),
    );
  }
}
