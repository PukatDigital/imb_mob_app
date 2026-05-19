import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:provider/provider.dart';

import '../../../application/common/enum.dart';
import '../../../application/core/result.dart';
import '../../../widgets/toast.dart';

class PaymentHistoryView extends BaseStateFullWidget {
  PaymentHistoryView({super.key});

  @override
  State<PaymentHistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<PaymentHistoryView> implements Result<String> {

  // TODO: Replace with actual model from your ViewModel
  final List<Map<String, dynamic>> historyItems = [
    {
      "planName": "Plan Name",
      "amount": "PKR 00.00",
      "date": "03/11/26 . 06:45 PM",
      "status": "InProgress",
      "remarks": null,
    },
    {
      "planName": "Plan Name",
      "amount": "PKR 00.00",
      "date": "03/11/26 . 06:45 PM",
      "status": "Approved",
      "remarks": null,
    },
    {
      "planName": "Plan Name",
      "amount": "PKR 00.00",
      "date": "03/11/26 . 06:45 PM",
      "status": "Rejected",
      "remarks": "Test",
    },
  ];

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
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.dimens.k18,
                    ),
                    child: Column(
                      children: [
                        ...historyItems.map((item) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: widget.dimens.k12),
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
                          );
                        }),
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

  Widget _background() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
             Color(0xFFB11E24).withOpacity(.18),
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
                    color:  ColorManager.rejectedText,
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

  Widget _historyTile(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['planName'] ?? '',
                  style: TextStyle(
                    fontSize: widget.dimens.k15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                widget.dimens.k4.verticalBoxPadding,
                Text(
                  item['amount'] ?? '',
                  style: TextStyle(
                    fontSize: widget.dimens.k13,
                    color: ColorManager.textColorSubTitle,
                  ),
                ),
                if (item['remarks'] != null) ...[
                  widget.dimens.k4.verticalBoxPadding,
                  Text(
                    "Remarks:",
                    style: TextStyle(
                      fontSize: widget.dimens.k14,
                      color:ColorManager.textColor,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    item['remarks'],
                    style: TextStyle(
                      fontSize: widget.dimens.k13,
                      color: ColorManager.textColorSubTitle,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _statusBadge(item['status']),
              widget.dimens.k6.verticalBoxPadding,
              Text(
                item['date'] ?? '',
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

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    MyToast.showToast(message: result, typeToast: TypeToast.success);
  }
}