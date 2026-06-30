import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/chat_model/conversation_list_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import 'chat_list_change.dart';
import 'chat_view.dart';
import 'chat_view_model.dart';

class ChatListView extends BaseStateFullWidget {
  ChatListView({super.key});
  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView>
    implements Result<String>,ErrorResult {
  late ChatViewModel authVM;
  TextEditingController searchController = TextEditingController();

  List<Data> filteredProfiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authVM = context.read<ChatViewModel>();
      authVM.getConversationList(this);


    });

    searchController.addListener(_filterList);
  }

  void _filterList() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProfiles = authVM.conversationListModel.data
          ?.where((e) =>
          (e.fullName ?? "").toLowerCase().contains(query))
          .toList() ??
          [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<ChatViewModel>(
      builder: (_, provider, __) {
        authVM = provider;


        final list = searchController.text.isEmpty
            ? (provider.conversationListModel.data ?? [])
            : filteredProfiles;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _mainContent(list),
            ],
          ),
        );
      },
    );
  }

  Widget _mainContent(List<Data> list) {
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
            Expanded(child: _chatList(list)),
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
      ],
    );
  }

  Widget _chatList(List<Data> list) {
    if (list.isEmpty) {
      return const Center(child: Text("No conversations yet"));
    }
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: list.length,
      itemBuilder: (_, index) {
        return _chatTile(list[index]);
      },
    );
  }

  Widget _chatTile(Data item) {

    final bool isOnline = item.isOnline == 1;
    final Color statusColor = isOnline ? Colors.green : Colors.red;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k10),
      child: GestureDetector(
        onLongPress: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            barrierColor: Colors.black54,
            isDismissible: true,
            enableDrag: true,
            builder: (context) {
              return ChatListChangeView(userName: item.fullName ?? "");
            },
          );
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatDetailView(conversation: item),
            ),
          );
        },
        child: Row(
          children: [

            Stack(
              children: [
                CircleAvatar(
                  radius: widget.dimens.k20,
                  backgroundImage: (item.avatarUrl != null &&
                      item.avatarUrl.toString().isNotEmpty)
                      ? NetworkImage(item.avatarUrl.toString())
                  as ImageProvider
                      : AssetImage(Assets.profile),
                ),
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 3,
                      backgroundColor: statusColor,
                    ),
                  ),
                ),
              ],
            ),

            widget.dimens.k12.horizontalBoxPadding,


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.fullName ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: widget.dimens.k17,
                      color: ColorManager.textColor,
                    ),
                  ),
                  widget.dimens.k4.verticalBoxPadding,
                  Text(
                    item.lastMessage ?? "",
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}