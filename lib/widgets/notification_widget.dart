import 'package:another_flushbar/flushbar.dart';
import 'package:breach/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

enum NotificationStatus { regular, warning, error, success }

callnotification(
  BuildContext context,
  NotificationStatus notificationStatus,
  String message, {
  Widget? leadingwidget,
}) {
  Flushbar(
    messageText: Text(
      message,
      style: AppTheme.normalText(context).copyWith(
        color: notificationStatus == NotificationStatus.error
            ? AppTheme.errorColor
            : notificationStatus == NotificationStatus.warning
            ? AppTheme.warningColor
            : notificationStatus == NotificationStatus.success
            ? AppTheme.successColor
            : AppTheme.primaryColor,
        fontWeight: FontWeight.w700,
      ),
    ),
    margin: EdgeInsets.all(16),
    borderRadius: BorderRadius.circular(8),
    icon: Icon(
      notificationStatus == NotificationStatus.error
          ? Icons.cancel
          : notificationStatus == NotificationStatus.warning
          ? Icons.warning
          : notificationStatus == NotificationStatus.success
          ? Icons.check_rounded
          : Icons.info_outline,
      size: 20.0,
      color: notificationStatus == NotificationStatus.error
          ? AppTheme.errorColor
          : notificationStatus == NotificationStatus.warning
          ? AppTheme.warningColor
          : notificationStatus == NotificationStatus.success
          ? AppTheme.successColor
          : AppTheme.primaryColor,
    ),
    backgroundColor: notificationStatus == NotificationStatus.error
        ? AppTheme.errorLight
        : notificationStatus == NotificationStatus.warning
        ? AppTheme.warningLight
        : notificationStatus == NotificationStatus.success
        ? AppTheme.successLight
        : AppTheme.primaryLight,
    flushbarPosition: FlushbarPosition.BOTTOM,
    duration: Duration(seconds: 3),
    // leftBarIndicatorColor: Colors.blue[300],
  ).show(context);

  // // Custom Toast Position
  // fToast!.showToast(
  //     child: toast,
  //     toastDuration: Duration(seconds: 2),
  //     positionedToastBuilder: (context, child) {
  //       return Positioned(
  //         child: child,
  //         top: 16.0,
  //         left: 16.0,
  //       );
  //     });
}
