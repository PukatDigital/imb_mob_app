// import 'package:flutter/material.dart';
// import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
// import 'package:ideal_marriage_bureau/base/base_widget.dart';
//
// import 'package:provider/provider.dart';
//
// import '../../../../application/common/enum.dart';
// import '../../../../application/common/log.dart';
// import '../../../../application/core/result.dart';
// import '../../../../application/helper/validators.dart';
// import '../../../../application/network/result.dart';
// import '../../../../application/routes/route_generator.dart';
// import '../../../../constants/asset_manager.dart';
// import '../../../../constants/string_manager.dart';
// import '../../../../widgets/custom_app_bar.dart';
//
// import '../../../../widgets/custom_field.dart';
// import '../../../../widgets/loader.dart';
// import '../../../../widgets/primary_button.dart';
// import '../../../../widgets/toast.dart';
// import '../auth_mixin.dart';
// import '../auth_view_model.dart';
//
// class LoginView extends BaseStateFullWidget {
//   LoginView({super.key});
//
//   @override
//   State<LoginView> createState() => _LoginViewState();
// }
//
// class _LoginViewState extends State<LoginView> with AuthMixin implements Result {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         context: context,
//       ),
//       body: SingleChildScrollView(
//         child: Consumer<AuthViewModel>(
//           builder: (context, provider, child) {
//             authVM = provider;
//             return _body();
//           },
//         ).padding(EdgeInsets.all(widget.dimens.k15)),
//       ),
//     );
//   }
//
//   Widget _body() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         widget.dimens.k80.verticalBoxPadding,
//         Align(
//           alignment: Alignment.center,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image.asset(Assets.appIcon,
//                   height: context.getHeight(
//                     widget.dimens.k15.cm,
//                   )),
//               widget.dimens.k20.verticalBoxPadding,
//               Text(StringManager.appName, style: context.textTheme.displayMedium),
//               widget.dimens.k10.verticalBoxPadding,
//               Text(StringManager.loginTo, style: context.textTheme.bodyLarge),
//             ],
//           ),
//         ),
//         widget.dimens.k50.verticalBoxPadding,
//         Form(
//           key: formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(StringManager.userName, style: context.textTheme.bodySmall),
//               widget.dimens.k6.verticalBoxPadding,
//               CustomField(
//                 hintText: StringManager.userName,
//                 keyboardType: TextInputType.emailAddress,
//                 controller: username,
//                 validator: (input) => AppValidators.fieldValidator(input),
//               ),
//               widget.dimens.k15.verticalBoxPadding,
//               Text(StringManager.password, style: context.textTheme.bodySmall),
//               widget.dimens.k6.verticalBoxPadding,
//               CustomField(
//                 controller: password,
//                 hintText: StringManager.password,
//                 obscureText: !passVisibility,
//                 // suffixIconString: passVisibility ? Assets.visible : Assets.inVisible,
//                 suffixIconCallBack: () => setState(() => passVisibility = !passVisibility),
//                 validator: (input) => AppValidators.fieldValidator(input),
//                 maxLines: 1,
//               ),
//             ],
//           ),
//         ),
//         widget.dimens.k30.verticalBoxPadding,
//         authVM.apiResponse is Loading
//             ? Loader()
//             : PrimaryButton(
//                 childText: StringManager.login,
//                 isSafeArea: false,
//                 onPressed: () {
//                   if (validate) {
//                    /* authVM.signInByEmail({
//                       "username": username.text.trim(),
//                       "password": password.text
//                     }, this);*/
//                   }
//                 },
//               ),
//       ],
//     );
//   }
//
//   @override
//   onError(String error) {
//     MyToast.showToast(message: error, typeToast: TypeToast.error);
//   }
//
//   @override
//   onSuccess(result) {
//     d(result.toJson());
//     d(result.toJson()['token']);
//     widget.iPrefHelper.saveUser(result);
//     widget.iPrefHelper.saveToken(result.toJson()['token']);
//     MyToast.showToast(message: "Login Successfully");
//     widget.navigator.pushNamedAndRemoveUntil(RouteManager.rHomeView);
//   }
// }
