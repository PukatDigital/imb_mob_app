import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/app_theme/text_themes.dart';
import '../../../../base/base_widget.dart';
class ImpressionsView extends BaseStateFullWidget {
   ImpressionsView({super.key});

  @override
  State<ImpressionsView> createState() =>
      _ImpressionsViewState();
}

class _ImpressionsViewState
    extends State<ImpressionsView> {

  /// Dummy Users
  final List<Map<String, dynamic>> users = [
    {
      "name": "Mehwish Hayat",
      "username": "@mehwishhayat",
      "image":
      "https://i.pravatar.cc/150?img=1",
      "saidHi": false,
    },
    {
      "name": "Nadia Gujjar",
      "username": "@nadiagujjar",
      "image":
      "https://i.pravatar.cc/150?img=2",
      "saidHi": false,
    },
    {
      "name": "Mahira Mahmood",
      "username": "@mahiramahmood",
      "image":
      "https://i.pravatar.cc/150?img=3",
      "saidHi": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          /// Background
          _background(),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: widget.dimens.k18,
                vertical: widget.dimens.k16,
              ),
              child: Column(
                children: [

                  /// Header
                  Row(
                    children: [

                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [

                            Icon(
                              Icons.arrow_back_ios,
                              size:
                              widget.dimens.k16,
                              color: ColorManager
                                  .rejectedText,
                            ),

                            Text(
                              "Back",
                              style: context
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                color: ColorManager
                                    .rejectedText,
                                fontSize: widget
                                    .dimens.k14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Center(
                          child: Text(
                            "Impressions",
                            style: context
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight:
                              FontWeight.w600,
                              fontSize: widget
                                  .dimens.k18,
                              color:
                              Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width:
                        widget.dimens.k40,
                      ),
                    ],
                  ),

                  widget.dimens.k25
                      .verticalBoxPadding,

                  /// Users List
                  Expanded(
                    child: ListView.separated(
                      itemCount: users.length,
                      separatorBuilder:
                          (_, __) => widget
                          .dimens.k18
                          .verticalBoxPadding,
                      itemBuilder:
                          (context, index) {

                        final user =
                        users[index];

                        return _userTile(
                          user: user,
                          index: index,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userTile({
    required Map<String, dynamic> user,
    required int index,
  }) {
    return Row(
      children: [

        /// Profile Image
        CircleAvatar(
          radius: widget.dimens.k22,
          backgroundImage: NetworkImage(
            user["image"],
          ),
        ),

        widget.dimens.k12.horizontalBoxPadding,

        /// Name + Username
        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Text(
                user["name"],
                style: TextStyle(
                  fontSize:
                  widget.dimens.k15,
                  fontWeight:
                  FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              widget.dimens.k2
                  .verticalBoxPadding,

              Text(
                user["username"],
                style: TextStyle(
                  fontSize:
                  widget.dimens.k12,
                  fontWeight:
                  FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        /// Say Hi Button
        GestureDetector(
          onTap: () {
            setState(() {
              users[index]["saidHi"] =
              !users[index]["saidHi"];
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:
              widget.dimens.k16,
              vertical:
              widget.dimens.k8,
            ),
            decoration: BoxDecoration(
              color:
              ColorManager.rejectedText,
              borderRadius:
              BorderRadius.circular(
                widget.dimens.k30,
              ),
            ),
            child: Row(
              children: [

                Text(
                  "👋",
                  style: TextStyle(
                    fontSize:
                    widget.dimens.k12,
                  ),
                ),

                widget.dimens.k5
                    .horizontalBoxPadding,

                Text(
                  user["saidHi"]
                      ? "Hi Sent"
                      : "Say Hi",
                  style: TextStyle(
                    fontSize:
                    widget.dimens.k12,
                    fontWeight:
                    FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _background() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFB11E24)
                .withOpacity(.18),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}