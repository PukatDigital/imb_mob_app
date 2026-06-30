import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/view_plan/plan_details_view_model.dart';

import 'package:provider/provider.dart';

import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../application/routes/route_generator.dart';
import '../../../data/models/plans_model/payment_list_model.dart';
import '../../../widgets/toast.dart';


class PaymentHistoryView extends BaseStateFullWidget {
  PaymentHistoryView({super.key});

  @override
  State<PaymentHistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<PaymentHistoryView> implements ErrorResult {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlansViewModel>().getPaymentListData(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _background(),
          SafeArea(
            child: Column(
              children: [
                widget.dimens.k10.verticalBoxPadding,
                _header(),
                widget.dimens.k25.verticalBoxPadding,
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Consumer<PlansViewModel>(
      builder: (context, vm, _) {

        // ── Loading ──────────────────────────────────────────────────────
        if (vm.apiResponse is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // ── Empty ────────────────────────────────────────────────────────
        final list = vm.paymentListModel.data ?? [];
        if (list.isEmpty) {
          return Center(
            child: Text(
              "No payment history found.",
              style: TextStyle(
                fontSize: widget.dimens.k14,
                color: ColorManager.textColorSubTitle,
              ),
            ),
          );
        }

        // ── Success ──────────────────────────────────────────────────────
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: widget.dimens.k18),
          child: Column(
            children: list.map((item) {
              // In _buildBody(), replace the existing Container with this:

              return Padding(
                padding: EdgeInsets.only(bottom: widget.dimens.k12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteManager.rPlanListDetails,
                      arguments: item,
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(widget.dimens.k16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(widget.dimens.k15),
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                    child: _historyTile(item),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _historyTile(PaymentData item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ── Left: plan + payment method + ref ───────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.plan ?? 'N/A',
                  style: TextStyle(
                    fontSize: widget.dimens.k15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                widget.dimens.k4.verticalBoxPadding,
                Text(
                  item.paymentMethod ?? '',
                  style: TextStyle(
                    fontSize: widget.dimens.k13,
                    color: ColorManager.textColorSubTitle,
                  ),
                ),
                if (item.name != null) ...[
                  widget.dimens.k4.verticalBoxPadding,
                  Text(
                    "Ref:",
                    style: TextStyle(
                      fontSize: widget.dimens.k14,
                      color: ColorManager.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    item.name!,
                    style: TextStyle(
                      fontSize: widget.dimens.k13,
                      color: ColorManager.textColorSubTitle,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // ── Right: status badge + date ───────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _statusBadge(item.status ?? ''),
              widget.dimens.k6.verticalBoxPadding,
              Text(
                _formatDate(item.creation),
                style: TextStyle(
                  fontSize: widget.dimens.k11,
                  color: ColorManager.textColorSubTitle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String _formatDate(String? raw) {
    if (raw == null) return '';
    try {
      final dt = DateTime.parse(raw);
      final date =
          "${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}/${dt.year.toString().substring(2)}";
      final hour =
      dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return "$date · ${hour.toString().padLeft(2, '0')}:$minute $period";
    } catch (_) {
      return raw;
    }
  }

  Widget _statusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Approved':
        bgColor = ColorManager.approveBg;
        textColor = ColorManager.approvedText;
        break;
      case 'Rejected':
        bgColor = ColorManager.rejectedBg;
        textColor = ColorManager.rejectedText;
        break;
      case 'InProgress':
      default:
        bgColor = ColorManager.progressBg;
        textColor = ColorManager.progressText;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k10,
        vertical: widget.dimens.k4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: widget.dimens.k11,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
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

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k16),
      child: Row(
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
                  style: TextStyle(
                    color: ColorManager.rejectedText,
                    fontSize: widget.dimens.k16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "History",
            style: TextStyle(
              fontSize: widget.dimens.k18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          SizedBox(width: widget.dimens.k40),
        ],
      ),
    );
  }

  // ── ErrorResult implementation ───────────────────────────────────────────

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

}