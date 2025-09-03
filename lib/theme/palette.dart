import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ThemeData light = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  hintColor: AppTheme.greyColor,
  fontFamily: 'Inter',
  primaryColor: Color(0xFF8311F9),
  primaryColorDark: Color(0xffe9e9e9),
  primarySwatch: MaterialColor(0xFF000000, const {
    50: const Color(0xFF8311F9),
    100: const Color(0xFF8311F9),
    200: const Color(0xFF8311F9),
    300: const Color(0xFF8311F9),
    400: const Color(0xFF8311F9),
    500: const Color(0xFF8311F9),
    600: const Color(0xFF8311F9),
    700: const Color(0xFF8311F9),
    800: const Color(0xFF8311F9),
    900: const Color(0xFF8311F9),
  }),
  iconTheme: IconThemeData(color: Colors.black),

  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Color(0xfff0f2f5),
    elevation: 0,
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(bodyColor: Colors.black, displayColor: Colors.grey),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF8311F9)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    isDense: true, // Added this
    contentPadding: EdgeInsets.all(16),
    hintStyle: TextStyle(color: Color(0xFFC6CBD9), fontFamily: 'Inter'),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppTheme.grayColor),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppTheme.grayColor),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: AppTheme.grayColor),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: Color(0xFFA10000)),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),

  timePickerTheme: TimePickerThemeData(
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFFE3E3E3)),
    ),
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFFE3E3E3)),
      foregroundColor: WidgetStatePropertyAll(AppTheme.primaryMedium),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(0xFF8311F9, const {
      900: const Color(0xFF8311F9),
      800: const Color(0xFFf16b39),
      700: const Color(0xFFf27c4f),
      600: const Color(0xFFf48c65),
      500: const Color(0xFFf59d7b),
      400: const Color(0xFFf7ad91),
      300: const Color(0xFFf9bda7),
      200: const Color(0xFFfacebd),
      100: const Color(0xFFfcded3),
      50: const Color(0xFFfdefe9),
    }),
    accentColor: Color(0xFFf9bda7),
    backgroundColor: Color(0xfff0f2f5),
    brightness: Brightness.light,
    cardColor: Color(0xFFE3E3E3),
    errorColor: Color(0xFFA10000),
  ),
  dividerTheme: DividerThemeData(color: AppTheme.grayColor, thickness: 0.4),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppTheme.primaryColor,
  ),
  focusColor: Color(0xff001f3d),
  scaffoldBackgroundColor: Color(0xfff0f2f5),
  cardColor: Color(0xFFE3E3E3),
  dialogBackgroundColor: Color(0xfff0f2f5),
  dialogTheme: DialogThemeData(backgroundColor: Color(0xfff0f2f5)),
  bottomSheetTheme: BottomSheetThemeData(
    modalBackgroundColor: Color(0xfff0f2f5),
    backgroundColor: Color(0xfff0f2f5),
  ),
);

ThemeData dark = ThemeData(
  useMaterial3: true,
  fontFamily: 'Inter',
  hintColor: AppTheme.grayColor,
  brightness: Brightness.dark,
  primaryColor: Color(0xFF8311F9),
  primaryColorDark: Color(0xff333333),
  primarySwatch: MaterialColor(0xFFFFFFFF, const {
    50: const Color(0xFF8311F9),
    100: const Color(0xFFf16b39),
    200: const Color(0xFFf27c4f),
    300: const Color(0xFFf48c65),
    400: const Color(0xFFf59d7b),
    500: const Color(0xFFf7ad91),
    600: const Color(0xFFf9bda7),
    700: const Color(0xFFfacebd),
    800: const Color(0xFFfcded3),
    900: const Color(0xFFfdefe9),
  }),
  focusColor: Color(0xFF4F2308),
  iconTheme: IconThemeData(color: Colors.white),

  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Color(0xff111111),
    titleTextStyle: TextStyle(color: Color(0xfff0f2f5), fontSize: 16),
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(),
    bodyMedium: TextStyle(),
  ).apply(bodyColor: Colors.white, displayColor: Colors.grey),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF8311F9)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white)),
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    isDense: true, // Added this
    contentPadding: EdgeInsets.all(16),
    hintStyle: TextStyle(color: Color(0xFFC6CBD9), fontFamily: 'Inter'),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: Color(0xFFEFEFEF)),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: Color(0xFFEFEFEF)),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: Color(0xFFEFEFEF)),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.6, color: Color(0xFFA10000)),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFF333333), thickness: 0.4),

  timePickerTheme: TimePickerThemeData(
    confirmButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF343434)),
      foregroundColor: WidgetStatePropertyAll(AppTheme.white),
    ),
    cancelButtonStyle: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color(0xFF343434)),
      foregroundColor: WidgetStatePropertyAll(AppTheme.grayColor),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: MaterialColor(0xFF8311F9, const {
      900: const Color(0xFF8311F9),
      800: Color(0xFF9C4626),
      700: Color(0xFF83442B),
      600: Color(0xFF5D3425),
      500: Color(0xFF6B4536),
      400: Color(0xFF614339),
      300: Color(0xFF674F46),
      200: Color(0xFF63514A),
      100: Color(0xFF564C48),
      50: Color(0xFF4B4644),
    }),
    accentColor: Color(0xFF4F2308),
    backgroundColor: Color(0xff111111),
    brightness: Brightness.dark,
    cardColor: Color(0xFF343434),
    errorColor: Color(0xFFA10000),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppTheme.primaryColor,
  ),
  scaffoldBackgroundColor: Color(0xff111111),
  cardColor: Color(0xFF343434),
  canvasColor: Color(0xff111111),
  cardTheme: CardThemeData(color: Color(0xff111111)),
  dialogBackgroundColor: Color(0xff111111),
  // backgroundColor: Color(0xff111111),
  dialogTheme: DialogThemeData(backgroundColor: Color(0xff111111)),
  bottomSheetTheme: BottomSheetThemeData(
    modalBackgroundColor: Color(0xff111111),
    backgroundColor: Color(0xff111111),
  ),
  // highlightColor: Colors.transparent,
  // splashColor: Colors.transparent,
);

class AppTheme {
  // All of our constant stuff

  static Color white = Color(0xFFFFFFFF);
  // 0f4fe4

  static Color primaryColor = Color(0xFF8311F9);
  // 0f4fe4

  static Color primaryMedium = Color(0xFF9B46F6);
  static Color secondaryColor = Color(0xFF183D81);
  static Color secondaryMedium = Color.fromARGB(255, 43, 101, 152);

  static Color primaryLight = Color(0xFFC594FB);
  static Color secondaryLight = Color(0xFF5b7c99);

  static Color brownColor = Color(0xFFFAF0EB);

  static Color black = Color(0xFF1C1C1C);

  static Color inputBg = Color(0xFFFAFAFA);

  static Color grayColor = Color(0xFFC0C0C0);
  static Color greyColor = Color(0xFF565656);

  static Color inputText = Color(0xFFBABABA);

  static Color header1Color = Color(0xFF06244B);

  static Color errorLight = Color(0xFFFFAFB7);
  static Color errorMedium = Color(0xFFBB4E5B);
  static Color errorColor = Color(0xFFED2F46);

  static Color successColor = const Color(0xFF2D7738);
  static Color successMedium = Color(0xFF5C8763);
  static Color successLight = const Color(0xFFD7EAD9);

  static Color warningColor = const Color(0xFFFFCC00);
  static Color warningMedium = Color(0xFF998639);
  static Color warningLight = Color(0xFFFEECA5);

  static Color goldColor = Color(0xFFEFB507);
  static Color silverColor = Color(0xFF77777B);
  static Color bronzeColor = Color(0xffA77044);

  static final kDefaultPadding = 20.0;

  static TextStyle hugeText(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontSize: 96.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle grandText(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontSize: 60.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
    );
  }

  static TextStyle jerseyText(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontSize: 42.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle extralargeText(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontSize: 31.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle largeText(BuildContext context) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
      fontSize: 26.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle mediumText(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 15.5,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle bigText(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle extraBigText(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 22.5,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    );
  }

  static TextStyle smallText(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 11.5,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle extraSmallText(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 9.9,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle normalText(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle formLabeltext(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
    );
  }

  static TextStyle tableelementstyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Inter',
    );
  }

  static TextStyle tableheadstyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      fontFamily: 'Inter',
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  final String key = "theme";
  SharedPreferences? _prefs;
  late bool _darkTheme;

  bool get darkTheme => _darkTheme;

  late ThemeData data = _darkTheme ? dark : light;

  ThemeNotifier() {
    _darkTheme = false;
    loadFromPrefs();
  }

  toggleTheme() {
    _darkTheme = !_darkTheme;
    if (_darkTheme) {
      data = dark;
    } else {
      data = light;
    }
    _saveToPrefs();
    notifyListeners();
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  loadFromPrefs() async {
    await _initPrefs();
    _darkTheme = _prefs!.getBool(key) ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    await _initPrefs();
    _prefs!.setBool(key, _darkTheme);
  }
}
