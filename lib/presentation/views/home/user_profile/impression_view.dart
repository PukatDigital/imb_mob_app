import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/common/enum.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/app_theme/text_themes.dart';
import '../../../../application/common/log.dart';
import '../../../../application/core/result.dart';
import '../../../../application/network/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../data/models/impression_model/impression_list_model.dart';
import '../../../../widgets/toast.dart';
import '../home_view_model.dart';


class ImpressionsView extends BaseStateFullWidget {
  ImpressionsView({super.key});

  @override
  State<ImpressionsView> createState() => _ImpressionsViewState();
}

class _ImpressionsViewState extends State<ImpressionsView>
    implements ErrorResult, Result<String> {

  late GetProfileViewModel impressionData;
  bool isSearchVisible = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  final Set<String> _saidHiProfiles = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetProfileViewModel>().getImpressionList(
        this,
        profileId: "",
      );
    });
  }

  List<Data> get filteredImpressions {
    final all = impressionData.impressionListModel.data ?? [];
    if (searchQuery.isEmpty) return all;
    return all.where((item) {
      final name = (item.targetUserName ?? "").toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetProfileViewModel>(
      builder: (_, provider, __) {
        impressionData = provider;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
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
                            onTap: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_back_ios,
                                  size: widget.dimens.k16,
                                  color: ColorManager.rejectedText,
                                ),
                                Text(
                                  "Back",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: ColorManager.rejectedText,
                                    fontSize: widget.dimens.k14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Impressions",
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.dimens.k18,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          /// Search Toggle
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isSearchVisible = !isSearchVisible;
                                searchController.clear();
                                searchQuery = "";
                              });
                            },
                            child: SizedBox(
                              width: widget.dimens.k40,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CircleAvatar(
                                  backgroundColor:
                                  ColorManager.primary.withOpacity(.2),
                                  radius: widget.dimens.k16,
                                  child: Icon(
                                    isSearchVisible
                                        ? Icons.close
                                        : Icons.search,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      widget.dimens.k10.verticalBoxPadding,

                      /// Search Field
                      if (isSearchVisible) _searchField(),

                      widget.dimens.k15.verticalBoxPadding,

                      /// List
                      Expanded(child: _buildList(provider)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildList(GetProfileViewModel provider) {
    if (provider.apiResponse is Loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final List<Data> items = filteredImpressions;

    if (items.isEmpty) {
      return Center(
        child: Text(
          searchQuery.isEmpty ? "No impressions found." : "No results found.",
          style: TextStyle(
            fontSize: widget.dimens.k14,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => widget.dimens.k18.verticalBoxPadding,
      itemBuilder: (context, index) {
        return _userTile(item: items[index]);
      },
    );
  }

  Widget _searchField() {
    return TextField(
      controller: searchController,
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
      decoration: InputDecoration(
        hintText: "Search impressions...",
        filled: true,
        fillColor: Colors.white,
        suffixIcon: Icon(Icons.search, size: widget.dimens.k25),
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.dimens.k15,
          horizontal: widget.dimens.k20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }

  Widget _userTile({required Data item}) {
    final bool saidHi = _saidHiProfiles.contains(item.targetProfile);
    final bool hasImage =
        item.profilePicture != null && item.profilePicture!.isNotEmpty;

    return Row(
      children: [
        /// Profile Image
        CircleAvatar(
          radius: widget.dimens.k22,
          backgroundColor: ColorManager.primary.withOpacity(.2),
          backgroundImage: hasImage ? NetworkImage(item.profilePicture!) : null,
          child: !hasImage
              ? Text(
            (item.targetUserName ?? "?")[0].toUpperCase(),
            style: TextStyle(
              fontSize: widget.dimens.k18,
              fontWeight: FontWeight.w600,
              color: ColorManager.primary,
            ),
          )
              : null,
        ),

        widget.dimens.k12.horizontalBoxPadding,

        /// Name + Email
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.targetUserName ?? '',
                style: TextStyle(
                  fontSize: widget.dimens.k15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              widget.dimens.k2.verticalBoxPadding,
              Text(
                item.targetUser ?? '',
                style: TextStyle(
                  fontSize: widget.dimens.k12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),

        /// Say Hi Button
        GestureDetector(
          onTap: () {
            if (!saidHi) {
              final data = {"target_profile": item.targetProfile};
              context.read<GetProfileViewModel>().sendIntrest(data, this);
              setState(() {
                _saidHiProfiles.add(item.targetProfile ?? '');
              });
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k16,
              vertical: widget.dimens.k8,
            ),
            decoration: BoxDecoration(
              color: saidHi ? Colors.grey.shade400 : ColorManager.rejectedText,
              borderRadius: BorderRadius.circular(widget.dimens.k30),
            ),
            child: Row(
              children: [
                Text("👋", style: TextStyle(fontSize: widget.dimens.k12)),
                widget.dimens.k5.horizontalBoxPadding,
                Text(
                  saidHi ? "Hi Sent" : "Say Hi",
                  style: TextStyle(
                    fontSize: widget.dimens.k12,
                    fontWeight: FontWeight.w500,
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
            const Color(0xFFB11E24).withOpacity(.18),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  @override
  void onError(String error) {
    d(error);
    MyToast.showToast(message: error, typeToast: TypeToast.error);
  }
  @override
  void onSuccess(String result) {
    MyToast.showToast(message: result,typeToast: TypeToast.success);
  }
}