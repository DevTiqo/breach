import 'package:flutter/material.dart';

class DrawerNavigationDetails extends StatelessWidget {
  Widget icon;
  Widget detail;
  Widget? description;

  TextStyle? styles;

  DrawerNavigationDetails({
    required this.icon,
    required this.detail,
    this.description,
    this.styles = const TextStyle(
        fontSize: 16,
        fontFamily: 'Alexandria',
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal),
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Row(
      children: [
        icon,
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              detail,
              description ?? SizedBox(),
            ],
          ),
        ),
      ],
    ));
  }
}
