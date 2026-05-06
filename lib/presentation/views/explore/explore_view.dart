import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import '../auth/auth_view_model.dart';
import 'filter_explore.dart';
class ExploreView extends BaseStateFullWidget {
  ExploreView({super.key});
  @override
  State<ExploreView> createState() => _ExploreViewState();
}
class _ExploreViewState extends State<ExploreView>
    implements Result<String> {
  late AuthViewModel authVM;
  bool isSearchVisible = false;
  bool isFilterOpen = false;
  TextEditingController searchController = TextEditingController();
  final List<Map<String, String>> profiles = List.generate(
    8,
        (index) => {
      "name": "Maryam Baloch",
      "age": "24",
      "city": "Lahore",
      "height": "5.6ft",
      "status": "Active",
      "image": Assets.home2,
    },
  );
  List<Map<String, String>> filteredProfiles = [];
  @override
  void initState() {
    super.initState();
    filteredProfiles = profiles;
  }

  void _onSearch(String value) {
    setState(() {
      filteredProfiles = profiles.where((item) {
        return item["name"]!
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            item["city"]!
                .toLowerCase()
                .contains(value.toLowerCase());
      }).toList();
    });
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
              if (isFilterOpen)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: -6, sigmaY: -6),
                  child: Container(
                    color: ColorManager.transparent),
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
              filteredProfiles = profiles;
            });
          },
          child: SizedBox(
            width: widget.dimens.k40, // Same width as back button for symmetry
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
        // Fully circular & transparent border for all states
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50), // Full circular
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.transparent),
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

            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              enableDrag: true,
              backgroundColor: Colors.transparent,
              builder: (_) =>  FilterExploreBottomView(),
            );


            setState(() => isFilterOpen = false);
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
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredProfiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: widget.dimens.k12,
        crossAxisSpacing: widget.dimens.k12,
        childAspectRatio: .68,
      ),
      itemBuilder: (_, index) {
        return _profileCard(filteredProfiles[index]);
      },
    );
  }
  Widget _profileCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.dimens.k15),
        image: DecorationImage(
          image: AssetImage(item["image"]!),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(widget.dimens.k10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                backgroundColor:
                ColorManager.loginContainer.withOpacity(.4),
                child: Image.asset(
                  Assets.favorite,
                  height: widget.dimens.k22,
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
                  item["status"]!,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: widget.dimens.k12,
                    color: ColorManager.dropDownBroder,
                  ),
                ),
              ],
            ),
            Text(
              "${item["name"]} - ${item["age"]}",
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: widget.dimens.k14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              "${item["city"]} - ${item["height"]}",
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: widget.dimens.k12,
                color: ColorManager.dropDownBroder,
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
    MyToast.showToast(message: "OTP Verified Successfully!");
  }
}
