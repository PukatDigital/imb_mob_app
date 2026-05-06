import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';
import '../auth/auth_mixin.dart';
import 'chat_block_view.dart';
import 'chat_report_view.dart';
class ChatListChangeView extends BaseStateFullWidget {
  final String userName;
  ChatListChangeView({super.key,required this.userName});
  @override
  State<ChatListChangeView> createState() =>
      _ChatListChangeViewState();
}
class _ChatListChangeViewState extends State<ChatListChangeView>
    with AuthMixin
    implements Result {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // ✅ outside tap close
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {}, // ✅ prevent closing when tapping inside
                child: SizedBox(
                  height: size.height * 0.40,
                  child: Stack(
                    children: [
                      Positioned(
                        top: size.height * 0.09,
                        left: widget.dimens.k20,
                        right: widget.dimens.k20,
                        child: Container(
                          height: size.height * 0.28,
                          decoration: BoxDecoration(
                            color: ColorManager.white.withOpacity(.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(widget.dimens.k25),
                              topRight: Radius.circular(widget.dimens.k25),
                            ),
                          ),
                        ),
                      ),

                      /// 🔹 Main White Bottom Container
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: size.height * 0.30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(widget.dimens.k25),
                              topRight: Radius.circular(widget.dimens.k25),
                            ),
                          ),
                          child: _buildContent(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.dimens.k15.verticalBoxPadding,
            Center(
              child: Text(
                "Mehwish Hayat",
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: widget.dimens.k17,
                  fontWeight: FontWeight.w600,
                  color: ColorManager.textColor,
                ),
              ),
            ),
            widget.dimens.k20.verticalBoxPadding,
            _label("Share this profile", Assets.shareIcon, () async{
              Navigator.pop(context);
              final String profileLink =
                  "https://yourapp.com/profile/${widget.userName}";

              await Share.share(
                "Check out this profile on Ideal Marriage Bureau:\n\n"
                    "${widget.userName}\n\n"
                    "$profileLink",
              );
            }),
            widget.dimens.k5.verticalBoxPadding,
            Divider(
              height: widget.dimens.k2,
              color: ColorManager.addPicture,
            ),
            widget.dimens.k10.verticalBoxPadding,
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
                        child: ChatBlockView(), // your sheet content
                      ),
                    ),
                  );
                },
              );
            }),
            widget.dimens.k5.verticalBoxPadding,
            Divider(
              height: widget.dimens.k2,
              color: ColorManager.addPicture,
            ),
            widget.dimens.k10.verticalBoxPadding,
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
                        child: ChatReportView(), // your sheet content
                      ),
                    ),
                  );
                },
              );
            }),
            widget.dimens.k5.verticalBoxPadding,
            Divider(
              height: widget.dimens.k2,
              color: ColorManager.addPicture,
            ),
            widget.dimens.k10.verticalBoxPadding,
            _label("Delete chat", Assets.deleteIcon, () {}),
            widget.dimens.k20.verticalBoxPadding,
          ],
        ),
      ),
    );
  }
  Widget _label(String text, String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
  @override
  onError(String error) {}
  @override
  onSuccess(result) {}
}
