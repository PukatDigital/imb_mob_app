import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import '../home/user_profile/user_profile_details.dart';
import 'favourite_view_model.dart';
import '../../../../data/models/favourite_model/favourite_model.dart';

class FavouriteView extends BaseStateFullWidget {
  FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView>
    implements Result<String> {
  late FavouriteViewListModel favouriteData;

  bool isSearchVisible = false;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<FavouriteViewListModel>().getFavouriteProfile(
        this,
        profileId: "",
      );
    });
  }

  /// Filter favourite profiles by profile_name based on search query
  List<FavouriteProfiles> get filteredProfiles {
    final allProfiles =
        favouriteData.favouriteProfileModel.data?.favouriteProfiles ?? [];
    if (searchQuery.isEmpty) return allProfiles;
    return allProfiles.where((profile) {
      final name = (profile.profileName ?? "").toLowerCase();
      return name.contains(searchQuery.toLowerCase());
    }).toList();
  }

  void _onSearch(String value) {
    setState(() {
      searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavouriteViewListModel>(
      builder: (_, provider, __) {
        favouriteData = provider;
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
          children: [
            widget.dimens.k50.verticalBoxPadding,
            _header(),
            widget.dimens.k10.verticalBoxPadding,
            if (isSearchVisible) _searchField(),
            widget.dimens.k10.verticalBoxPadding,
            Expanded(child: _profileGrid()),
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
              "Favorite",
              style: TextStyle(
                fontSize: widget.dimens.k18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
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
                backgroundColor: ColorManager.primary.withOpacity(.2),
                radius: widget.dimens.k16,
                child: Icon(
                  isSearchVisible ? Icons.close : Icons.search,
                  color: ColorManager.primary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchField() {
    return TextField(
      controller: searchController,
      onChanged: _onSearch,
      decoration: InputDecoration(
        hintText: "Search profiles...",
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

  Widget _profileGrid() {
    final profiles = filteredProfiles;

    if (profiles.isEmpty) {
      return Center(
        child: Text(
          searchQuery.isEmpty ? "No favourites found." : "No results found.",
          style: TextStyle(fontSize: widget.dimens.k14, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: profiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: widget.dimens.k12,
        crossAxisSpacing: widget.dimens.k12,
        childAspectRatio: .85,
      ),
      itemBuilder: (_, index) {
        return _profileCard(profiles[index]);
      },
    );
  }

  Widget _profileCard(FavouriteProfiles item) {
    final hasImage =
        item.profilePicture != null && item.profilePicture!.isNotEmpty;

    return GestureDetector(
      onDoubleTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                UserProfileDetailsView(profileId: item.profileId.toString()),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.dimens.k15),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background: network image OR grey placeholder with sized icon
            if (hasImage)
              Image.network(
                item.profilePicture!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _greyPlaceholder(),
              )
            else
              _greyPlaceholder(),

            // Foreground content
            Padding(
              padding: EdgeInsets.all(widget.dimens.k10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      final data = {
                        "added_by":favouriteData.favouriteProfileModel.data?.userId,
                        "target_user_id":  item.userId,
                        "type": "remove" ,
                      };

                      favouriteData.addToFavouriteList(
                        data,
                        this,
                      );
                    },
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor:
                        ColorManager.loginContainer.withOpacity(.4),
                        child: Image.asset(
                          Assets.favoriteImage,
                          height: widget.dimens.k22,
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(widget.dimens.k30),
                      color: ColorManager.white.withOpacity(.3),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: widget.dimens.k10,
                        vertical: widget.dimens.k4,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: widget.dimens.k4,
                                backgroundColor: Colors.green,
                              ),
                              SizedBox(width: widget.dimens.k6),
                              Text(
                                "Active",
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontSize: widget.dimens.k12,
                                  color: ColorManager.dropDownBroder,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "${item.profileName ?? ""} -${item.age ?? ""}",
                            style: context.textTheme.titleMedium?.copyWith(
                              fontSize: widget.dimens.k14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          // if (item.addedOn != null)
                          //   Text(
                          //     item.addedOn!,
                          //     style: context.textTheme.bodySmall?.copyWith(
                          //       fontSize: widget.dimens.k11,
                          //       color: Colors.white70,
                          //     ),
                          //   ),
                        ],
                      ),
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

  Widget _greyPlaceholder() {
    return Container(
      color: Colors.grey.shade500,
      child: Center(
        child: Image.asset(
          Assets.user,
          width: 60,
          height: 60,
          color: Colors.grey.shade600,
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
    context.read<FavouriteViewListModel>().getFavouriteProfile(
      this,
      profileId: "",
    );
    // Data loaded successfully, UI updates via notifyListeners
  }
}