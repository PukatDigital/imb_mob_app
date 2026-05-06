import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import '../auth/auth_view_model.dart';

class NotificationListView extends BaseStateFullWidget {
  NotificationListView({super.key});

  @override
  State<NotificationListView> createState() => _NotificationListViewState();
}

class _NotificationListViewState extends State<NotificationListView>
    implements Result<String> {

  late AuthViewModel authVM;

  // Demo Data with Dates
  final List<Map<String, dynamic>> notifications = [
    {
      "name": "New Message",
      "message": "You’ve received a new message from Maryam.",
      "image": Assets.home2,
      "date": DateTime.now(),
    },
    {
      "name": "Profile Viewed",
      "message": "Someone viewed your profile.",
      "image": Assets.home2,
      "date": DateTime.now(),
    },
    {
      "name": "Match Request",
      "message": "Ali sent you a match request.",
      "image": Assets.home2,
      "date": DateTime(2025, 11, 20),
    },
    {
      "name": "Subscription",
      "message": "Your subscription will expire soon.",
      "image": Assets.home2,
      "date": DateTime(2025, 11, 20),
    },
  ];

  Map<String, List<Map<String, dynamic>>> groupedNotifications = {};

  @override
  void initState() {
    super.initState();
    _groupNotifications();
  }

  void _groupNotifications() {
    groupedNotifications.clear();

    for (var item in notifications) {
      DateTime date = item["date"];

      String key;

      if (_isToday(date)) {
        key = "Today";
      } else {
        key = DateFormat("MMM dd, yyyy").format(date);
      }

      if (!groupedNotifications.containsKey(key)) {
        groupedNotifications[key] = [];
      }

      groupedNotifications[key]!.add(item);
    }
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (_, provider, __) {
        authVM = provider;
        return Scaffold(
          backgroundColor: Colors.white,
          body: _mainContent(),
        );
      },
    );
  }

  Widget _mainContent() {
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
      child: Padding(
        padding: EdgeInsets.all(widget.dimens.k15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.dimens.k40.verticalBoxPadding,
            _header(),
            Expanded(child: _notificationList()),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            "Notification",
            style: TextStyle(
              fontSize: widget.dimens.k18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: widget.dimens.k22,
              color: ColorManager.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _notificationList() {
    return ListView(
      padding: EdgeInsets.zero,
      children: groupedNotifications.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Title (Today / Date)
            Padding(
              padding: EdgeInsets.symmetric(vertical: widget.dimens.k10),
              child: Text(
                entry.key,
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.fieldTextColor,
                ),
              ),
            ),

            // Notifications under that section
            ...entry.value.map((item) => _notificationTile(item)),
          ],
        );
      }).toList(),
    );
  }

  Widget _notificationTile(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k10),
      child: Row(
        children: [
          CircleAvatar(
            radius: widget.dimens.k20,
            backgroundImage: AssetImage(item["image"]),
          ),

          widget.dimens.k12.horizontalBoxPadding,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.dimens.k17,
                    color: ColorManager.textColor,
                  ),
                ),
                widget.dimens.k4.verticalBoxPadding,
                Text(
                  item["message"],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorManager.fieldTextColor,
                  ),
                ),
                Text(
                  DateFormat("hh:mm a").format(item["date"]),
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: widget.dimens.k11,
                    color: ColorManager.fieldTextColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,size:widget.dimens.k17 ,color: ColorManager.fieldTextColor,)

        ],
      ),
    );
  }

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    MyToast.showToast(message: result);
  }
}
