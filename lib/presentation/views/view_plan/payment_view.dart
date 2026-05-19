

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';

import '../../../application/common/enum.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/toast.dart';
class PaymentView extends BaseStateFullWidget {
   PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  String selectedMethod = "Jazzcash";

  final List<Map<String, dynamic>> paymentMethods = [
    {
      "title": "Jazzcash",
      "image": "assets/images/jazzcash.png",
    },
    {
      "title": "Easypaisa",
      "image": "assets/images/easypaisa.png",
    },
    {
      "title": "Other",
      "image": null,
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
                    child: Container(
                      padding: EdgeInsets.all(widget.dimens.k18),
                      decoration: BoxDecoration(
                        color: const Color(0xffF5F5F5),
                        borderRadius:
                        BorderRadius.circular(widget.dimens.k25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Your Payment Method",
                            style: TextStyle(
                              fontSize: widget.dimens.k20,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),

                          widget.dimens.k18.verticalBoxPadding,

                          ...paymentMethods.map(
                                (item) => Padding(
                              padding: EdgeInsets.only(
                                bottom: widget.dimens.k10,
                              ),
                              child: _paymentTile(item),
                            ),
                          ),

                          widget.dimens.k20.verticalBoxPadding,

                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Attachment ',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: widget.dimens.k14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text: '*',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: widget.dimens.k14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          widget.dimens.k8.verticalBoxPadding,

                          _attachmentField(),

                          widget.dimens.k20.verticalBoxPadding,

                          _bankDetailsCard(),
                          widget.dimens.k3.verticalBoxPadding,
          //  showPaymentSuccessDialog(context, widget.dimens),
                         // widget.dimens.k15.verticalBoxPadding,


                        ],
                      ),
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
            "Payments",
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
  Widget _paymentTile(Map<String, dynamic> item) {
    final bool isSelected = selectedMethod == item['title'];

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = item['title'];
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.dimens.k14,
          vertical: widget.dimens.k16,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(widget.dimens.k10),
          border: Border.all(
            color: isSelected
                ? const Color(0xffC51F28)
                : Colors.transparent,
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            if (item['image'] != null)
              Image.asset(
                item['image'],
                width: widget.dimens.k30,
                height: widget.dimens.k30,
              ),

            if (item['image'] != null)
              widget.dimens.k10.horizontalBoxPadding,

            Text(
              item['title'],
              style: TextStyle(
                fontSize: widget.dimens.k15,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _attachmentField() {
    return Container(
      height: widget.dimens.k50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.dimens.k10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(widget.dimens.k4),
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffC51F28),
              borderRadius: BorderRadius.circular(widget.dimens.k8),
            ),
            child: Center(
              child: Text(
                "Choose File",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.dimens.k12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Text(
            "No file chosen",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: widget.dimens.k13,
            ),
          ),
        ],
      ),
    );
  }
  Widget _bankDetailsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.dimens.k16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Our Bank Detail",
            style: TextStyle(
              fontSize: widget.dimens.k18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          widget.dimens.k10.verticalBoxPadding,

          Text(
            "Account Title:",
            style: TextStyle(
              fontSize: widget.dimens.k13,
              color: Colors.grey.shade600,
            ),
          ),

          widget.dimens.k2.verticalBoxPadding,

          Text(
            "Madara Uchiha",
            style: TextStyle(
              fontSize: widget.dimens.k15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),

          widget.dimens.k5.verticalBoxPadding,

          Text(
            "Account Number:",
            style: TextStyle(
              fontSize: widget.dimens.k13,
              color: Colors.grey.shade600,
            ),
          ),

          widget.dimens.k4.verticalBoxPadding,

          Text(
            "54645 65465464654",
            style: TextStyle(
              fontSize: widget.dimens.k15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          widget.dimens.k50.verticalBoxPadding,
          _submitButton(),
        ],
      ),
    );
  }
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      height: widget.dimens.k45,
      child: ElevatedButton(
        onPressed: () {
          /// Future payment submit flow
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xffD16A72),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.dimens.k30),
          ),
        ),
        child: Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.dimens.k16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
  void showPaymentSuccessDialog(BuildContext context, dynamic dimens) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimens.k24),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: dimens.k20,
          ),
          child: Padding(
            padding: EdgeInsets.all(dimens.k24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: dimens.k20,
                      color: Colors.grey,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(dimens.k10),
                  decoration: const BoxDecoration(
                    color: Color(0xff15B97A),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Assets.pVerfication, // ✅ already correct
                    height: dimens.k30,
                    width: dimens.k30,
                    fit: BoxFit.contain,
                  ),
                ),

                dimens.k20.verticalBoxPadding,

                Text(
                  'Successfully submitted',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: dimens.k24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

                dimens.k12.verticalBoxPadding,

                Text(
                  'We will notify you once your payment is verified within three working days',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: dimens.k15,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),

                dimens.k28.verticalBoxPadding,

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xffC51F28),
                      padding: EdgeInsets.symmetric(
                        vertical: dimens.k16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(dimens.k40),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back to home',
                      style: TextStyle(
                        fontSize: dimens.k16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }
  @override
  void onSuccess(String result) {
    MyToast.showToast(message: result,
        typeToast: TypeToast.success);
  }
}
