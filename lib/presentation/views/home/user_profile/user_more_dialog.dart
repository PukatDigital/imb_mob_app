import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/user_profile/block_user_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/user_profile/report_user_view.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../base/base_widget.dart';

import '../../../../application/core/result.dart';
import '../../../../constants/asset_manager.dart';

class UserMoreDialogView extends BaseStateFullWidget {
  final String userName;
  final String userId;
  UserMoreDialogView({super.key, required this.userName,required this.userId});
  @override
  State<UserMoreDialogView> createState() => _UserMoreDialogViewState();
}
class _UserMoreDialogViewState extends State<UserMoreDialogView>
    implements Result {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.dimens.k15.verticalBoxPadding,

          _label("Share this profile", Assets.shareIcon, () async {
            Navigator.pop(context);

            final String profileLink =
                "https://yourapp.com/profile/${widget.userName}";

            await Share.share(
              "Check out this profile on Ideal Marriage Bureau:\n\n"
                  "${widget.userName}\n\n"
                  "$profileLink",
            );
          }),


          _divider(),

          _label("Block", Assets.blockIcon, () {
            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent, // keep transparent if you want rounded corners
              isDismissible: true,
              enableDrag: true,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    // This ensures taps outside the inner container dismiss the sheet
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.transparent, // outer layer to catch taps
                    child: GestureDetector(
                      onTap: () {}, // inner container ignores taps
                      child: BlockUserView(
                        userName: widget.userName,
                        userId:widget.userId,
                      ), // your sheet content
                    ),
                  ),
                );
              },
            );
          }),



          _divider(),

          _label("Report", Assets.reportIcon, () {

            Navigator.pop(context);
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent, // keep transparent if you want rounded corners
              isDismissible: true,
              enableDrag: true,
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    // This ensures taps outside the inner container dismiss the sheet
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    color: Colors.transparent, // outer layer to catch taps
                    child: GestureDetector(
                      onTap: () {}, // inner container ignores taps
                      child: ReportUserView(
                        userName: widget.userName,
                        userId:widget.userId,
                      ), // your sheet content
                    ),
                  ),
                );
              },
            );
          }),

          // _divider(),
          //
          // _label("Delete chat", Assets.deleteIcon, () {
          //   Navigator.pop(context);
          // }),

          widget.dimens.k10.verticalBoxPadding,
        ],
      ),
    );
  }
  Widget _divider() {
    return Divider(
      height: widget.dimens.k2,
      color: ColorManager.addPicture,
    );
  }
  Widget _label(String text, String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Image.asset(
              image,
              height: widget.dimens.k18,
              width: widget.dimens.k18,
            ),
            widget.dimens.k7.horizontalBoxPadding,
            Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: ColorManager.textColor,
                fontWeight: FontWeight.w500,
                fontSize: widget.dimens.k14,
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  onError(String error) {
    // TODO: implement onError
    throw UnimplementedError();
  }
  @override
  onSuccess(result) {
    // TODO: implement onSuccess
    throw UnimplementedError();
  }
}
