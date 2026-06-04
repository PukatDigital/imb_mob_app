import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import '../../../../base/base_widget.dart';
import '../../../constants/asset_manager.dart';


class LinkedDeviceView extends BaseStateFullWidget {
   LinkedDeviceView({super.key});

  @override
  State<LinkedDeviceView> createState() => _LinkedDeviceViewState();
}

class _LinkedDeviceViewState extends State<LinkedDeviceView> {
  final List<Map<String, dynamic>> linkedAccounts = [
    {
      "title": "Email",
      "value": "mehwishhayat@gmail.com",
      "isLinked": true,
      "icon": Assets.email,
    },
    {
      "title": "Phone Number",
      "value": "+923013455623",
      "isLinked": false,
      "icon": Assets.phone,
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
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: widget.dimens.k18,
                    ),
                    itemCount: linkedAccounts.length,
                    separatorBuilder: (_, __) =>
                    widget.dimens.k18.verticalBoxPadding,
                    itemBuilder: (_, index) {
                      final item = linkedAccounts[index];
                      return _accountTile(item);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k16, vertical: widget.dimens.k10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  size: 16,
                  color: Color(0xffB32025),
                ),
                Text(
                  "Back",
                  style: TextStyle(
                    color: Color(0xffB32025),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const Text(
            "Accounts Linked",
            style: TextStyle(
              fontSize: 18,
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
  Widget _accountTile(Map<String, dynamic> item) {
    final bool isLinked = item['isLinked'];

    return Row(
      children: [
    /// Icon Container
    Container(
    width: widget.dimens.k40,
      height: widget.dimens.k40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: widget.dimens.k6,
            offset: Offset(0, widget.dimens.k2),
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset(
          item['icon'],
          width: widget.dimens.k15,
          height: widget.dimens.k15,
          color: Colors.grey.shade600,
        ),
      ),
    ),
        widget.dimens.k8.horizontalBoxPadding,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['title'],
                style: TextStyle(
                  fontSize: widget.dimens.k13
                  ,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              widget.dimens.k4.verticalBoxPadding,
              Text(
                item['value'],
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: widget.dimens.k12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        widget.dimens.k12.horizontalBoxPadding,

       if(isLinked) GestureDetector(
          onTap: () {
            /// Future integration
            /// Link / unlink logic here

            setState(() {
              item['isLinked'] = !item['isLinked'];
              item['value'] = item['isLinked']
                  ? 'dummydata@gmail.com'
                  : 'not linked';
            });
          },
          child: CircleAvatar(
            radius: 15,
            backgroundColor:  const Color(0xFFB11E24).withOpacity(.18),

            child: Image.asset(

              Assets.linkedevice,
              width: widget.dimens.k15,
              height: widget.dimens.k15,

            ),
          ),
        ),
        widget.dimens.k5.horizontalBoxPadding,
        GestureDetector(
          onTap: () {
            /// Future integration
            /// Link / unlink logic here

            setState(() {
              item['isLinked'] = !item['isLinked'];
              item['value'] = item['isLinked']
                  ? 'dummydata@gmail.com'
                  : 'not linked';
            });
          },
          child: Container(
            padding:  EdgeInsets.symmetric(
              horizontal: widget.dimens.k22,
              vertical: widget.dimens.k10,
            ),
            decoration: BoxDecoration(
              color: isLinked
                  ? const Color(0xff701114)
                  : const Color(0xffC51F28),
              borderRadius: BorderRadius.circular(widget.dimens.k30),
            ),
            child: Text(
              isLinked ? 'Change' : 'Link',
              style:  TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: widget.dimens.k15,
              ),
            ),
          ),
        ),
]);
}}
