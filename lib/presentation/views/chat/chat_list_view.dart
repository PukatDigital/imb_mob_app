import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import '../auth/auth_view_model.dart';
import 'chat_list_change.dart';
import 'chat_view.dart';
class ChatListView extends BaseStateFullWidget {
  ChatListView({super.key});
  @override
  State<ChatListView> createState() => _ChatListViewState();
}
class _ChatListViewState extends State<ChatListView>
    implements Result<String> {
  late AuthViewModel authVM;
  TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> profiles = List.generate(
    8,
        (index) => {
      "name": "Maryam Baloch",
      "lastMessage": "Mostly reading or traveling. What about you?",
      "isOnline": index % 2 == 0, // demo online/offline
      "image": Assets.home2,
    },
  );
  List<Map<String, dynamic>> filteredProfiles = [];
  @override
  void initState() {
    super.initState();
    filteredProfiles = profiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (_, provider, __) {
        authVM = provider;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _mainContent(),
            ],
          ),
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
          children: [
            widget.dimens.k50.verticalBoxPadding,
            _header(),
            widget.dimens.k15.verticalBoxPadding,
            Expanded(child: _chatList()),
          ],
        ),
      ),
    );
  }
  Widget _header() {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              "Chat",
              style: TextStyle(
                fontSize: widget.dimens.k18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: (){
        //
        //   },
        //   child: CircleAvatar(
        //     backgroundColor: ColorManager.primary.withOpacity(.2),
        //     radius: widget.dimens.k20,
        //     child: Icon(
        //       Icons.more_vert,
        //       color: ColorManager.primary,
        //     ),
        //   ),
        // ),
      ],
    );
  }
  Widget _chatList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredProfiles.length,
      itemBuilder: (_, index) {
        return _chatTile(filteredProfiles[index]);
      },
    );
  }
  Widget _chatTile(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k10),
      child:
      GestureDetector(
        onLongPress: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black54,
            isDismissible: true,
            enableDrag: true,
            builder: (context) {
              return  ChatListChangeView(userName: "John Doe",);
            },
          );
        },

        // onLongPress: ()async{
        //   await
        //   await showModalBottomSheet(
        //     context: context,
        //     isScrollControlled: true,
        //     backgroundColor: Colors.transparent,
        //     isDismissible: true,   // ✅ allow outside tap dismiss
        //     enableDrag: true,      // ✅ allow swipe down dismiss
        //     builder: (_) {
        //       return GestureDetector(
        //         onTap: () {}, // ✅ prevent sheet content tap from closing
        //         child: FractionallySizedBox(
        //           heightFactor: 0.95,
        //           child: ChatListChangeView(),
        //         ),
        //       );
        //     },
        //   );
        // },
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatDetailView(profile: item),
            ),
          );

        },
        child:
        Row(
          children: [
            // PROFILE IMAGE + ONLINE STATUS
            Stack(
              children: [
                CircleAvatar(
                  radius: widget.dimens.k20,
                  backgroundImage: AssetImage(item["image"]),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor:
                      item["isOnline"] ? Colors.green : ColorManager.fieldTextColor,
                    ),
                  ),
                ),
              ],
            ),

            widget.dimens.k12.horizontalBoxPadding,

            // NAME & LAST MESSAGE
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item["name"],
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize:    widget.dimens.k17,
                      color: ColorManager.textColor
                    ),
                  ),
                  widget.dimens.k4.verticalBoxPadding,
                  Text(
                    item["lastMessage"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: ColorManager.fieldTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
