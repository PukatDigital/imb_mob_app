import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/common/enum.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/presentation/views/view_plan/plan_details_view_model.dart';
import 'package:ideal_marriage_bureau/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/network/result.dart';
import '../../../base/base_widget.dart';

class PaymentHistoryDetailView extends BaseStateFullWidget {
  final String planId;
   PaymentHistoryDetailView({super.key, required this.planId});

  @override
  State<PaymentHistoryDetailView> createState() =>
      _PaymentHistoryDetailViewState();
}

class _PaymentHistoryDetailViewState extends State<PaymentHistoryDetailView>
    implements Result {

  // ✅ REMOVED: `late PlansViewModel plansData;` — never used, access via context.read/Consumer instead

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ✅ Use context.read (not watch) inside initState — triggers the API call once
      context.read<PlansViewModel>().getPlanListDetails(
        this,
        planId: widget.planId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.liteGrey,
      body: _body(),
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

  Widget _body() {
    return Stack(
      children: [
        _background(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k18,
              vertical: widget.dimens.k16,
            ),
            child: Column(
              children: [
                /// ── Header ────────────────────────────────────────────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Payment Detail",
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: widget.dimens.k18,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widget.dimens.k40),
                  ],
                ),

                widget.dimens.k40.verticalBoxPadding,

                /// ── Body: driven entirely by Consumer ─────────────────────
                Expanded(
                  // ✅ Consumer<PlansViewModel> rebuilds this subtree whenever
                  //    notifyListeners() is called — no setState needed here.
                  child: Consumer<PlansViewModel>(
                    builder: (context, provider, _) {

                      // 1️⃣ Loading state
                      if (provider.apiResponse is Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }




                      // 3️⃣ Empty / null data
                      final data = provider.plansListDetailsModel?.data;
                      if (data == null) {
                        return Center(
                          child: Text(
                            "No details found",
                            style: TextStyle(
                              fontSize: widget.dimens.k14,
                              color: ColorManager.textColorSubTitle,
                            ),
                          ),
                        );
                      }

                      // 4️⃣ Success — render the full card
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            /// Show status card only when the plan is inactive
                            if ((data.active ?? 1) == 0)
                              _statusCard(
                                planType: data.planType ?? '',
                                title: data.title ?? '',
                              ),

                            SizedBox(height: widget.dimens.k12),

                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(widget.dimens.k5),
                              decoration: const BoxDecoration(
                                color: ColorManager.white,
                              ),
                              child: Column(
                                children: [
                                  widget.dimens.k16.verticalBoxPadding,
                                  _planDetailCard(
                                    name: data.name ?? '',
                                    title: data.title ?? '',
                                    planType: data.planType ?? '',
                                    amount: data.amount ?? 0,
                                    effectivePrice: data.effectivePrice ?? 0,
                                    bonus: data.bonus ?? 0,
                                    boost: data.boost ?? 0,
                                    description: data.description ?? '',
                                    active: data.active ?? 0,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Widgets ──────────────────────────────────────────────────────────────

  Widget _statusCard({
    required String planType,
    required String title,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.dimens.k14),
      decoration: BoxDecoration(
        color: ColorManager.rejectedBg,
        borderRadius: BorderRadius.circular(widget.dimens.k5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Plan Status",
                style: TextStyle(
                  fontSize: widget.dimens.k18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              _activeBadge(0),
            ],
          ),
          widget.dimens.k18.verticalBoxPadding,
          Row(
            children: [
              Text(
                "Plan Type",
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                planType,
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          widget.dimens.k18.verticalBoxPadding,
          Text(
            "Plan:",
            style: TextStyle(fontSize: widget.dimens.k14, color: Colors.grey),
          ),
          widget.dimens.k5.verticalBoxPadding,
          Text(
            title,
            style: TextStyle(
              fontSize: widget.dimens.k16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _planDetailCard({
    required String name,
    required String title,
    required String planType,
    required int amount,
    required int effectivePrice,
    required int bonus,
    required int boost,
    required String description,
    required int active,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.dimens.k14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.dimens.k30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ──────────────────────────────────────────────────
          Row(
            children: [
              Text(
                "Plan Details",
                style: TextStyle(
                  fontSize: widget.dimens.k18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              _activeBadge(active),
            ],
          ),

          widget.dimens.k18.verticalBoxPadding,

          // Plan ID row (label + value side by side)
          Row(
            children: [
              Text(
                "Plan ID",
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                name,
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Title", value: title),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Plan Type", value: planType),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Amount", value: "PKR $amount"),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Effective Price", value: "PKR $effectivePrice"),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Bonus", value: "$bonus"),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Boost", value: "$boost"),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Description", value: description),
        ],
      ),
    );
  }

  Widget _detailItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: widget.dimens.k13,
            color: Colors.grey,
          ),
        ),
        SizedBox(height: widget.dimens.k4),
        Text(
          value,
          style: TextStyle(
            fontSize: widget.dimens.k15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _activeBadge(int active) {
    final isActive = active == 1;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k10,
        vertical: widget.dimens.k4,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? ColorManager.progressBg   // ✅ tinted bg for active
            : ColorManager.rejectedBg,  //    tinted bg for inactive
        borderRadius: BorderRadius.circular(widget.dimens.k20),
        border: Border.all(
          color: isActive
              ? ColorManager.progressText
              : ColorManager.rejectedText,
          width: 0.5,
        ),
      ),
      child: Text(
        isActive ? "Active" : "Inactive",
        style: TextStyle(
          fontSize: widget.dimens.k11,
          fontWeight: FontWeight.w500,
          color: isActive
              ? ColorManager.progressText
              : ColorManager.rejectedText,
        ),
      ),
    );
  }

  // ── Result callbacks ─────────────────────────────────────────────────────

  @override
  void onError(String error) {
    // Data already reflected in Consumer via provider.apiResponse
    MyToast.showToast(message: error, typeToast: TypeToast.error);
  }

  @override
  void onSuccess(result) {
    // No toast needed — data is already shown via Consumer
    // Uncomment the line below only if you want a success snack/toast:
    // MyToast.showToast(message: "Loaded successfully", typeToast: TypeToast.success);
  }
}