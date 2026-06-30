import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/application/routes/route_generator.dart';
import 'package:ideal_marriage_bureau/presentation/views/view_plan/plan_details_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:provider/provider.dart';
import '../../../application/common/enum.dart';
import '../../../application/common/log.dart';
import '../../../application/network/result.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/toast.dart';
import '../../../data/models/plans_model/payment_methods_list.dart';



class PaymentView extends BaseStateFullWidget {
  PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> implements ErrorResult, Result<String> {
  Data? selectedMethod;         // fully dynamic — no hardcoded default
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  List<Data> _filteredMethods = [];
  late PlansViewModel planData;
  bool get _canSubmit {
    if (selectedMethod == null || _selectedImage == null) return false;
    if (_isOtherMethod(selectedMethod) && remarksController.text.trim().isEmpty) return false;
    return true;
  }
  bool _isSubmitting = false;
  String? _selectedPlanName;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _selectedPlanName = ModalRoute.of(context)?.settings.arguments as String?;
      context.read<PlansViewModel>().getBankDetails(this);
      context.read<PlansViewModel>().getProblemList(this, searchName: "");
    });
    remarksController.addListener(() => setState(() {}));
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        _filteredMethods = List.from(
          context.read<PlansViewModel>().paymentMethodsList.data ?? [],
        );
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _removeOverlay();
    _searchFocusNode.dispose();
    searchController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = _buildOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  bool _isOtherMethod(Data? item) =>
      (item?.paymentMethod ?? "").toLowerCase() == "other";

  OverlayEntry _buildOverlayEntry() {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - (widget.dimens.k18 * 2),
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, widget.dimens.k55),
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(widget.dimens.k14),
            color: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(widget.dimens.k14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: _filteredMethods.isEmpty
                    ? [
                  Padding(
                    padding: EdgeInsets.all(widget.dimens.k16),
                    child: Text(
                      "No method found",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: widget.dimens.k14,
                      ),
                    ),
                  )
                ]
                    : _filteredMethods.map((Data item) {
                  final bool isSelected =
                      selectedMethod?.name == item.name;
                  return InkWell(
                    borderRadius:
                    BorderRadius.circular(widget.dimens.k14),
                    onTap: () {
                      setState(() {
                        selectedMethod = item;
                        searchController.text =
                            item.paymentMethod ?? "";
                        _filteredMethods = List.from(
                          context
                              .read<PlansViewModel>()
                              .paymentMethodsList
                              .data ?? [],
                        );
                        if (!_isOtherMethod(item)) {
                          _selectedImage = null;
                        }
                      });
                      _searchFocusNode.unfocus();
                      _removeOverlay();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.dimens.k16,
                        vertical: widget.dimens.k14,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xffC51F28).withOpacity(0.06)
                            : Colors.transparent,
                        borderRadius:
                        BorderRadius.circular(widget.dimens.k14),
                      ),
                      child: Row(
                        children: [
                          _methodIcon(item.bankIcon,
                              size: widget.dimens.k28),
                          widget.dimens.k12.horizontalBoxPadding,
                          Expanded(
                            child: Text(
                              item.paymentMethod ?? "",
                              style: TextStyle(
                                fontSize: widget.dimens.k15,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? const Color(0xffC51F28)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: const Color(0xffC51F28),
                              size: widget.dimens.k18,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _methodIcon(String? iconUrl, {required double size}) {
    if (iconUrl != null && iconUrl.isNotEmpty) {
      return Image.network(
        iconUrl,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => _walletIcon(size: size),
      );
    }
    return _walletIcon(size: size);
  }

  Widget _walletIcon({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.account_balance_wallet_outlined,
        size: size * 0.55,
        color: Colors.grey.shade600,
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlansViewModel>(
      builder: (_, provider, __) {
        planData = provider;
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            _removeOverlay();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                _background(),
                SafeArea(
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: widget.dimens.k18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.dimens.k10.verticalBoxPadding,
                        _header(),
                        widget.dimens.k16.verticalBoxPadding,
                        Text(
                          "Select Your Payment Method",
                          style: TextStyle(
                            fontSize: widget.dimens.k20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        widget.dimens.k10.verticalBoxPadding,
                        _searchField(),
                        widget.dimens.k10.verticalBoxPadding,
                        Expanded(
                          child: SingleChildScrollView(
                            primary: false,
                            child: Container(
                              padding: EdgeInsets.all(widget.dimens.k18),
                              decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(
                                    widget.dimens.k25),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.dimens.k18.verticalBoxPadding,
                                  if (selectedMethod != null)
                                    _paymentTile(selectedMethod!),
                                  if (_isOtherMethod(selectedMethod)) ...[
                                    widget.dimens.k10.verticalBoxPadding,
                                    _remarksField(),
                                  ],
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
                                ],
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
          ),
        );
      },
    );
  }

  Widget _searchField() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: searchController,
        focusNode: _searchFocusNode,
        onChanged: (value) {
          final allMethods =
              context.read<PlansViewModel>().paymentMethodsList.data ?? [];
          setState(() {
            _filteredMethods = allMethods
                .where((item) => (item.paymentMethod ?? "")
                .toLowerCase()
                .contains(value.toLowerCase()))
                .toList();
          });
          _removeOverlay();
          _showOverlay();
        },
        decoration: InputDecoration(
          hintText: "Search payment method...",
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey.shade500,
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.dimens.k15,
            horizontal: widget.dimens.k20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color(0xffC51F28),
              width: 1.2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
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

  Widget _remarksField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Remarks ',
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
        TextField(
          controller: remarksController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: "Enter remarks...",
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: widget.dimens.k13,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.dimens.k12,
              horizontal: widget.dimens.k14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.dimens.k10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.dimens.k10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.dimens.k10),
              borderSide:
              const BorderSide(color: Color(0xffC51F28), width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _paymentTile(Data item) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k14,
        vertical: widget.dimens.k16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.dimens.k10),
        border: Border.all(
          color: const Color(0xffC51F28),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          _methodIcon(item.bankIcon, size: widget.dimens.k30),
          widget.dimens.k10.horizontalBoxPadding,
          Expanded(
            child: Text(
              item.paymentMethod ?? "",
              style: TextStyle(
                fontSize: widget.dimens.k15,
                fontWeight: FontWeight.w600,
                color: const Color(0xffC51F28),
              ),
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xffC51F28),
            size: widget.dimens.k18,
          ),
        ],
      ),
    );
  }

  Widget _attachmentField() {
    return GestureDetector(
      onTap: () {
        _pickImage(ImageSource.gallery);
      },
      child: Container(
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
              padding: EdgeInsets.symmetric(horizontal: widget.dimens.k12),
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
            widget.dimens.k8.horizontalBoxPadding,
            Text(
              _selectedImage != null
                  ? "image_${DateTime.now().second}"
                  : "No file chosen",
              style: TextStyle(
                color: _selectedImage != null
                    ? Colors.black87
                    : Colors.grey.shade500,
                fontSize: widget.dimens.k13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
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
            planData.bankDetailsModel.data?.accountTitle ?? "",
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
            planData.bankDetailsModel.data?.accountNumber?.toString() ?? "",
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
    final isLoading = context.watch<PlansViewModel>().apiResponse is Loading;

    return SizedBox(
      width: double.infinity,
      height: widget.dimens.k45,
      child: ElevatedButton(
        onPressed: isLoading ? null : _validateAndSubmit, // always tappable
        style: ElevatedButton.styleFrom(
          backgroundColor: _canSubmit
              ? ColorManager.primary
              : ColorManager.fieldTextColor, // grey when incomplete
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.dimens.k30),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: widget.dimens.k22,
          width: widget.dimens.k22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : Text(
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
  Future<void> _submitPayment() async {
    if (_selectedImage == null || selectedMethod == null) return;

    final bytes = await _selectedImage!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final data = {
      "payment_method": selectedMethod!.paymentMethod ?? "",
      "plan": _selectedPlanName ?? "",   // adjust to your actual plan field
      "payment_remarks": remarksController.text.trim(),
      "attachment": base64Image,
    };
    d("activePlans value: ${_selectedPlanName}");
    _isSubmitting = true;
    context.read<PlansViewModel>().createPaymentRecord(data, this);
    d("activePlans value: ${_selectedPlanName}");
  }

  void showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        final dimens = widget.dimens;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimens.k24),
          ),
          insetPadding: EdgeInsets.symmetric(horizontal: dimens.k20),
          child: Padding(
            padding: EdgeInsets.all(dimens.k24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Align(
                //   alignment: Alignment.topRight,
                //   child: GestureDetector(
                //     onTap: () => Navigator.pop(context),
                //     child: Icon(Icons.close,
                //         size: dimens.k20, color: Colors.grey),
                //   ),
                // ),
                CircleAvatar(
                  radius: dimens.k25,
                  backgroundColor:  Colors.transparent,
                  child: Image.asset(
                    Assets.success,
                    height: dimens.k50,
                    width: dimens.k50,
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
                      padding: EdgeInsets.symmetric(vertical: dimens.k16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(dimens.k40),
                      ),
                    ),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteManager.rBottomBarView,
                          (route) => false, // clears entire stack
                    ),
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
  void _validateAndSubmit() {
    if (selectedMethod == null) {
      MyToast.showToast(message: "Please select a payment method");
      return;
    }
    if (_selectedImage == null) {
      MyToast.showToast(message: "Please attach a payment receipt");
      return;
    }
    if (_isOtherMethod(selectedMethod) && remarksController.text.trim().isEmpty) {
      MyToast.showToast(message: "Please enter remarks");
      return;
    }
    _submitPayment();
  }
  void _resetForm() {
    setState(() {
      selectedMethod = null;
      _selectedImage = null;
      _filteredMethods = [];
    });
    searchController.clear();
    remarksController.clear();
  }
  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    if (_isSubmitting) {
      _isSubmitting = false;
      _resetForm();
      showPaymentSuccessDialog(context);
      return;
    }
    // Set first API method as default selection after load
    final methods =
        context.read<PlansViewModel>().paymentMethodsList.data ?? [];
    if (methods.isNotEmpty && selectedMethod == null) {
      setState(() {

        _filteredMethods = List.from(methods);
      });
    }
    // MyToast.showToast(message: result, typeToast: TypeToast.success);
  }
}