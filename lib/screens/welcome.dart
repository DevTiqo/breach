import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Welcome extends ConsumerStatefulWidget {
  static String routeName = '/welcome';
  const Welcome({super.key});

  @override
  ConsumerState<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends ConsumerState<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(ImageConst.breachlogo, width: 100),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 84),
              Stack(
                children: [
                  Container(
                    width: 400,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Image.asset(ImageConst.beaver, width: 300),
                  ),
                  Positioned(
                    left: 0,
                    top: 30,
                    child: Image.asset(ImageConst.message, width: 200),
                  ),
                ],
              ),

              SizedBox(height: 36),
              Text(
                'Welcome to Breach 🥳',
                style: AppTheme.extralargeText(
                  context,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 24),
              Text(
                'Just a few quick questions to help personalise your Breach experience. Are you ready?',
                textAlign: TextAlign.center,
                style: AppTheme.mediumText(
                  context,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 48),
              Center(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Let's Begin",
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
                      return AppTheme.black;
                    }),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: () async {
                    // await userlogin(email, password);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
