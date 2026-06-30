import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ideal_marriage_bureau/presentation/views/view_plan/payment_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/view_plan/plan_details_view_model.dart';
import 'package:provider/provider.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../application/network/result.dart';
import '../../../application/routes/route_generator.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/primary_button.dart';
import '../../../../data/models/plans_model/paln_details_model.dart';

class PlanView extends BaseStateFullWidget {
  PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> implements ErrorResult {
  late PlansViewModel plansVM;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlansViewModel>().getAllPlans(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<PlansViewModel>(
      builder: (_, provider, __) {
        plansVM = provider;

        return Scaffold(
          backgroundColor: ColorManager.liteWhite,
          body: Column(
            children: [
              _headerSection(),
              Expanded(
                child: _plansSection(),
              ),
            ],
          ),
        );
      },
    );
  }

  // ================= HEADER =================

  Widget _headerSection() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.50,
      width: size.width,
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k20,
        vertical: widget.dimens.k20,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.upgradePremium),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              icon: Icon(
                Icons.clear,
                color: ColorManager.white,
                size: widget.dimens.k25,
              ),
            ),
          ),
          const Spacer(),
          Text(
            "Upgrade to Premium",
            style: context.textTheme.titleLarge?.copyWith(
              color: ColorManager.textColor,
              fontWeight: FontWeight.w600,
              fontSize: widget.dimens.k24,
            ),
          ),
          widget.dimens.k8.verticalBoxPadding,
          Text(
            "Boost your visibility and unlock all exclusive features.",
            style: context.textTheme.bodyMedium?.copyWith(
              color: ColorManager.textColor,
              fontWeight: FontWeight.w400,
              fontSize: widget.dimens.k18,
            ),
          ),
        ],
      ),
    );
  }

  // ================= PLANS SECTION =================

  Widget _plansSection() {
    final List<Data> plans = plansVM.activePlans.data ?? [];

    if (plansVM.apiResponse is Loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (plans.isEmpty) {
      return const Center(child: Text("No plans available"));
    }

    return SizedBox(
      height: 450,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.dimens.k15),
        child: Row(
          children: plans
              .map((plan) => _planCard(plan: plan))
              .toList(),
        ),
      ),
    );
  }

  // ================= PLAN CARD =================

  Widget _planCard({required Data plan}) {
    final size = MediaQuery.of(context).size;

    // ✅ Mark "best value" if planType contains 'best' or 'popular'
    final isBestValue =
        (plan.planType ?? '').toLowerCase().contains('best') ||
            (plan.planType ?? '').toLowerCase().contains('popular');

    return Container(
      width: size.width * 0.85,
      margin: EdgeInsets.only(right: size.width * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          /// ── Title + Badge ──
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Expanded(
              //   child: Text(
              //     plan.title ?? '',
              //     style: context.textTheme.titleMedium?.copyWith(
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              if (isBestValue)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "⭐ ${plan.planType ?? 'Best Value'}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          // widget.dimens.k15.verticalBoxPadding,
          //
          // /// ── Price ──
          // Text(
          //   "${plan.amount ?? 0} PKR",
          //   style: context.textTheme.titleLarge?.copyWith(
          //     fontWeight: FontWeight.bold,
          //     color: ColorManager.primary,
          //   ),
          // ),
          // widget.dimens.k8.verticalBoxPadding,
          // Text(
          //   "Effective price: ${plan.effectivePrice ?? 0} PKR / credit",
          //   style: context.textTheme.bodySmall?.copyWith(
          //     color: ColorManager.fieldHintColor,
          //   ),
          // ),
          // widget.dimens.k10.verticalBoxPadding,
          //
          // /// ── Bonus Credits ──
          // if ((plan.bonus ?? 0) > 0)
          //   Text(
          //     "+${plan.bonus} bonus credits included",
          //     style: context.textTheme.bodySmall?.copyWith(
          //       color: ColorManager.primary,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),

          widget.dimens.k10.verticalBoxPadding,

          /// ── HTML Description ──
          if (plan.description != null && plan.description!.isNotEmpty)
            SizedBox(
              height: 240, // apni requirement ke mutabiq
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Html(
                    data: plan.description!,
                    style: {
                      "p": Style(
                        fontSize: FontSize(13),
                        color: ColorManager.fieldHintColor,
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "strong": Style(
                        fontWeight: FontWeight.w600,
                        color: ColorManager.textColor,
                      ),
                      "div": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "body": Style(
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                    },
                  ),
                ),
              ),
            ),

          SizedBox(height: size.height * 0.015),

          /// ── CTA Button ──
          PrimaryButton(
            height: widget.dimens.k40,
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteManager.rPaymentView,
                arguments: plan.name,
              );
            },
            childText: "Get ${plan.credits ?? 'Plan'} cr- ${plan.planType}",
            issquare: false,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }

  // ================= ERROR HANDLER =================

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }
}