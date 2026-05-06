import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import '../../../application/app_theme/color_scheme.dart';
import '../../../application/routes/route_generator.dart';
import '../home/home_view.dart';

class TopTabs extends BaseStateLessWidget {
  final HomeTab selectedTab;
  final Function(HomeTab) onTabChange;

  TopTabs({
    super.key,
    required this.selectedTab,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: dimens.k16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          /// 🔹 Left side spacing (optional for balance)
          SizedBox(width: dimens.k24),

          /// 🔹 Center Tabs
          Row(
            children: [
              GestureDetector(
                onTap: () => onTabChange(HomeTab.matched),
                child: TabItem(
                  title: "Matched",
                  isSelected: selectedTab == HomeTab.matched,
                ),
              ),
              dimens.k20.horizontalBoxPadding,
              GestureDetector(
                onTap: () => onTabChange(HomeTab.forYou),
                child: TabItem(
                  title: "For You",
                  isSelected: selectedTab == HomeTab.forYou,
                ),
              ),
            ],
          ),

          /// 🔹 Notification Icon (Right Side Same Line)
          GestureDetector(
            onTap: () {
              navigator.pushNamed(RouteManager.rNotificationListView);
            },
            child: CircleAvatar(
              backgroundColor: ColorManager.white.withOpacity(.15),
              radius: dimens.k24,
              child: Icon(
                Icons.notifications_none,
                color: Colors.white,
                size: dimens.k26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabItem extends BaseStateLessWidget {
  final String title;
  final bool isSelected;

   TabItem({super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style:  TextStyle(
            color: Colors.white,
            fontSize: dimens.k16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isSelected)
          Container(
            margin:  EdgeInsets.only(top: dimens.k4),
            height: dimens.k2,
            width: dimens.k30,
            color: Colors.white,
          ),
      ],
    );
  }
}
