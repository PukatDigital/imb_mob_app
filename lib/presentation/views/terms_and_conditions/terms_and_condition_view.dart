import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../../base/base_widget.dart';

class TermsAndConditionsView extends BaseStateFullWidget {
   TermsAndConditionsView({super.key});

  @override
  State<TermsAndConditionsView> createState() =>
      _TermsAndConditionsViewState();
}

class _TermsAndConditionsViewState
    extends State<TermsAndConditionsView> {

  bool isChecked = false;
  final ScrollController _scrollController = ScrollController();

  /// Dummy data for now
  /// Later this will come from API
  final List<Map<String, dynamic>> termsList = [
    {
      "title": "1. ACCEPTANCE OF TERMS",
      "description":
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, nisl a mattis pulvinar, quam nisi molestie lacus, vel posuere justo arcu vitae enim. Integer efficitur porttitor velit eu rutrum. Praesent sed congue elit. Praesent auctor metus quis dolor feugiat, at laoreet nisi facilisis.",
    },
    {
      "title": "2. USE OF THE APP",
      "description":
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, nisl a mattis pulvinar, quam nisi molestie lacus, vel posuere justo arcu vitae enim. Integer efficitur porttitor velit eu rutrum. Praesent sed congue elit. Praesent auctor metus quis dolor feugiat, at laoreet nisi facilisis.",
    },
    {
      "title": "3. USER ACCOUNT",
      "description":
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, nisl a mattis pulvinar, quam nisi molestie lacus, vel posuere justo arcu vitae enim. Integer efficitur porttitor velit eu rutrum. Praesent sed congue elit. Praesent auctor metus quis dolor feugiat, at laoreet nisi facilisis.",
    },
    {
      "title": "4. PRIVACY POLICY",
      "description":
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, nisl a mattis pulvinar, quam nisi molestie lacus, vel posuere justo arcu vitae enim. Integer efficitur porttitor velit eu rutrum. Praesent sed congue elit. Praesent auctor metus quis dolor feugiat, at laoreet nisi facilisis.",
    },
    {
      "title": "5. LIMITATION OF LIABILITY",
      "description":
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tincidunt, nisl a mattis pulvinar, quam nisi molestie lacus, vel posuere justo arcu vitae enim. Integer efficitur porttitor velit eu rutrum. Praesent sed congue elit. Praesent auctor metus quis dolor feugiat, at laoreet nisi facilisis.",
    },
  ];
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
                              borderRadius: BorderRadius.circular(widget.dimens.k20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(widget.dimens.k20),
                              child: Scrollbar(
                                thumbVisibility: true,
                                controller: _scrollController,
                                radius: Radius.circular(widget.dimens.k20),
                                thickness: 4,
                                child: ListView.builder(
                                  controller: _scrollController,
                                  padding: EdgeInsets.all(widget.dimens.k16),
                                  itemCount: termsList.length,
                                  itemBuilder: (context, index) {
                                    final item = termsList[index];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: widget.dimens.k18),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['title'],
                                            style: TextStyle(
                                              fontSize: widget.dimens.k14,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          widget.dimens.k8.verticalBoxPadding,
                                          Text(
                                            item['description'],
                                            style: TextStyle(
                                              fontSize: widget.dimens.k12,
                                              color: Colors.grey.shade700,
                                              height: 1.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /// Up/Down buttons
                      Positioned(
                        right: widget.dimens.k24,
                        bottom: widget.dimens.k16,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                  _scrollController.offset - 150,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
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
                                child: Icon(Icons.keyboard_arrow_up,
                                    size: widget.dimens.k20, color: Colors.black87),
                              ),
                            ),
                            SizedBox(height: widget.dimens.k6),
                            GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                  _scrollController.offset + 150,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
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
                                child: Icon(Icons.keyboard_arrow_down,
                                    size: widget.dimens.k20, color: Colors.black87),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// Bottom Section
                  _bottomSection(),
                widget.dimens.k14.verticalBoxPadding,
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
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k16,
        vertical: widget.dimens.k10,
      ),
      child: Column(
        children: [

          Row(
            children: [

              /// Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      size: widget.dimens.k16,
                      color: const Color(0xffB32025),
                    ),

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

              /// Title
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

  Widget _bottomSection() {
    return Container(
      //height: widget.dimens.k150,
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(color: Colors.grey.shade200, thickness: 1, height: 1),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k16,
              vertical: widget.dimens.k12,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.scale(
                        scale: 0.9,
                        child: Checkbox(
                          value: isChecked,
                          activeColor: const Color(0xffC51F28),
                          side: BorderSide(color: Colors.grey.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "I have read and agree to the\nTerm and Conditions",
                          style: TextStyle(
                            fontSize: widget.dimens.k11,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                widget.dimens.k12.horizontalBoxPadding,
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.dimens.k22,
                      vertical: widget.dimens.k14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffC51F28),
                      borderRadius: BorderRadius.circular(widget.dimens.k30),
                    ),
                    child: Text(
                      "Agree & Continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: widget.dimens.k14,
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
}