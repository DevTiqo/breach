import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final Color? progressColor;
  const CircularProgress({Key? key, this.progressColor = Colors.white})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(color: progressColor),
    );
  }
}
