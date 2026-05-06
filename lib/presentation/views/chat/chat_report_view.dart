import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/widgets/primary_button.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../application/helper/validators.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/custom_field.dart';
import '../../../application/common/log.dart';
import '../auth/auth_mixin.dart';

class ChatReportView extends BaseStateFullWidget {
  ChatReportView({super.key});
  @override
  State<ChatReportView> createState() => _ChatReportViewState();
}
class _ChatReportViewState extends State<ChatReportView>
    with AuthMixin
    implements Result {
  final TextEditingController otherReasonController =
  TextEditingController();
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
  List<String> selectedReasons = [];
  bool get isOtherSelected => selectedReasons.contains("Other");
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [

          /// 🔥 FULL SCREEN OVERLAY (Tap anywhere to close)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.black.withOpacity(.4),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: widget.dimens.k20,
            right: widget.dimens.k20,
            child: Container(
              height: size.height * 0.63,
              decoration: BoxDecoration(
                color: ColorManager.white.withOpacity(.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.dimens.k25),
                  topRight: Radius.circular(widget.dimens.k25),
                ),
              ),
            ),
          ),
          /// 🔥 BOTTOM SHEET
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {}, // Prevent closing when tapping inside
              child: Container(
                height: size.height * 0.62,
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
          ),
        ],
      ),
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
              const SizedBox(width: 48),
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
          Expanded(
            child: ListView(
              children: [
                ...reasons.map((reason) => _buildCheckbox(reason)),

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
                  textStyle:
                  context.textTheme.titleMedium!.copyWith(
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
                  textStyle:
                  context.textTheme.titleMedium!.copyWith(
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
    final isSelected = selectedReasons.contains(reason);
    return InkWell(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedReasons.remove(reason);
          } else {
            selectedReasons.add(reason);
          }
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
                  selectedReasons.add(reason);
                } else {
                  selectedReasons.remove(reason);
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
    if (selectedReasons.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select at least one reason")),
      );
      return;
    }
    String finalReason = selectedReasons.join(", ");
    if (isOtherSelected &&
        otherReasonController.text.isNotEmpty) {
      finalReason += " - ${otherReasonController.text}";
    }
    d("Reported for: $finalReason");
    Navigator.pop(context);
  }
  @override
  void onError(String error) {}
  @override
  void onSuccess(result) {}
}
