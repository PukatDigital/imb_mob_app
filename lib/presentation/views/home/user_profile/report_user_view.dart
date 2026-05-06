import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/common/enum.dart';
import '../../../../application/core/result.dart';
import '../../../../application/helper/validators.dart';

import '../../../../base/base_widget.dart';
import '../../../../widgets/custom_field.dart';
import '../../../../widgets/toast.dart';
import '../../auth/auth_mixin.dart';
import '../home_view_model.dart';

class ReportUserView extends BaseStateFullWidget {
  final String userName;
  final String userId;

  ReportUserView({
    super.key,
    required this.userName,
    required this.userId,
  });

  @override
  State<ReportUserView> createState() => _ReportUserViewState();
}

class _ReportUserViewState extends State<ReportUserView>
    with AuthMixin
    implements Result ,ErrorResult{
  final TextEditingController otherReasonController = TextEditingController();

  final List<String> reasons = [
    "Harassment",
    "Inappropriate behavior",
    "Violation of guidelines",
    "Offensive language",
    "Disrespectful behavior",
    "Threats",
    "Catfishing",
    "Unwanted advances",
    "Privacy concerns",
    "Other",
  ];

  String? selectedReason; // ✅ SINGLE selection only

  bool get isOtherSelected => selectedReason == "Other";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          top: size.height * 0.79,
          left: widget.dimens.k20,
          right: widget.dimens.k20,
          child: Container(
            height: size.height * 0.68,
            decoration: BoxDecoration(
              color: ColorManager.white.withOpacity(.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.dimens.k25),
                topRight: Radius.circular(widget.dimens.k25),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.height * 0.63,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.dimens.k25),
                topRight: Radius.circular(widget.dimens.k25),
              ),
            ),
            child: _buildContent(context),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.dimens.k15.verticalBoxPadding,

          /// Header
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.clear),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    "Report User",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontSize: widget.dimens.k17,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48)
            ],
          ),

          widget.dimens.k20.verticalBoxPadding,
          Divider(color: ColorManager.addPicture),
          widget.dimens.k20.verticalBoxPadding,

          Text(
            "Why did you report this user?",
            style: context.textTheme.titleMedium?.copyWith(
              fontSize: widget.dimens.k17,
              fontWeight: FontWeight.w600,
              color: ColorManager.textColor,
            ),
          ),

          widget.dimens.k20.verticalBoxPadding,

          /// Reasons list
          Expanded(
            child: ListView(
              children: [
                ...reasons.map((reason) => _buildCheckbox(reason)),

                /// Other field
                if (isOtherSelected) ...[
                  widget.dimens.k15.verticalBoxPadding,
                  CustomField(
                    hintText: "Enter reason here...",
                    keyboardType: TextInputType.text,
                    controller: otherReasonController,
                    maxLines: 3,
                    validator: (input) =>
                        AppValidators.fieldValidator(input),
                  ),
                ],
              ],
            ),
          ),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () => Navigator.pop(context),
                  childText: 'Cancel',
                  issquare: true,
                  color: ColorManager.primary.withOpacity(.2),
                  height: 55,
                  radius: 28,
                  textStyle: context.textTheme.titleMedium!.copyWith(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              widget.dimens.k8.horizontalBoxPadding,
              Expanded(
                child: PrimaryButton(
                  onPressed: _submitReport,
                  childText: 'Yes, Report',
                  issquare: true,
                  color: ColorManager.primary,
                  height: 55,
                  radius: 28,
                  textStyle: context.textTheme.titleMedium!.copyWith(
                    color: ColorManager.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          widget.dimens.k30.verticalBoxPadding,
        ],
      ),
    );
  }

  Widget _buildCheckbox(String reason) {
    final isSelected = selectedReason == reason;

    return InkWell(
      onTap: () {
        setState(() {
          selectedReason = reason; // ✅ single select
        });
      },
      child: Row(
        children: [
          Checkbox(
            value: isSelected,
            shape: const CircleBorder(),
            onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedReason = reason;
                } else {
                  selectedReason = null;
                }
              });
            },
          ),
          widget.dimens.k7.horizontalBoxPadding,
          Expanded(
            child: Text(
              reason,
              style: context.textTheme.bodyMedium?.copyWith(
                color: ColorManager.textColor,
                fontWeight: FontWeight.w400,
                fontSize: widget.dimens.k16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitReport() {
    final viewModel = context.read<GetProfileViewModel>();

    if (selectedReason == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a reason")),
      );
      return;
    }

    final login = widget.iPrefHelper.loginModel;

    String description = "";
    if (isOtherSelected && otherReasonController.text.isNotEmpty) {
      description = otherReasonController.text.trim();
    }

    final data = {
      "reported_by": login?.data?.user?.email ?? "",
      "reported_user": widget.userId,
      "reason": selectedReason,
      "description": description,
      "is_blocked": 1,
    };

    print("REPORT REQUEST => $data");

    viewModel.addToReportUser(data, this);
  }

  @override
  onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  onSuccess(result) {
    MyToast.showToast(
      message: result,
      typeToast: TypeToast.success,
    );
    context.read<GetProfileViewModel>().getAllProfiles(this);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}