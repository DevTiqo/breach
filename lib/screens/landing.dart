import 'package:breach/screens/contentinterest.dart';
import 'package:breach/screens/createaccount.dart';
import 'package:breach/screens/home/navhome.dart';
import 'package:breach/screens/login.dart';
import 'package:breach/screens/welcome.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Landing extends ConsumerStatefulWidget {
  static String routeName = "/";
  const Landing({super.key});

  @override
  ConsumerState<Landing> createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset(ImageConst.breachlogo, width: 100),
        centerTitle: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Find',
                    style: AppTheme.jerseyText(
                      context,
                    ).copyWith(fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: ' Great ',
                        style: AppTheme.jerseyText(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Ideas',
                        style: AppTheme.jerseyText(
                          context,
                        ).copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Subscribe to your favourite creators and thinkers. Support work that matters',
                  style: AppTheme.mediumText(
                    context,
                  ).copyWith(fontWeight: FontWeight.w500),
                ),
                Image.asset(ImageConst.mascot, width: 300),
                SizedBox(height: 48),
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: AppTheme.bigText(context).copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: AppTheme.grayColor),
                      ),
                    ),

                    fixedSize: WidgetStatePropertyAll(
                      Size(MediaQuery.of(context).size.width - 100, 50),
                    ),
                    elevation: WidgetStatePropertyAll(0.0),
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((
                      Set<WidgetState> states,
                    ) {
                      if (states.contains(WidgetState.disabled)) {
                        return AppTheme.white;
                      }
                      return AppTheme.white;
                      // Use the component's default.
                    }),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    context.pushReplacement(Login.routeName);
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Join Breach",
                        textAlign: TextAlign.center,
                        style: AppTheme.bigText(context).copyWith(
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
                      Size(MediaQuery.of(context).size.width - 100, 50),
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
                    context.push(CreateAccount.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// Text('Categories')


 // Text('Footer')