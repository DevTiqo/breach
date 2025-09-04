import 'dart:io';

import 'package:breach/modules/livesockets.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:breach/screens/home/bottombarhome.dart';
import 'package:breach/screens/home/drawerhome.dart';
import 'package:breach/screens/home/streams.dart';
import 'package:breach/screens/home/toppicks.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:breach/widgets/bottom_nav_bar.dart';
import 'package:breach/widgets/home_screen_drawer_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavHome extends ConsumerStatefulWidget {
  static String routeName = '/home';
  @override
  _NavHomeState createState() => _NavHomeState();
}

class _NavHomeState extends ConsumerState<NavHome> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool warningupdate = false;

  late dynamic getlocals;
  callDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    final List<Widget> _screens = [
      TopPicks(
        // key: ValueKey(ref.watch(authNotifierProvider).user.id),
        callDrawer: callDrawer,
      ),
      Streams(
        // key: ValueKey(ref.watch(authNotifierProvider).user.id),
        callDrawer: callDrawer,
      ),
    ];

    final List<Widget> _icons = [
      Tab(
        icon: Icon(
          Icons.star,
          color: 0 == _selectedIndex
              ? AppTheme.primaryColor
              : AppTheme.greyColor.withAlpha(150),
          size: 32.0,
        ),
        text: 'Top Picks',
      ),
      Tab(
        icon: Icon(
          Icons.flash_on,
          color: 1 == _selectedIndex
              ? AppTheme.primaryColor
              : AppTheme.greyColor.withAlpha(150),
          size: 32.0,
        ),
        text: 'Streams',
      ),
    ];

    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      // key: ValueKey(ref.watch(authNotifierProvider).user.handle),
      length: _icons.length,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: AppDrawer(
          // authNotifier: authNotifier,
        ),

        body: IndexedStack(index: _selectedIndex, children: _screens),
        bottomNavigationBar: CustomTabBar(
          icons: _icons,
          selectedIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
            FocusScope.of(context).unfocus();

            debugPrint('moving');
          },
        ),
      ),
    );
  }
}
