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
  late WebSocket socket;

  late dynamic getlocals;
  callDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    socket = ref.read(socketProvider);

    connectToServer();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref
    //       .read(authNotifierProvider.notifier)
    //       .getUser(id_user: ref.read(authNotifierProvider).user.id)
    //       .then((s) async {
    //         if (s.ok) {
    //           ref.read(postNotifierProvider.notifier).setLocalPosts();

    //           ref.read(sportNotifierProvider.notifier).getSports();

    //           if (ref.read(authNotifierProvider).user.usertype ==
    //               UserType.Personal) {
    //             ref
    //                 .read(authNotifierProvider.notifier)
    //                 .getOrganisations(ref.read(authNotifierProvider).user.id);
    //           } else if (ref.read(authNotifierProvider).user.usertype ==
    //               UserType.Organisation) {
    //             ref
    //                 .read(authNotifierProvider.notifier)
    //                 .getOrganisationManagers(
    //                   ref.read(authNotifierProvider).user.id,
    //                 );
    //           }
    //           warningupdate = await warningUpdate();

    //           if (warningupdate) displaySheet(context);
    //         }
    //       });
    // });
  }

  @override
  void dispose() {
    socket.close();
    super.dispose();
  }

  connectToServer() async {
    if (socket.channel == null) {
      var connected = await socket.connect();
      debugPrint(connected.toString());
    }

    socket.channel?.emit("identity", 'ref.read(authNotifierProvider).user.id');
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
          color: 0 == _selectedIndex ? AppTheme.primaryColor : Colors.grey,
          size: 32.0,
        ),
        text: 'Top Picks',
      ),
      Tab(
        icon: Icon(
          Icons.flash_on,
          color: 1 == _selectedIndex ? AppTheme.primaryColor : Colors.grey,
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
