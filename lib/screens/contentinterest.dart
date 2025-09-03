import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentInterest extends ConsumerStatefulWidget {
  static String routeName = '/contentinterest';
  const ContentInterest({super.key});

  @override
  ConsumerState<ContentInterest> createState() => _ContentInterestState();
}

class _ContentInterestState extends ConsumerState<ContentInterest> {
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
              Image.asset(ImageConst.beavercircle, width: 120),

              SizedBox(height: 36),
              Text(
                'What are your interests?',
                style: AppTheme.largeText(
                  context,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12),
              Text(
                'Select your interests and I\'ll recommend some series I\'m certain you\'ll enjoy!',
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
                        "Next",
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
              SizedBox(height: 24),
              TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  elevation: WidgetStatePropertyAll(0.0),
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((
                    Set<WidgetState> states,
                  ) {
                    return Colors.transparent;
                  }),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(color: Colors.white),
                  ),
                ),
                child: Text(
                  "Skip for now",
                  style: TextStyle(color: AppTheme.greyColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
