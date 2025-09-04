import 'package:breach/models/app_config.dart';
import 'package:breach/models/user_model.dart';
import 'package:breach/modules/userprefs.dart';
import 'package:breach/notifiers/providers.dart';
import 'package:breach/router.dart';
import 'package:breach/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Future<bool> hasUserLogged(ProviderContainer container) async {
    User currentUser = await UserPreferences().getUser();

    if (currentUser.token!.isNotEmpty) {
      await container
          .read(authNotifierProvider.notifier)
          .initializeUser(currentUser);
      await container.read(themeNotifier.notifier).loadFromPrefs();

      return true;
    } else {
      return false;
    }
  }

  Future<bool> initalizeEnvironment(
    ProviderContainer container,
    AppConfig config,
  ) async {
    await container
        .read(appConfigNotifierProvider.notifier)
        .initializeApp(config);
    return true;
  }

  final container = ProviderContainer();

  await hasUserLogged(container);

  var configuredApp = AppConfig(
    child: ProviderScope(parent: container, child: MyApp()),
    // 2
    environment: Environment.prod,

    // 3
    appRouter: AppRouter(),
    appTitle: 'Breach',
    apiGateway: ApiGateway(
      coreUrl: "https://breach-api.qa.mvm-tech.xyz",
      socketUrl: "wss://breach-api-ws.qa.mvm-tech.xyz",
      shareLinkUrl: "https://breach-api-ws.qa.mvm-tech",
      clientIDWeb: "",
      clientiOS: "",
      clientAndroid: "",
      serverID: "",
    ),
  );

  await initalizeEnvironment(container, configuredApp);

  runApp(configuredApp);
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppRouter appRouter = AppRouter();
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Breach',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (context, child) {
        return MaterialApp.router(
          color: AppTheme.primaryColor,
          debugShowCheckedModeBanner: false,
          routeInformationProvider: appRouter.router.routeInformationProvider,
          routeInformationParser: appRouter.router.routeInformationParser,
          routerDelegate: appRouter.router.routerDelegate,
          theme: ref.watch(themeNotifier).darkTheme ? dark : light,
        );
      },
    );
  }
}
