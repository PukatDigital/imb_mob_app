import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/presentation/views/view_plan/payment_view.dart';
import 'package:provider/provider.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/primary_button.dart';
import '../auth/auth_view_model.dart';

class PlanView extends BaseStateFullWidget {
  PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> implements Result<String> {
  late AuthViewModel authVM;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (_, provider, __) {
        authVM = provider;

        return Scaffold(
          backgroundColor: ColorManager.liteWhite,
          body: Column(
            children: [
              _headerSection(),
              Expanded(                          // ✅ fixes scaffold body overflow
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
                Navigator.pop(context);
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
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.dimens.k15),
        child: Row(
          children: [
            _planCard(
              title: "Starter",
              credits: "200",
              price: "2,000 PKR",
              effectivePrice: "10 PKR / credit",
              isBestValue: false,
            ),
            _planCard(
              title: "Premium",
              credits: "500",
              price: "4,500 PKR",
              effectivePrice: "9 PKR / credit",
              isBestValue: true,
            ),
            _planCard(
              title: "Elite",
              credits: "1000",
              price: "8,000 PKR",
              effectivePrice: "8 PKR / credit",
              isBestValue: false,
            ),
          ],
        ),
      ),
    );
  }

  // ================= PLAN CARD =================

  Widget _planCard({
    required String title,
    required String credits,
    required String price,
    required String effectivePrice,
    required bool isBestValue,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.85,
      margin: EdgeInsets.only(right: size.width * 0.04,),
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.05,
        vertical: size.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title + Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "$title — $credits Credits",
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (isBestValue)
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ColorManager.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "⭐ Best Value",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),

          widget.dimens.k15.verticalBoxPadding,

          /// Price
          Text(
            price,
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorManager.primary,
            ),
          ),

          widget.dimens.k8.verticalBoxPadding,

          Text(
            "Effective price: $effectivePrice",
            style: context.textTheme.bodySmall?.copyWith(
              color: ColorManager.fieldHintColor,
            ),
          ),

          widget.dimens.k15.verticalBoxPadding,

          /// Features
          Text(
            "Features",
            style: context.textTheme.titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),

          widget.dimens.k10.verticalBoxPadding,

          _featureItem("+10 bonus credits included"),
          _featureItem("Profile boost included"),
          _featureItem("Better visibility in search"),
          _featureItem("Serious user advantage"),

          SizedBox(height: size.height * 0.015),

          PrimaryButton(
            height: widget.dimens.k40,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      PaymentView(),
                ),
              );
              // TODO: Purchase logic
            },
            childText: "Get $credits Credits",
            issquare: false,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }

  Widget _featureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 16,
            color: ColorManager.primary,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  // ================= RESULT METHODS =================

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    MyToast.showToast(message: "Plan Activated Successfully!");
  }
}
