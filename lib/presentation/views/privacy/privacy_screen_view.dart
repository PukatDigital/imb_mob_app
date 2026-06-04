import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../../base/base_widget.dart';

class PrivacyView extends BaseStateFullWidget {
   PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {

  /// Dummy data for now
  /// Later this will come from API
  final List<Map<String, dynamic>> accountPrivacyList = [
    {
      "title": "Hide Location",
      "subtitle":
      "If enable: User’s location is hidden from other users",
      "value": false,
    },
    {
      "title": "Online Status",
      "subtitle":
      "If enable: Online status is hidden and last seen is not displayed.",
      "value": false,
    },
    {
      "title": "Private Account",
      "subtitle":
      "If enable: User content remains private.",
      "value": false,
    },
  ];

  final List<Map<String, dynamic>> interactionPrivacyList = [
    {
      "title": "Massage",
      "subtitle":
      "If enable: User cannot send message",
      "value": false,
    },
    {
      "title": "Likes",
      "subtitle": "",
      "value": false,
    },
    {
      "title": "Screenshot/Recording/Share my profile",
      "subtitle":
      "If enable: Profile sharing/screenshots/recording is restricted.",
      "value": false,
    },
    {
      "title": "Say Hi",
      "subtitle":
      "If enable: User cannot send quick greetings",
      "value": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Stack(
        children: [

          /// Background
          _background(),

          SafeArea(
            child: Column(
              children: [

                widget.dimens.k10.verticalBoxPadding,

                /// Header
                _header(),

                widget.dimens.k20.verticalBoxPadding,

                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.dimens.k16,
                    ),
                    child: Column(
                      children: [

                        /// Account Section
                        _privacySection(
                          title: "Account",
                          list: accountPrivacyList,
                        ),

                        widget.dimens.k18.verticalBoxPadding,

                        /// Interaction Section
                        _privacySection(
                          title: "Interaction",
                          list: interactionPrivacyList,
                        ),

                        widget.dimens.k20.verticalBoxPadding,
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
      child: Row(
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
            "Privacy",
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

  Widget _privacySection({
    required String title,
    required List<Map<String, dynamic>> list,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k14,
        vertical: widget.dimens.k14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: widget.dimens.k6,
            offset: Offset(0, widget.dimens.k2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Section Title
          Text(
            title,
            style: TextStyle(
              fontSize: widget.dimens.k12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade500,
            ),
          ),

          widget.dimens.k12.verticalBoxPadding,

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) =>
            widget.dimens.k16.verticalBoxPadding,
            itemBuilder: (_, index) {
              return _privacyTile(
                item: list[index],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _privacyTile({
    required Map<String, dynamic> item,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Title & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                item['title'],
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              if (item['subtitle'] != null &&
                  item['subtitle'].toString().isNotEmpty) ...[

                widget.dimens.k4.verticalBoxPadding,

                Text(
                  item['subtitle'],
                  style: TextStyle(
                    fontSize: widget.dimens.k11,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ],
          ),
        ),

        widget.dimens.k10.horizontalBoxPadding,

        /// Switch
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: item['value'],

            /// Active Colors
            activeColor: ColorManager.white,
            activeTrackColor: const Color(0xffC51F28),

            /// Inactive Colors
            inactiveThumbColor: ColorManager.white,
            inactiveTrackColor: Colors.grey.shade300,

            /// Remove border/outline
            trackOutlineColor:
            WidgetStateProperty.all(Colors.transparent),

            onChanged: (value) {
              setState(() {
                item['value'] = value;
              });
            },
          ),
        ),
      ],
    );
  }
}