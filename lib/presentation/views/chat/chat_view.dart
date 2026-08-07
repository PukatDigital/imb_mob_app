import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/chat_model/conversation_list_model.dart'
as conv;
import 'package:ideal_marriage_bureau/data/models/chat_model/message_history_model.dart'
as msg;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../base/base_widget.dart';
import '../../../../di/di.dart';
import '../../../application/common/log.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/toast.dart';
import 'chat_details_remove.dart';
import 'chat_view_model.dart';

class ChatDetailView extends BaseStateFullWidget {
  final conv.Data conversation;
  ChatDetailView({super.key, required this.conversation});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> implements Result<String> , ErrorResult{
  final TextEditingController messageController = TextEditingController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();
  final ScrollController _scrollController = ScrollController();

  bool isRecording = false;
  bool isTyping = false;
  bool isPlaying = false;
  String? playingFile;
  Duration recordingDuration = Duration.zero;
  String? recordedFilePath;

  ChatViewModel? chatVm;
  bool _fetched = false;
  bool _socketInitialized = false;


  @override
  void initState() {
    super.initState();
    _initRecorderAndPlayer();
    messageController.addListener(() {
      setState(() {
        isTyping = messageController.text.trim().isNotEmpty;
      });
    });
  }

  Future<void> _initRecorderAndPlayer() async {
    await _recorder.openRecorder();
    _recorder.setSubscriptionDuration(const Duration(milliseconds: 100));
    _recorder.onProgress!.listen((event) {
      setState(() => recordingDuration = event.duration);
    });
    await _player.openPlayer();
  }

  @override
  void dispose() {
    messageController.dispose();
    _scrollController.dispose();
    _recorder.closeRecorder();
    if (_player.isOpen()) _player.closePlayer();

    chatVm?.disposeSocket();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return;

    final directory = await getApplicationDocumentsDirectory();
    final path =
        '${directory.path}/voice_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder.startRecorder(toFile: path, codec: Codec.aacADTS);
    setState(() {
      isRecording = true;
      recordingDuration = Duration.zero;
    });
  }

  Future<void> _stopRecording() async {
    final path = await _recorder.stopRecorder();
    setState(() {
      isRecording = false;
      recordedFilePath = path;
    });

    recordingDuration = Duration.zero;
  }

  Future<void> _playAudio(String path) async {
    if (!_player.isOpen()) await _player.openPlayer();
    if (isPlaying && playingFile == path) {
      await _player.stopPlayer();
      setState(() {
        isPlaying = false;
        playingFile = null;
      });
    } else {
      await _player.startPlayer(
        fromURI: path,
        codec: Codec.aacADTS,
        whenFinished: () {
          setState(() {
            isPlaying = false;
            playingFile = null;
          });
        },
      );
      setState(() {
        isPlaying = true;
        playingFile = path;
      });
    }
  }

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty || chatVm == null) return;
    final receiverId = widget.conversation.userId;

    messageController.clear();

    chatVm!.sendMessageRealtime(
      tempId: DateTime.now().millisecondsSinceEpoch,

      senderId: null,
      receiverId: receiverId,
      text: text,
      result: this,
    );

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0, // list reverse: true hai isliye 0 = bottom (latest message)
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showChatMenu(BuildContext context, Offset position) {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    showMenu(
      context: context,
      elevation: 0,
      color: Colors.transparent,
      position: RelativeRect.fromRect(
        Rect.fromPoints(position, position),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          enabled: false,
          child: ChatMoreDialogView(userName: widget.conversation.fullName ?? ""),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatViewModel>(
      create: (_) => inject<ChatViewModel>(),
      child: Builder(
        builder: (innerContext) {
          if (!_fetched) {
            _fetched = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              chatVm = innerContext.read<ChatViewModel>();
              chatVm!.getMessageHistoryData(
                this,
                conversationId: widget.conversation.userId ?? 0,
              );


              if (!_socketInitialized) {
                _socketInitialized = true;
                chatVm!.initSocket(
                  conversationId: widget.conversation.userId ?? 0,
                  currentUserId: widget.conversation.userId ?? 0,
                );
              }
            });
          }

          return Consumer<ChatViewModel>(
            builder: (_, provider, __) {
              chatVm = provider;
              final messages = provider.messageHistoryModel.data ?? [];

              return Scaffold(
                backgroundColor: Colors.white,
                body: Stack(
                  children: [
                    _background(),
                    Column(
                      children: [
                        widget.dimens.k50.verticalBoxPadding,
                        _header(),
                        Expanded(child: _chatList(messages, provider)),
                        _messageField(),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
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
    final isOnline = widget.conversation.isOnline == 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
    context.read<ChatViewModel>().getConversationList(this);
    Navigator.pop(context);
    } ,
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios,
                    size: widget.dimens.k20, color: ColorManager.primary),
                Text(
                  "Back",
                  style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: widget.dimens.k17,
                      color: ColorManager.primary),
                ),
              ],
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                radius: widget.dimens.k20,
                backgroundImage:
                // (widget.conversation.avatarUrl != null &&
                //
                //     widget.conversation.avatarUrl.isNotEmpty)
                //     ? NetworkImage(widget.conversation.avatarUrl) as ImageProvider
                //     :
                AssetImage(Assets.home2),


              ),
              widget.dimens.k10.horizontalBoxPadding,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.conversation.fullName ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: widget.dimens.k16,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: widget.dimens.k4,
                        backgroundColor: isOnline ? Colors.green : Colors.red,
                      ),
                      widget.dimens.k5.horizontalBoxPadding,
                      Text(
                        isOnline ? "Online" : "Offline",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: isOnline ? Colors.green : ColorManager.fieldTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showChatMenu(context, details.globalPosition);
            },
            child: CircleAvatar(
              backgroundColor: ColorManager.primary.withOpacity(.2),
              radius: widget.dimens.k18,
              child: Icon(Icons.more_vert, color: ColorManager.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatList(List<msg.Data> messages, ChatViewModel provider) {
    if (provider.apiResponse is Loading && messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (messages.isEmpty) {
      return const Center(child: Text("No messages yet"));
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels == notification.metrics.minScrollExtent &&
            provider.hasMore &&
            !provider.isLoadingMore) {
          provider.getMessageHistoryData(
            this,
            conversationId: widget.conversation.userId ?? 0,
            loadMore: true,
          );
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        reverse: true,
        padding: EdgeInsets.all(widget.dimens.k15),
        itemCount: messages.length,
        itemBuilder: (_, index) {
          final data = messages[messages.length - 1 - index];

          return KeyedSubtree(
            key: ValueKey(data.id),
            child: _messageBubble(data),
          );
        },
      ),
    );
  }

  Widget _messageBubble(msg.Data data) {

    final bool isMe = data.receiverId == widget.conversation.userId;
    final String text = data.message ?? "";

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k6),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: widget.dimens.k16,
              backgroundImage:
              // (widget.conversation.avatarUrl != null &&
              //     widget.conversation.avatarUrl.isNotEmpty)
              //     ? NetworkImage(widget.conversation.avatarUrl) as ImageProvider
              //     :
              AssetImage(Assets.home2),
            ),
          if (!isMe) SizedBox(width: widget.dimens.k8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k14,
              vertical: widget.dimens.k10,
            ),
            constraints: BoxConstraints(maxWidth: context.width * 0.7),
            decoration: BoxDecoration(
              color: isMe ? ColorManager.primary : ColorManager.primary.withOpacity(.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe ? widget.dimens.k14 : 0),
                topRight: Radius.circular(widget.dimens.k14),
                bottomLeft: Radius.circular(widget.dimens.k14),
                bottomRight: Radius.circular(isMe ? 0 : widget.dimens.k14),
              ),
            ),
            child: Text(
              text,
              style: context.textTheme.bodyMedium?.copyWith(
                color: isMe ? Colors.white : Colors.black,
              ),
            ),
          ),
          if (isMe) SizedBox(width: widget.dimens.k8),
          if (isMe)
            CircleAvatar(
              radius: widget.dimens.k16,
              backgroundImage: AssetImage(Assets.home1),
            ),
        ],
      ),
    );
  }

  Widget _messageField() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(widget.dimens.k12),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: messageController,
                cursorColor: ColorManager.fieldTextColor,
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: widget.dimens.k15,
                    vertical: widget.dimens.k12,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.dimens.k30),
                    borderSide: BorderSide(color: ColorManager.fieldTextColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.dimens.k30),
                    borderSide: BorderSide(color: ColorManager.fieldTextColor, width: 1.5),
                  ),
                  // suffixIcon: IconButton(
                  //   onPressed: () async {
                  //     if (isRecording) {
                  //       await _stopRecording();
                  //     } else {
                  //       await _startRecording();
                  //     }
                  //   },
                  //   icon: Icon(
                  //     isRecording ? Icons.stop : Icons.mic_none,
                  //     color: isRecording ? Colors.red : ColorManager.fieldTextColor,
                  //     size: widget.dimens.k26,
                  //   ),
                  // ),
                ),
              ),
            ),
            widget.dimens.k10.horizontalBoxPadding,
            CircleAvatar(
              radius: widget.dimens.k23,
              backgroundColor: isTyping ? ColorManager.primary : ColorManager.textColor,
              child: IconButton(
                icon: Image.asset(
                  Assets.sendMessage,
                  height: widget.dimens.k20,
                  width: widget.dimens.k20,
                  color: ColorManager.white,
                ),
                onPressed: _sendMessage,
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
    d("Send Message");
    d(error);
  }
  @override
  void onSuccess(String result) {

  }
}