
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/common/enum.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/block/block_profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../application/network/result.dart';
import '../../../constants/asset_manager.dart';
import '../../../data/models/block_model/block_model.dart';
import '../../../widgets/primary_button.dart';
import '../home/user_profile/user_profile_details.dart';

class BlockListView extends BaseStateFullWidget {
  BlockListView({super.key});

  @override
  State<BlockListView> createState() => _BlockListViewState();
}

class _BlockListViewState extends State<BlockListView>
    implements Result<String> {
  late BlockViewModel blockData;
  late final loginModel;

  @override
  void initState() {
    super.initState();

    loginModel = widget.iPrefHelper.loginModel;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<BlockViewModel>().getBlockProfileUser(
        this,
        profileId: loginModel?.data?.user?.name ?? "", // ✅ FIXED
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockViewModel>(
      builder: (_, provider, __) {
        blockData = provider;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: widget.dimens.k15),
              child: Column(
                children: [
                  SizedBox(height: widget.dimens.k15),
                  _header(),
                  const SizedBox(height: 15),

                  /// 🔥 LOADING
                  if (provider.apiResponse is Loading)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    Expanded(child: _chatList()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios,
                  size: widget.dimens.k20,
                  color: ColorManager.primary),
              const SizedBox(width: 5),
              Text(
                "Back",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: widget.dimens.k17,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Blocked Accounts",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: widget.dimens.k18,
                color: ColorManager.textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _chatList() {
    final list =
        blockData.blockedProfileModel.data?.blockedProfiles ?? [];

    if (list.isEmpty) {
      return const Center(child: Text("No blocked users"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: list.length,
      itemBuilder: (_, index) {
        return _chatTile(list[index]);
      },
    );
  }

  Widget _chatTile(BlockedProfiles item) {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: widget.dimens.k10),
      child: Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          UserProfileDetailsView(profileId: item.profileId.toString()),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: widget.dimens.k25,
                  backgroundColor: ColorManager.starColor, // grey hatane ke liye
                  child: ClipOval(
                    child: (item.profilePicture != null &&
                        item.profilePicture!.isNotEmpty)
                        ? Image.network(
                      item.profilePicture!,
                      width: widget.dimens.k50,
                      height: widget.dimens.k50,
                      fit: BoxFit.cover, // proper fit
                    )
                        : Image.asset(
                      Assets.user,
                      color: ColorManager.textColorSubTitle,
                      width: widget.dimens.k20,
                      height: widget.dimens.k20,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),

              /// 🔥 ONLINE / OFFLINE DOT
              Positioned(
                bottom: 2,
                right: 2,
                child: CircleAvatar(
                  radius: 6,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor:
                    // item.isOnline == true
                    //     ?
                    Colors.green
                        // : ColorManager.fieldTextColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: widget.dimens.k12),
          /// NAME + REASON
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.profileName ?? "",
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: widget.dimens.k17,
                    color: ColorManager.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.userId ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorManager.fieldTextColor,
                  ),
                ),
              ],
            ),
          ),
          /// UNBLOCK BUTTON
          PrimaryButton(
            onPressed: () {
              // final login = widget.iPrefHelper.loginModel;

              final data = {
                "added_by": blockData.blockedProfileModel.data?.userId,   // ✅ NOT email
                "target_user_id": item.userId,    // already correct
                "type": "remove",
              };

              print("REQUEST BODY => $data");

              blockData.addToBlockUser(
                  data,this
              );

              // setState(() {
              //   // selectedTab = AuthTab.signup;
              //
              // });
            },
            childText: 'Unblock',
            issquare: true,
            color: ColorManager.primary,
            height: 45,
            width: 90,
            radius: 25,
            textStyle: context.textTheme.titleMedium?.copyWith(
              color: ColorManager.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  bool _isRefreshing = false;

  @override
  void onSuccess(String result) {
    if (_isRefreshing) return;

    MyToast.showToast(
      message: result,
      typeToast: TypeToast.success,
    );

    _isRefreshing = true;

    context.read<BlockViewModel>().getBlockProfileUser(
      this,
      profileId: loginModel?.data?.user?.name ?? "",
    );

    Future.delayed(Duration(milliseconds: 500), () {
      _isRefreshing = false;
    });
  }
}