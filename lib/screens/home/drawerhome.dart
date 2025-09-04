import 'package:breach/notifiers/providers.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:breach/widgets/bottom_nav_bar.dart';
import 'package:breach/widgets/home_screen_drawer_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AppDrawer extends ConsumerStatefulWidget {
  AppDrawer({Key? key}) : super(key: key);

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    const EdgeInsets defaultPadding = EdgeInsets.symmetric(
      horizontal: 20.0,
      vertical: 5,
    );

    return Drawer(
      width: MediaQuery.of(context).size.width - 40,
      child: Scaffold(
        bottomNavigationBar: ButtomNavBar(
          child: Consumer(
            builder: (context, ref, child) => Padding(
              padding: defaultPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    // title: Text("Dark Mode"),

                    // highlightColor: AppTheme.primaryColor.withOpacity(0.3),
                    icon: !ref.watch(themeNotifier).darkTheme
                        ? Icon(Icons.light_mode)
                        : Icon(Icons.dark_mode),
                    onPressed: () {
                      ref.watch(themeNotifier).toggleTheme();
                    },
                    // value: ref.watch(themeNotifier).darkTheme,
                  ),
                  IconButton(
                    icon: Icon(Icons.logout, color: AppTheme.errorColor),
                    onPressed: () async {
                      await ref
                          .watch(authNotifierProvider.notifier)
                          .logout(ref.read(authNotifierProvider).user!);
                    },
                    // value: ref.watch(themeNotifier).darkTheme,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48),
                Padding(
                  padding: defaultPadding,
                  child: Image.asset(ImageConst.breachlogo, width: 100),
                ),

                SizedBox(height: 36),
                Center(
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        WebsafeSvg.asset(
                          ImageConst.edit,
                          fit: BoxFit.fitWidth,
                          colorFilter: ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                          width: 24,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Start writing",
                          textAlign: TextAlign.center,
                          style: AppTheme.mediumText(context).copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      fixedSize: WidgetStatePropertyAll(
                        Size(MediaQuery.of(context).size.width - 80, 50),
                      ),
                      elevation: WidgetStatePropertyAll(0.0),
                      backgroundColor: WidgetStateProperty.resolveWith<Color>((
                        Set<WidgetState> states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return AppTheme.grayColor;
                        }
                        return AppTheme.primaryColor;
                        // Use the component's default.
                      }),
                      textStyle: WidgetStatePropertyAll(
                        TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      // context.push(CreateAccount.routeName);
                    },
                  ),
                ),
                SizedBox(height: 36),
                ListTile(
                  contentPadding: defaultPadding,
                  onTap: () {
                    context.pop();
                  },
                  title: DrawerNavigationDetails(
                    icon: WebsafeSvg.asset(
                      ImageConst.home,
                      fit: BoxFit.fitWidth,
                      colorFilter: ColorFilter.mode(
                        AppTheme.grayColor,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                    ),
                    detail: Text(
                      "Home",
                      style: AppTheme.mediumText(context).copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.greyColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                ListTile(
                  contentPadding: defaultPadding,
                  onTap: () {
                    context.pop();
                  },
                  title: DrawerNavigationDetails(
                    icon: WebsafeSvg.asset(
                      ImageConst.grid,
                      fit: BoxFit.fitWidth,
                      colorFilter: ColorFilter.mode(
                        AppTheme.grayColor,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                    ),
                    detail: Text(
                      "Dashboard",
                      style: AppTheme.mediumText(context).copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.greyColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  contentPadding: defaultPadding,
                  onTap: () {
                    context.pop();
                  },
                  title: DrawerNavigationDetails(
                    icon: WebsafeSvg.asset(
                      ImageConst.messageIcon,
                      fit: BoxFit.fitWidth,
                      colorFilter: ColorFilter.mode(
                        AppTheme.grayColor,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                    ),
                    detail: Text(
                      "Publications",
                      style: AppTheme.mediumText(context).copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppTheme.greyColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 140),

                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
