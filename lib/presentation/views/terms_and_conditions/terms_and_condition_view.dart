import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../base/base_widget.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../auth/auth_view_model.dart';

class TermsAndConditionsView extends BaseStateFullWidget {
  TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() =>
      _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState extends State<TermsAndConditionsView> implements ErrorResult{
  bool isChecked = false;
  final ScrollController _scrollController = ScrollController();

  // ── grab your ViewModel (adjust to your base class pattern) ──
  late final AuthViewModel _vm;

  @override
  void initState() {
    super.initState();
    // Replace with however you access your ViewModel

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().getTermsAndConditions(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.dimens.k10.verticalBoxPadding,
                _header(),
                widget.dimens.k18.verticalBoxPadding,

                /// Terms Content — takes all remaining space
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.dimens.k16,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(widget.dimens.k20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(widget.dimens.k20),
                              child: _buildContent(),
                            ),
                          ),
                        ),
                      ),

                      /// Up / Down scroll buttons
                      Positioned(
                        right: widget.dimens.k24,
                        bottom: widget.dimens.k16,
                        child: Column(
                          children: [
                            _scrollButton(
                              icon: Icons.keyboard_arrow_up,
                              onTap: () => _scrollController.animateTo(
                                _scrollController.offset - 150,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                            ),
                            SizedBox(height: widget.dimens.k6),
                            _scrollButton(
                              icon: Icons.keyboard_arrow_down,
                              onTap: () => _scrollController.animateTo(
                                _scrollController.offset + 150,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //
                // _bottomSection(),
                widget.dimens.k14.verticalBoxPadding,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Content: loading / error / HTML ───────────────────────────────────────

  Widget _buildContent() {
    return Consumer<AuthViewModel>(
      builder: (context, provider, child) {
        final response = provider.apiResponse;

        // Loading state
        if (response is Loading) {
          return const Center(child: CircularProgressIndicator());
        }



        // Success — render HTML
        final htmlContent =
            provider.termsAndConditions.data?.termsAndConditions ?? '';

        return Scrollbar(
          thumbVisibility: true,
          controller: _scrollController,
          radius: Radius.circular(widget.dimens.k20),
          thickness: 4,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(widget.dimens.k16),
            child:
            Html(
              data: htmlContent,
              style: {
                'body': Style(
                  fontSize: FontSize(widget.dimens.k13),
                  color: const Color(0xFF1F1E33),
                  lineHeight: LineHeight(1.6),
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                ),
                'h2': Style(
                  fontSize: FontSize(widget.dimens.k18),
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F1E33),
                  margin: Margins.only(bottom: 8),
                ),
                'strong': Style(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F1E33),
                ),
                'ol': Style(
                  margin: Margins.only(left: 16, top: 4, bottom: 8),
                ),
                'li': Style(
                  fontSize: FontSize(widget.dimens.k12),
                  color: const Color(0xFF1F1E33),
                  lineHeight: LineHeight(1.6),
                  margin: Margins.only(bottom: 4),
                ),
                'p': Style(
                  margin: Margins.only(bottom: 10),
                  fontSize: FontSize(widget.dimens.k12),
                  color: Colors.grey.shade700,
                  lineHeight: LineHeight(1.5),
                ),
                'a': Style(
                  color: const Color(0xFF4469F3),
                  textDecoration: TextDecoration.underline,
                ),
              },
            ),
          ),
        );
      },
    );
  }

  // ─── Helpers ───────────────────────────────────────────────────────────────

  Widget _scrollButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(widget.dimens.k8),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: widget.dimens.k20, color: Colors.black87),
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
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k16,
        vertical: widget.dimens.k10,
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios,
                        size: widget.dimens.k16,
                        color: const Color(0xffB32025)),
                    Text(
                      "Back",
                      style: TextStyle(
                        color: const Color(0xffB32025),
                        fontSize: widget.dimens.k16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                "Terms and Conditions",
                style: TextStyle(
                  fontSize: widget.dimens.k17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              SizedBox(width: widget.dimens.k40),
            ],
          ),
          widget.dimens.k4.verticalBoxPadding,
          Text(
            "Please read carefully before proceeding",
            style: TextStyle(
              fontSize: widget.dimens.k11,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _bottomSection() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: ColorManager.white,
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.08),
  //           blurRadius: 12,
  //           offset: const Offset(0, -4),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
  //         Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: widget.dimens.k16,
  //             vertical: widget.dimens.k12,
  //           ),
  //           child: Row(
  //             children: [
  //               Expanded(
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   children: [
  //                     Transform.scale(
  //                       scale: 0.9,
  //                       child: Checkbox(
  //                         value: isChecked,
  //                         activeColor: const Color(0xffC51F28),
  //                         side: BorderSide(color: Colors.grey.shade400),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                         onChanged: (value) {
  //                           setState(() => isChecked = value ?? false);
  //                         },
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Text(
  //                         "I have read and agree to the\nTerm and Conditions",
  //                         style: TextStyle(
  //                           fontSize: widget.dimens.k11,
  //                           color: Colors.black87,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               widget.dimens.k12.horizontalBoxPadding,
  //               GestureDetector(
  //                 onTap: isChecked ? () { /* navigate next */ } : null,
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(
  //                     horizontal: widget.dimens.k22,
  //                     vertical: widget.dimens.k14,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     // Dims the button when checkbox is unchecked
  //                     color: isChecked
  //                         ? const Color(0xffC51F28)
  //                         : const Color(0xffC51F28).withOpacity(0.4),
  //                     borderRadius: BorderRadius.circular(widget.dimens.k30),
  //                   ),
  //                   child: Text(
  //                     "Agree & Continue",
  //                     style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.w600,
  //                       fontSize: widget.dimens.k14,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  @override
  onError(String error) {
    // TODO: implement onError
    throw UnimplementedError();
  }
}