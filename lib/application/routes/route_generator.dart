
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/sign-in/forget_password/forgetPassword_phone_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/user_profile/impression_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/linked_devices/linked_device_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/profile/profile_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/report_problem/report_problem_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/terms_and_conditions/terms_and_condition_view.dart';


import 'package:provider/provider.dart';
import '../../data/models/get_profile_model/profile_details_model.dart';
import '../../onboarding/onboarding.dart';

import '../../presentation/views/auth/auth_view_model.dart';

import '../../presentation/views/auth/sign-in/forget_password/create_new_password_view.dart';
import '../../presentation/views/auth/sign-in/forget_password/forgetPassword_email_View.dart';
import '../../presentation/views/auth/sign-in/forget_password/verfication_code_view.dart';
import '../../presentation/views/auth/sign-in/login_view.dart';
import '../../presentation/views/auth/sign-in/sign_up_create_view.dart';
import '../../presentation/views/auth/sign-in/verification_code_view.dart';

import '../../presentation/views/block/block_list_view.dart';
import '../../presentation/views/bottom_bar/bottom_bar_view.dart';
import '../../presentation/views/linked_devices/verification_screen_view.dart';
import '../../presentation/views/notification/notification_list_view.dart';
import '../../presentation/views/privacy/privacy_screen_view.dart';
import '../../presentation/views/profile/profile_details_view.dart';
import '../../presentation/views/report_problem/problem_detail_view.dart';
import '../../presentation/views/report_problem/problem_list_view.dart';
import '../../presentation/views/report_problem/report_problem_view_model.dart';
import '../../presentation/views/set-up/sign_up_home_view.dart';
import '../../presentation/views/view_plan/payment_history.dart';
import '../../presentation/views/view_plan/payment_view.dart';
import '../../presentation/views/view_plan/plan_details_view_model.dart' show PlansViewModel;
import '../../presentation/views/view_plan/plan_history_details_view.dart';
import '../../presentation/views/view_plan/plan_view.dart';
import '../../splash/splash_view.dart';
import '../core/routes/routes.dart';

class RouteManager {
  static const rInitial = '/';
  static const rSplashView = '/rSplashView';
  static const rOnboardingView = '/rOnboardingView';
  static const rLoginView = '/rLoginView';
  static const rForgotPassword = '/rForgotPassword';
  static const rContinueWithPhone = '/rContinueWithPhone';
  static const rVerificationCodeView = '/rVerificationCodeView';
  static const rSignUpCreateView = '/rSignUpCreateView';
  static const rForgetPasswordOTPView = '/rForgetPasswordOTPView';
  static const rCreateNewPasswordView = '/rCreateNewPasswordView';

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
  static const rProfileScreen = '/rProfileScreen';
  static const rPlanView = '/rPlanView';
  static const rNotificationListView = '/rNotificationListView';
  static const rBlockListView = '/rBlockListView';
  static const rLinkedDeviceView = '/rLinkedDeviceView';
  static const rLinkedDeviceVerificationView = '/rLinkedDeviceVerificationView';
  static const rPaymentView = '/rPaymentView';
  static const rPaymentHistoryView = '/rPaymentHistoryView';
  static const rReportProblem = '/rReportProblem';
  static const rImpressionView = '/rImpressionView';
  static const rReportProblemList = '/rReportProblemList';
  static const rProblemDetails = '/rProblemDetails';
  static const rPlanListDetails = '/rPlanListDetails';
  static const rPrivacyView = '/rPrivacyView';
  static const rTermsAndCondtionsView = '/rTermsAndCondtionsView';
  static const rSubscription = '/rSubscription';
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
        case RouteManager.rForgotPassword:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  ForgetView(),
          ),
        );
      case RouteManager.rProblemDetails:
        final problemId = settings.arguments as String? ?? '';
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => GetReportProblem(),   // ← use correct provider
            child: ProblemDetailView(problemId: problemId),
          ),
        );
        case RouteManager.rPlanListDetails:
        final planId = settings.arguments as String? ?? '';
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => PlansViewModel(),   // ← use correct provider
            child: PaymentHistoryDetailView(planId: planId),
          ),
        );
        case RouteManager.rContinueWithPhone:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  ContinueWithPhoneNumber(),
          ),
        );
      case RouteManager.rCreateNewPasswordView:

        final String? email = settings.arguments as String?;

        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child: CreateNewPasswordView(
              email: email,
            ),
          ),
        );case RouteManager.rTermsAndCondtionsView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child:  TermsAndConditionsView(),
          ),
        );
        case RouteManager.rReportProblemList:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => GetReportProblem(),
            child:  ProblemListView(),
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
        ); case RouteManager.rForgetPasswordOTPView:
        return PageRouter.fadeScale(
          settings,
              () => ChangeNotifierProvider(
            create: (_) => AuthViewModel(),
            child: ForgetPasswordOTPView(
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
        case RouteManager.rPrivacyView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: PrivacyView(),
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
            child: ProfileDetailsView(profileData: data),
          ),
        );
        case RouteManager.rPlanView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: PlanView(),
            ));
        case RouteManager.rLinkedDeviceView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: LinkedDeviceView(),
            ));
        case RouteManager.rLinkedDeviceVerificationView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: LinkedDeviceVerificationView(),
            ));
        case RouteManager.rPaymentHistoryView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: PaymentHistoryView(),
            ));
        case RouteManager.rPaymentView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: PaymentView(),
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
        case RouteManager.rProfileScreen:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: ProfileScreen(),
            ));
        case RouteManager.rReportProblem:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: ReportProblemView(),
            ));

        case RouteManager.rImpressionView:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: ImpressionsView(),
            ));
        case RouteManager.rSubscription:
        return PageRouter.fadeScale(
            settings,
                () => ChangeNotifierProvider(
              create: (BuildContext context) => AuthViewModel(),
              child: PaymentHistoryView(),
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
