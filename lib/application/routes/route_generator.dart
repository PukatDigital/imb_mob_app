
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../data/models/get_profile_model/profile_details_model.dart';
import '../../onboarding/onboarding.dart';
import '../../presentation/views/auth/auth_view_model.dart';
import '../../presentation/views/auth/sign-in/login_view.dart';
import '../../presentation/views/auth/sign-in/sign_up_create_view.dart';
import '../../presentation/views/auth/sign-in/verification_code_view.dart';

import '../../presentation/views/block/block_list_view.dart';
import '../../presentation/views/bottom_bar/bottom_bar_view.dart';
import '../../presentation/views/notification/notification_list_view.dart';
import '../../presentation/views/profile/profile_details_view.dart';
import '../../presentation/views/set-up/sign_up_home_view.dart';
import '../../presentation/views/view_plan/plan_view.dart';
import '../../splash/splash_view.dart';
import '../core/routes/routes.dart';

class RouteManager {
  static const rInitial = '/';
  static const rSplashView = '/rSplashView';
  static const rOnboardingView = '/rOnboardingView';
  static const rLoginView = '/rLoginView';
  static const rVerificationCodeView = '/rVerificationCodeView';
  static const rSignUpCreateView = '/rSignUpCreateView';
  static const rBottomBarView = '/rBottomBarView';
  static const rSignInView = '/rSignInView';
  static const rHomeView = '/rHomeView';
  static const rHistoryView = '/rHistoryView';
  static const rSimRegistrationView = '/rSimRegistrationView';
  static const rRegisterNewMemberView = '/rRegisterNewMemberView';
  static const rSuccessfullyRegisteredView = '/rSuccessfullyRegisteredView';
  static const rMNPNumberView = '/rMNPNumberView';
  static const rOrderSimView = '/rOrderSimView';
  static const rOrderHistory = '/rOrderHistory';
  static const rTSignUpCreationView = '/rSignUpCreationView';
  static const rProfileDetailsView = '/rProfileDetailsView';
  static const rPlanView = '/rPlanView';
  static const rNotificationListView = '/rNotificationListView';
  static const rBlockListView = '/rBlockListView';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {

      case RouteManager.rInitial:
      case RouteManager.rSplashView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  SplashView(),
          ),
        );
      case RouteManager.rOnboardingView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  OnboardingView(),
          ),
        );
        case RouteManager.rLoginView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  LoginView(),
          ),
        );
      case RouteManager.rVerificationCodeView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child: VerificationCodeView(
              email: settings.arguments as String?, // ✅ FIX
            ),
          ),
        );
        case RouteManager.rSignUpCreateView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  SignUpCreateView(

            ),
          ),
        );
      case RouteManager.rBottomBarView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: BottomBarView(),
            ));
        case RouteManager.rTSignUpCreationView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: SignUpCreationView(),
            ));
      case RouteManager.rProfileDetailsView:
        final data = settings.arguments as ProfileData?;
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (context) => AuthViewModel(),
            child: ProfileDetailsView(profileData: data), // ✅
          ),
        );
        case RouteManager.rPlanView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: PlanView(),
            ));

        case RouteManager.rNotificationListView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: NotificationListView(),
            ));
        case RouteManager.rBlockListView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: BlockListView(),
            ));






      // case RouteManager.rHomeView:
      //   return PageRouter.fadeScale(
      //     settings,
      //         () => ChangeNotifierProvider(
      //       create: (_) => AuthViewModel(),
      //       child: HomeView(),
      //     ),
      //   );

      // case RouteManager.rSignInView:
      //   return PageRouter.fadeScale(
      //     settings,
      //         () => ChangeNotifierProvider(
      //       create: (_) => AuthViewModel(),
      //       child: LoginView(),
      //     ),
      //   );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Container(color: Colors.white, child: const Text('Page Not Found')),
        ),
      );
    });
  }
}

class TranforData {
  String? networkType,
      identityType,
      firstName,
      lastName,
      NRIC,
      passportNo,
      address,
      zipCode,
      city,
      state,
      frontImage,
      backImage,
      IssuingCountry,
      Nationality,
      IssuingCountryABB,
      NationalityABB;
  DateTime? BirthDate;

  TranforData(
      {this.networkType,
      this.identityType,
      this.frontImage,
      this.backImage,
      this.firstName,
      this.lastName,
      this.NRIC,
      this.address,
      this.zipCode,
      this.city,
      this.state,
      this.passportNo,
      this.BirthDate,
      this.Nationality,
      this.IssuingCountry,
      this.IssuingCountryABB,
      this.NationalityABB});
}

class TranforData2 {
  String? networkType, name, iccid, msisdn;

  TranforData2({this.networkType, this.name, this.iccid, this.msisdn});
}
