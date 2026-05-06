import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../application/routes/route_generator.dart';
import '../constants/asset_manager.dart';
import '../data/local_data_source/preference/i_pref_helper.dart';
import '../di/di.dart';

class SplashView extends BaseStateFullWidget {
  SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      _navigateNext();
    });
  }

  Future<void> _navigateNext() async {
    // ✅ Guard: don't navigate if widget is unmounted
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final bool isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (!mounted) return; // ✅ Check again after async gap

    if (isFirstTime) {
      // ✅ First launch → show Onboarding and mark as seen
      await prefs.setBool('is_first_time', false);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnboardingView()),
            (route) => false,
      );
    } else {
      // ✅ Returning user → check token
      final token = inject<IPrefHelper>().retrieveToken();

      if (token != null && token.isNotEmpty) {
        // ✅ Token exists → go to main app
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteManager.rBottomBarView,
              (route) => false,
        );
      } else {
        // ✅ No token → go to Login
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteManager.rLoginView,
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: widget.dimens.k130,
              width: widget.dimens.k300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.appIcon),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}