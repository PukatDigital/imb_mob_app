
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../base/base_widget.dart';
import '../../../constants/asset_manager.dart';
import 'chat_details_remove.dart';

class ChatDetailView extends BaseStateFullWidget {
  final Map<String, dynamic> profile;
  ChatDetailView({super.key, required this.profile});
  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  final TextEditingController messageController = TextEditingController();
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool isRecording = false;
  bool isTyping = false;
  bool isPlaying = false;
  String? playingFile;

  Duration recordingDuration = Duration.zero;
  String? recordedFilePath;

  final List<Map<String, dynamic>> messages = [
    {"text": "Hi 👋", "isMe": true},
    {"text": "Hello, how are you?", "isMe": false},
    {"text": "Mostly reading or traveling.", "isMe": false},
    {"text": "Nice 😊", "isMe": true},
  ];

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
      setState(() {
        recordingDuration = event.duration;
      });
    });

    await _player.openPlayer();
  }

  @override
  void dispose() {
    messageController.dispose();
    _recorder.closeRecorder();
    if (_player.isOpen()) _player.closePlayer();
    super.dispose();
  }

  // Start Recording
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
    if (path != null) {
      messages.add({
        "text": "[Voice message]",
        "isMe": true,
        "audioPath": path,
        "duration": recordingDuration.inSeconds,
      });
      recordingDuration = Duration.zero;
      setState(() {});
    }
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
    if (messageController.text.trim().isEmpty) return;
    setState(() {
      messages.add({
        "text": messageController.text.trim(),
        "isMe": true,
      });
    });
    messageController.clear();
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
          child: ChatMoreDialogView(userName: "John Doe"),
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _background(),
          Column(
            children: [
              widget.dimens.k50.verticalBoxPadding,
              _header(),
              Expanded(child: _chatList()),
              _messageField(),
            ],
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
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
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
                AssetImage(widget.profile["image"] ?? Assets.home2),
              ),
              widget.dimens.k10.horizontalBoxPadding,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.profile["name"] ?? "",
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: widget.dimens.k16,
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: widget.dimens.k4,
                        backgroundColor: widget.profile["isOnline"] == true
                            ? ColorManager.onlineColor
                            : ColorManager.textColorSubTitle,
                      ),
                      widget.dimens.k5.horizontalBoxPadding,
                      Text(
                        widget.profile["isOnline"] == true
                            ? "Online"
                            : "Offline",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: widget.profile["isOnline"] == true
                              ? Colors.green
                              : ColorManager.fieldTextColor,
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
              child: Icon(
                Icons.more_vert,
                color: ColorManager.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatList() {
    return ListView.builder(
      padding: EdgeInsets.all(widget.dimens.k15),
      itemCount: messages.length,
      itemBuilder: (_, index) {
        final msg = messages[index];
        return _messageBubble(msg);
      },
    );
  }

  Widget _messageBubble(Map<String, dynamic> msg) {
    bool isMe = msg["isMe"] ?? true;
    String text = msg["text"] ?? "";

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.dimens.k6),
      child: Row(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: widget.dimens.k16,
              backgroundImage:
              AssetImage(widget.profile["image"] ?? Assets.home2),
            ),
          if (!isMe) SizedBox(width: widget.dimens.k8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k14,
              vertical: widget.dimens.k10,
            ),
            constraints: BoxConstraints(maxWidth: context.width * 0.7),
            decoration: BoxDecoration(
              color: isMe
                  ? ColorManager.primary
                  : ColorManager.primary.withOpacity(.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isMe ? widget.dimens.k14 : 0),
                topRight: Radius.circular(widget.dimens.k14),
                bottomLeft: Radius.circular(widget.dimens.k14),
                bottomRight: Radius.circular(isMe ? 0 : widget.dimens.k14),
              ),
            ),
            child: msg.containsKey("audioPath")
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () => _playAudio(msg["audioPath"]),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isPlaying && playingFile == msg["audioPath"]
                            ? Icons.stop
                            : Icons.play_arrow,
                        color: isMe ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Voice Message",
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "${msg["duration"] ?? 0} sec",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: isMe ? Colors.white70 : Colors.black54,
                  ),
                )
              ],
            )
                : Text(
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
                    borderSide: BorderSide(
                      color: ColorManager.fieldTextColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.dimens.k30),
                    borderSide: BorderSide(
                      color: ColorManager.fieldTextColor,
                      width: 1.5,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () async {
                      if (isRecording) {
                        await _stopRecording();
                      } else {
                        await _startRecording();
                      }
                    },
                    icon: Icon(
                      isRecording ? Icons.stop : Icons.mic_none,
                      color:
                      isRecording ? Colors.red : ColorManager.fieldTextColor,
                      size: widget.dimens.k26,
                    ),
                  ),
                ),
              ),
            ),
            widget.dimens.k10.horizontalBoxPadding,
            CircleAvatar(
              radius: widget.dimens.k22,
              backgroundColor:
              isTyping ? ColorManager.primary : ColorManager.textColor,
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
}
