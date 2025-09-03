import 'package:breach/notifiers/providers.dart';
import 'package:breach/screens/createaccount.dart';
import 'package:breach/theme/palette.dart';
import 'package:breach/utils/imageconsts.dart';
import 'package:breach/widgets/circularprogress.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Login extends ConsumerStatefulWidget {
  static String routeName = "/login";
  const Login({super.key});

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  bool loading = false;
  String email = "";
  String password = "";
  bool hidePassword = true;
  _togglePassword() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  userlogin(String email, String password) async {
    setState(() {
      loading = true;
    });

    ref.read(authNotifierProvider.notifier).login(email, password);

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset(ImageConst.breachlogo, width: 100),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 48),
              Center(
                child: Text(
                  'Login',
                  style: AppTheme.largeText(
                    context,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Break through the noise and discover content that matters to you in under 3 minutes.',
                textAlign: TextAlign.center,
                style: AppTheme.normalText(
                  context,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 24),
              Text(
                'Email',
                textAlign: TextAlign.left,
                style: AppTheme.normalText(
                  context,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 4),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,

                  hintText: "Enter email",
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {},
                onChanged: (String? value) {
                  setState(() {
                    email = value!;
                  });
                },
                onSaved: (String? value) {
                  email = value!;
                },
              ),
              SizedBox(height: 24),
              Text(
                'Password',
                textAlign: TextAlign.left,
                style: AppTheme.normalText(
                  context,
                ).copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 4),
              TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                obscureText: hidePassword,
                decoration: InputDecoration(
                  hintText: "Enter Password",

                  suffixIcon: InkWell(
                    child: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                      color: AppTheme.grayColor,
                      size: 20,
                    ),
                    onTap: _togglePassword,
                  ),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (String? value) {},
                onChanged: (String? value) {
                  setState(() {
                    password = value!;
                  });
                },
                onSaved: (String? value) {
                  password = value!;
                },
              ),
              SizedBox(height: 48),

              Center(
                child: ElevatedButton(
                  child: loading
                      ? CircularProgress()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
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
                      // Use the component's default.
                    }),
                    textStyle: WidgetStatePropertyAll(
                      TextStyle(color: Colors.white),
                    ),
                  ),
                  onPressed: loading || email.isEmpty || password.isEmpty
                      ? null
                      : () async {
                          await userlogin(email, password);
                        },
                ),
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: AppTheme.smallText(
                      context,
                    ).copyWith(fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: "Create account",
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go(CreateAccount.routeName);
                          },
                        style: AppTheme.smallText(context).copyWith(
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 96),

              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By signing up, you agree to Breach’s ',
                    style: AppTheme.smallText(context),
                    children: [
                      TextSpan(
                        text: 'Terms',
                        style: AppTheme.smallText(context).copyWith(
                          color: AppTheme.primaryColor,
                          // decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            try {} catch (e) {
                              // An exception is thrown if browser app is not installed on Android device.
                              debugPrint(e.toString());
                            }
                          },
                      ),
                      TextSpan(
                        text: ' & ',
                        style: AppTheme.smallText(context).copyWith(),
                      ),
                      TextSpan(
                        text: 'Privacy policy',
                        style: AppTheme.smallText(context).copyWith(
                          color: AppTheme.primaryColor,
                          // decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            try {} catch (e) {
                              // An exception is thrown if browser app is not installed on Android device.
                              debugPrint(e.toString());
                            }
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
