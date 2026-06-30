import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/explore/explore_model_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../application/common/enum.dart';
import '../../../constants/asset_manager.dart';
import '../home/set_up_profile_dialog.dart';
import '../home/user_profile/user_profile_details.dart';
import 'filter_explore.dart';
import '../../../data/models/explore_model/explore_model.dart';

class ExploreView extends BaseStateFullWidget {
  ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView>
    implements Result<String> {
  late ExploreViewModel exploreData;

  bool isSearchVisible = false;
  bool isFilterOpen = false;
  bool _dialogShown = false;
  TextEditingController searchController = TextEditingController();

  // Active filter params
  Map<String, dynamic> _filterParams = {
    "children": "",
    "age_from": "",
    "age_to": "",
    "religion": "",
    "education": "",
    "location": "",
    "marital_status": "",
    "name": "",
  };

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loadProfiles();
    });
  }

  void _loadProfiles() {
    context.read<ExploreViewModel>().exploreList(this, filterParams: _filterParams);
  }

  void _onSearch(String value) {
    setState(() {
      _filterParams["name"] = value;
    });
    context.read<ExploreViewModel>().exploreList(this, filterParams: _filterParams);
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ExploreViewModel>(
      builder: (_, provider, __) {
        exploreData = provider;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              _mainContent(),
              if (isFilterOpen)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(color: ColorManager.transparent),
                ),
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
            widget.dimens.k10.verticalBoxPadding,
            if (isSearchVisible) _searchField(),
            widget.dimens.k10.verticalBoxPadding,
            _matchingRow(),
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
              "Explore",
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
              _filterParams["name"] = "";
            });
            if (!isSearchVisible) _loadProfiles();
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
      ),
    );
  }

  Widget _matchingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Matching",
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: widget.dimens.k17,
            fontWeight: FontWeight.w600,
            color: ColorManager.textColor,
          ),
        ),
        GestureDetector(
          onTap: () async {
            setState(() => isFilterOpen = true);

            final result = await showModalBottomSheet<Map<String, dynamic>>(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: true,
              backgroundColor: Colors.transparent,
              builder: (_) => FilterExploreBottomView(
                initialParams: _filterParams,
              ),
            );

            setState(() => isFilterOpen = false);

            if (result != null) {
              setState(() {
                _filterParams = {
                  "children": result["children"] ?? "",
                  "age_from": result["age_from"] ?? "",
                  "age_to": result["age_to"] ?? "",
                  "religion": result["religion"] ?? "",
                  "education": result["education"] ?? "",
                  "location": result["location"] ?? "",
                  "marital_status": result["marital_status"] ?? "",
                  "name": _filterParams["name"] ?? "",
                };
              });
              _loadProfiles();
            }
          },
          child: Row(
            children: [
              Image.asset(
                Assets.filterImage,
                height: widget.dimens.k20,
                width: widget.dimens.k20,
                color: ColorManager.textColorSubTitle,
              ),
              widget.dimens.k4.horizontalBoxPadding,
              Text(
                "Filter",
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: widget.dimens.k13,
                  fontWeight: FontWeight.w400,
                  color: ColorManager.textColorSubTitle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _profileGrid() {
    final profiles = exploreData.exploreDataModel.data?.profiles ?? [];

    if (profiles.isEmpty) {
      return const Center(child: Text("No profiles found"));
    }

    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: profiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: widget.dimens.k12,
        crossAxisSpacing: widget.dimens.k12,
        childAspectRatio: .68,
      ),
      itemBuilder: (_, index) => _profileCard(profiles[index]),
    );
  }

  Widget _profileCard(ExploreProfiles item) {
    final imageUrl = item.profilePicture ?? '';


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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.dimens.k15),
          color: imageUrl.isEmpty
              ? Colors.grey.shade400 // dark grey background
              : null,
          image: imageUrl.isNotEmpty
              ? DecorationImage(
            image: NetworkImage(imageUrl) as ImageProvider,
            fit: BoxFit.cover,
          )
              :DecorationImage(
            image: AssetImage(Assets.user),
            fit: BoxFit.none, // keeps original smaller size
            alignment: Alignment.center,
            scale: 5.0, // increase value = smaller image
            colorFilter: ColorFilter.mode(
              Colors.grey.shade500,
              BlendMode.srcIn,
            ),
          ),
            ),

        child: Padding(
          padding: EdgeInsets.all(widget.dimens.k10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    final login = widget.iPrefHelper.loginModel;
                    final isFav = item.isFavourite ?? false;
                    final data = {
                      "added_by": login?.data?.user?.name?.trim(),
                      "target_user_id": item.userId?.trim(),
                      "type": isFav ? "remove" : "add",
                    };
                    exploreData.addToFavouriteList(
                      data,
                      _FavouriteResultHandler(context, item),
                    );
                  },
                  child: CircleAvatar(
                    backgroundColor: ColorManager.loginContainer.withOpacity(.4),
                    child: Image.asset(
                      item.isFavourite == true
                          ? Assets.favoriteImage
                          : Assets.favorite,
                      height: widget.dimens.k22,
                    ),
                  ),
                ),
              ),
              const Spacer(),
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
                "${item.profileName ?? ''} - ${item.age ?? ''}",
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: widget.dimens.k14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text(
                "${item.location ?? ''} - ${item.profession ?? ''}",
                style: context.textTheme.titleMedium?.copyWith(
                  fontSize: widget.dimens.k12,
                  color: ColorManager.dropDownBroder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }
  @override
  void onSuccess(String result)  {
    if (_dialogShown) return;

    final profileCompleted = exploreData.exploreDataModel.data?.profileCompleted ?? 0;

    if (profileCompleted != 1) {
      _dialogShown = true;
      Future.delayed(const Duration(milliseconds: 200), () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.transparent, // ✅ remove default dark barrier
          builder: (_) => PopScope(
            canPop: false,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: SetUpProfileDialog(),
              ),
            ),
          ),
        );
        _dialogShown = false;
      });
    }
  }
}


/// RESULT HANDLER
class _FavouriteResultHandler implements Result {
  final BuildContext context;
  final ExploreProfiles profile;

  _FavouriteResultHandler(this.context, this.profile);

  @override
  void onError(String error) {
    MyToast.showToast(
      message: error,
      typeToast: TypeToast.error,
    );
  }

  @override
  void onSuccess( result) {
    MyToast.showToast(
      message: result,
      typeToast: TypeToast.success,
    );

    // toggle local state
    profile.isFavourite = !(profile.isFavourite ?? false);

    context.read<ExploreViewModel>().notifyListeners();
  }
}