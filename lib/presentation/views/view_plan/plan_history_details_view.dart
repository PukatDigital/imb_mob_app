import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/common/enum.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../base/base_widget.dart';
import '../../../data/models/plans_model/payment_list_model.dart';
import '../../../widgets/toast.dart';
import 'plan_details_view_model.dart';
class PaymentHistoryDetailView extends BaseStateFullWidget {
  final PaymentData payment;
   PaymentHistoryDetailView({super.key, required this.payment});

  @override
  State<PaymentHistoryDetailView> createState() => _PaymentHistoryDetailViewState();
}

class _PaymentHistoryDetailViewState extends State<PaymentHistoryDetailView>
    implements Result {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.payment.plan != null) {
        context.read<PlansViewModel>().getPlanListDetails(
          this,
          planId: widget.payment.plan!,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.liteGrey,
      body: Stack(
        children: [
          _background(),
          SafeArea(
            child: Column(
              children: [
                _header(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(widget.dimens.k18),
                    child: Column(
                      children: [
                        // ── Response Card ──────────────────────────────
                        if (widget.payment.status == 'Rejected')
                          _responseCard(),
                        //widget.dimens.k12.verticalBoxPadding,
                        // ── Submission Card ────────────────────────────
                        _submissionCard(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _responseCard() {
    final status = widget.payment.status ?? '';

    Color bgColor;
    switch (status) {
      case 'Approved':
        bgColor = ColorManager.approveBg;
        break;
      case 'Rejected':
        bgColor = ColorManager.rejectedText.withOpacity(0.08);
        break;
      default:
        bgColor = ColorManager.progressBg;
        break;
    }

    return Consumer<PlansViewModel>(
      builder: (context, vm, _) {
        final data = vm.plansListDetailsModel?.data;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(widget.dimens.k16),
          decoration: BoxDecoration(
            color: bgColor, // ✅ status-based color
           // borderRadius: BorderRadius.circular(widget.dimens.k15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Response",
                    style: TextStyle(
                      fontSize: widget.dimens.k15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(widget.payment.creation),
                    style: TextStyle(
                      fontSize: widget.dimens.k11,
                      color: ColorManager.textColorSubTitle,
                    ),
                  ),
                ],
              ),
              widget.dimens.k12.verticalBoxPadding,
              Row(
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                      fontSize: widget.dimens.k13,
                      color: ColorManager.textColorSubTitle,
                    ),
                  ),
                  const Spacer(),
                  _statusBadge(status),
                ],
              ),
              if (data?.description != null && data!.description!.isNotEmpty) ...[
                widget.dimens.k12.verticalBoxPadding,
                Text(
                  "Remark:",
                  style: TextStyle(
                    fontSize: widget.dimens.k13,
                    color: ColorManager.textColorSubTitle,
                  ),
                ),
                widget.dimens.k4.verticalBoxPadding,
                Text(
                  _stripHtml(data.description),
                  style: TextStyle(
                    fontSize: widget.dimens.k14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _submissionCard() {
    return Consumer<PlansViewModel>(
      builder: (context, vm, _) {
        final data = vm.plansListDetailsModel?.data;
        return _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────
              Row(
                children: [
                  Text(
                    "Submission",
                    style: TextStyle(
                      fontSize: widget.dimens.k15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(widget.payment.creation),
                    style: TextStyle(
                      fontSize: widget.dimens.k11,
                      color: ColorManager.textColorSubTitle,
                    ),
                  ),
                ],
              ),
              widget.dimens.k15.verticalBoxPadding,
              // ── Request ID ──────────────────────────────────────────
              _rowItem("Request ID", widget.payment.name ?? ''),
              widget.dimens.k15.verticalBoxPadding,
              // ── Remark ──────────────────────────────────────────────

                Text(
                  "Remark",
                  style: TextStyle(
                      fontSize: widget.dimens.k15,
                      color: ColorManager.textColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                widget.dimens.k4.verticalBoxPadding,
              Text(
                (widget.payment.remarks != null && widget.payment.remarks!.isNotEmpty)
                    ? widget.payment.remarks!
                    : "N/A",
                style: TextStyle(
                    fontSize: widget.dimens.k14,
                    color: ColorManager.textColorSubTitle,
                    fontWeight: FontWeight.w600
                ),
              ),
                widget.dimens.k15.verticalBoxPadding,
              // ── Plan info (from API) ─────────────────────────────────
              if (vm.apiResponse is Loading)
                const Center(child: CircularProgressIndicator())
              else if (data != null) ...[
                Text(
                  "${data.planType ?? ''} — ${data.bonus ?? 0} Credits",
                  style: TextStyle(
                    fontSize: widget.dimens.k14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                widget.dimens.k10.verticalBoxPadding,
                Text(
                  "${data.effectivePrice ?? 0} PKR",
                  style: TextStyle(
                    fontSize: widget.dimens.k15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                widget.dimens.k10.verticalBoxPadding,
                Text(
                  "Features",
                  style: TextStyle(
                      fontSize: widget.dimens.k15,
                      color: ColorManager.textColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
                widget.dimens.k4.verticalBoxPadding,
                Text(
              _stripHtml(data.description),
                  style: TextStyle(
                    fontSize: widget.dimens.k13,
                    color: Colors.black87,
                  ),
                ),
                widget.dimens.k15.verticalBoxPadding,
              ],
              // ── Attachment ──────────────────────────────────────────
              if (widget.payment.attachment != null &&
                  widget.payment.attachment!.isNotEmpty)
                _attachmentTile(widget.payment.attachment!),
            ],
          ),
        );
      },
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.dimens.k16),
      decoration: BoxDecoration(
        color: Colors.white,
       // borderRadius: BorderRadius.circular(widget.dimens.k15),
      ),
      child: child,
    );
  }

  Widget _rowItem(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: widget.dimens.k15,
            color: ColorManager.textColor,
            fontWeight: FontWeight.w600
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: widget.dimens.k13,
            fontWeight: FontWeight.w500,
            color: ColorManager.textColorSubTitle,
          ),
        ),
      ],
    );
  }

  Widget _attachmentTile(String url) {
    final fileName = url.split('/').last;
    final apiKey = widget.iPrefHelper.loginModel?.data?.user?.apiKey ?? '';
    final apiSecret = widget.iPrefHelper.loginModel?.data?.user?.apiSecret ?? '';
    final token = "$apiKey:$apiSecret";

    return GestureDetector(
      onTap: () => _showImagePreview(url, token),
      child: Container(
        padding: EdgeInsets.all(widget.dimens.k12),
        decoration: BoxDecoration(
          color: ColorManager.liteGrey,
          borderRadius: BorderRadius.circular(widget.dimens.k10),
        ),
        child: Row(
          children: [
            Icon(Icons.image_outlined,
                color: ColorManager.rejectedText, size: widget.dimens.k24),
            widget.dimens.k10.horizontalBoxPadding,
            Expanded(
              child: Text(
                fileName,
                style: TextStyle(fontSize: widget.dimens.k13, color: Colors.black87),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _stripHtml(String? html) {
    if (html == null || html.isEmpty) return '';
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }
  void _showImagePreview(String url, String token) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.dimens.k16),
              child: Image.network(
                url,
                headers: {"Authorization": "token $token"},
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: widget.dimens.k8,
              right: widget.dimens.k8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(widget.dimens.k6),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: widget.dimens.k20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.dimens.k18, vertical: widget.dimens.k16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios,
                    size: widget.dimens.k16, color: ColorManager.rejectedText),
                Text(
                  "Back",
                  style: TextStyle(
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
                "History Detail",
                style: TextStyle(
                  fontSize: widget.dimens.k18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: widget.dimens.k40),
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
      default:
        bgColor = ColorManager.progressBg;
        textColor = ColorManager.progressText;
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: widget.dimens.k10, vertical: widget.dimens.k4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
      ),
      child: Text(
        status,
        style: TextStyle(
            fontSize: widget.dimens.k11,
            fontWeight: FontWeight.w500,
            color: textColor),
      ),
    );
  }

  String _formatDate(String? raw) {
    if (raw == null) return '';
    try {
      final dt = DateTime.parse(raw);
      final date =
          "${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}/${dt.year.toString().substring(2)}";
      final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour == 0 ? 12 : dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return "$date · ${hour.toString().padLeft(2, '0')}:$minute $period";
    } catch (_) {
      return raw ?? '';
    }
  }

  @override
  void onError(String error) =>
      MyToast.showToast(message: error, typeToast: TypeToast.error);

  @override
  void onSuccess(result) {}
}