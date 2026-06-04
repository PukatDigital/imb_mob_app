import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/auth_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/block/block_profile_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/explore/explore_model_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/favourite/favourite_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/home_view_model.dart';

import 'package:ideal_marriage_bureau/presentation/views/home/view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/profile/profile_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/report_problem/report_problem_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/set_up_profile_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/sign_up_view_model.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/app_theme/app_themes.dart';
import 'application/app_theme/color_scheme.dart';
import 'application/main_config.dart';
import 'application/routes/route_generator.dart';
import 'base/base_widget.dart';
import 'constants/string_manager.dart';
import 'data/local_data_source/preference/i_pref_helper.dart';
import 'data/local_data_source/preference/pref_helper.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarColor: ColorManager.transparent, statusBarIconBrightness: Brightness.dark, statusBarBrightness: Brightness.dark));
  await initMainServiceLocator();
  runApp(MyApp());
}

class MyApp extends BaseStateFullWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final prefHelper = PrefHelper(snapshot.data!);

        return MultiProvider(
          providers: [
            Provider<IPrefHelper>(
              create: (_) => prefHelper, // ✅ add back the PrefHelper provider
            ),
            ChangeNotifierProvider(create: (_) => AuthViewModel()),
            ChangeNotifierProvider(create: (_) => ViewModel()),
            ChangeNotifierProvider(create: (_) => SignUpViewModel()),
            ChangeNotifierProvider(create: (_) => SetUpProfileViewModel()),
            ChangeNotifierProvider(create: (_) => GetProfileViewModel()),
            ChangeNotifierProvider(create: (_) => GetPersonalProfileViewModel()),
            ChangeNotifierProvider(create: (_) => BlockViewModel()),
            ChangeNotifierProvider(create: (_) => FavouriteViewListModel()),
            ChangeNotifierProvider(create: (_) => ExploreViewModel()),
            ChangeNotifierProvider(create: (_) => GetReportProblem()),
          ],
          child: MaterialApp(
            title: StringManager.appName,
            scrollBehavior: MyBehavior(),
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: RouteManager.rSplashView,
            onGenerateRoute: RouteGenerator.generateRoute,
            navigatorKey: widget.navigator.key(),
            navigatorObservers: [routeObserver],
          ).onTap(onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          }),
        );
      },
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => AuthViewModel()),
  //       ChangeNotifierProvider(create: (_)=>ViewModel()),
  //       ChangeNotifierProvider(create: (_)=>SignUpViewModel()),
  //       ChangeNotifierProvider(create: (_)=>SetUpProfileViewModel())
  //     ],
  //     child: MaterialApp(
  //       title: StringManager.appName,
  //       scrollBehavior: MyBehavior(),
  //       theme: lightTheme,
  //       debugShowCheckedModeBanner: false,
  //       initialRoute: RouteManager.rSplashView,
  //       onGenerateRoute: RouteGenerator.generateRoute,
  //       navigatorKey: widget.navigator.key(),
  //       navigatorObservers: [routeObserver],
  //     ).onTap(onTap: () {
  //       FocusManager.instance.primaryFocus?.unfocus();
  //     }),
  //   );
  // }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
