import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/app_theme/text_themes.dart';
import '../../../application/common/enum.dart';
import '../../../application/core/result.dart';
import '../../../application/routes/route_generator.dart';
import '../../../base/base_widget.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/custom_dailogBox.dart';
import '../../../widgets/custom_field.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/toast.dart';

class ReportProblemView extends BaseStateFullWidget {
  ReportProblemView({super.key});

  @override
  State<ReportProblemView> createState() => _ReportProblemViewState();
}

class _ReportProblemViewState extends State<ReportProblemView>
    implements Result {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final List<String> reportIssues = [
    "Login Issue",
    "OTP Issue",
    "Payment Issue",
    "Profile Issue",
    "App Crash",
    "Other",
  ];

  String selectedIssue = "App Crash";

  String? selectedFileName;

  bool get isAppCrash => selectedIssue == "App Crash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          /// Background
          // _background(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.dimens.k18,
                vertical: widget.dimens.k16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: widget.dimens.k16,
                              color: ColorManager.rejectedText,
                            ),

                            Text(
                              "Back",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: ColorManager.rejectedText,
                                fontSize: widget.dimens.k14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "Report a Problem",
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: widget.dimens.k18,
                              color: ColorManager.textColor,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: widget.dimens.k40),
                    ],
                  ),

                  widget.dimens.k30.verticalBoxPadding,

                  /// Main Container
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(widget.dimens.k18),

                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Report Issue Text
                              Text(
                                "Select report issue.",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),

                              widget.dimens.k20.verticalBoxPadding,

                              /// Radio Buttons
                              ...reportIssues.map((issue) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: widget.dimens.k12,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedIssue = issue;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: issue,
                                          groupValue: selectedIssue,
                                          activeColor:
                                              ColorManager.rejectedText,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedIssue = val!;
                                            });
                                          },
                                        ),

                                        Text(
                                          issue,
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),

                              widget.dimens.k15.verticalBoxPadding,

                              /// Subject Field only for App Crash
                              if (isAppCrash) ...[
                                Text(
                                  "Subject",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                widget.dimens.k8.verticalBoxPadding,

                                CustomField(
                                  hintText: "Enter subject",
                                  controller: subjectController,
                                  validator: (value) {
                                    if (isAppCrash &&
                                        (value == null || value.isEmpty)) {
                                      return "Subject is required";
                                    }
                                    return null;
                                  },
                                ),

                                widget.dimens.k18.verticalBoxPadding,
                              ],

                              /// Description
                              Text(
                                "Description",
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              widget.dimens.k8.verticalBoxPadding,

                              /// Description Field
                              CustomField(
                                hintText: "Enter here",
                                controller: descriptionController,
                                maxLines: 5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Description is required";
                                  }
                                  return null;
                                },
                              ),

                              widget.dimens.k18.verticalBoxPadding,

                              /// Add Document only for App Crash
                              GestureDetector(
                                onTap: () {
                                  /// Dummy Picker
                                  setState(() {
                                    selectedFileName = "crash_log.pdf";
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: widget.dimens.k30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      widget.dimens.k12,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(Assets.image,
                                        width: widget.dimens.k15,
                                        height: widget.dimens.k15,

                                      ),

                                      widget.dimens.k8.verticalBoxPadding,

                                      Text(
                                        selectedFileName ?? "Add Document",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              widget.dimens.k40.verticalBoxPadding,

                              /// Submit Button
                              PrimaryButton(
                                childText: "Submit",
                                isSafeArea: false,
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    onSuccess("Report submitted successfully");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _background() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFB11E24).withOpacity(.18),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  @override
  onError(String error) {
    MyToast.showToast(message: error, typeToast: TypeToast.error);
    showCustomStatusDialog(
      context: context,
      dimens: widget.dimens,
      icon: Assets.error,
      title: "Not report submitted ",
      description:
      "Your report is not submitted. input\n required fields are missing",
      buttonText: "Retry",
      buttonColor: ColorManager.rejectedText,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  @override
  onSuccess(result) {
    MyToast.showToast(
      message: result.toString(),
      typeToast: TypeToast.success,
    );

    showCustomStatusDialog(
      context: context,
      dimens: widget.dimens,
      icon: Assets.success,
      title: "Report submitted \n successfully 🎉",
      description:
      "We will get back to you shortly.",
      buttonText: "Done",
      onPressed: () {

        /// Close Dialog
        Navigator.pop(context);

        /// Navigate
        Navigator.pushReplacementNamed(
          context,
          RouteManager.rProfileScreen,
        );
      },
    );
  }
}
