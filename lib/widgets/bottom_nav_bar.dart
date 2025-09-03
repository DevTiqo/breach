import 'package:flutter/material.dart';

class ButtomNavBar extends StatefulWidget {
  final Widget child;

  const ButtomNavBar({Key? key, required this.child}) : super(key: key);

  @override
  State<ButtomNavBar> createState() => _ButtomNavBarState();
}

class _ButtomNavBarState extends State<ButtomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [SizedBox(height: 12), widget.child, SizedBox(height: 20)],
        ),
      ),
    );
  }
}
