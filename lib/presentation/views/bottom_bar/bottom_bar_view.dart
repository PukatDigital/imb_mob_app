
import 'package:flutter/material.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../base/base_widget.dart';
import '../../../constants/asset_manager.dart';
import '../chat/chat_list_view.dart';
import '../explore/explore_view.dart';
import '../favourite/favourite_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
class BottomBarView extends BaseStateFullWidget {
  BottomBarView({super.key}); // ✅ Accept external key, don't force globalKey

  static final GlobalKey<_BottomBarViewState> globalKey =
  GlobalKey<_BottomBarViewState>();
  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int _selectedIndex = 0;
  // Map<String, dynamic>? _newDocArgs;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _buildScreens();
  }
  void _buildScreens() {
    _screens.clear();
    _screens.addAll([
      HomeView(),
      ExploreView(),
      FavouriteView(),
      ChatListView(),
      ProfileScreen(),
      // Container(
      //   child: Container(child: Center(child: Text("Fifth Screen"))),
      // ),
    ]);
  }
  void switchTab(int index) {
    if (index < 0 || index >= _screens.length) return;
    setState(() {
      _selectedIndex = index;
    });
  }
  /// Call this from outside
  void openNewDocumentWithArgs(Map<String, dynamic> args) {
    setState(() {
      // _newDocArgs = args;
      _selectedIndex = 1; // tab 1 = NewDocumentView
      _buildScreens(); // rebuild with new args
    });
  }

  void _onItemTapped(int index) {
    switchTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey,
      body:
      Container(
          color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
        //       const Color(0xFF224966).withOpacity(0.2),
        //       ColorManager.white,
        //       ColorManager.white,
        //       ColorManager.white,
        //     ],
        //   ),
        // ),
        child: _screens[_selectedIndex]
      ),
      bottomNavigationBar: Container(
        // margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: ColorManager.white,
          // borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return _buildNavItem(index);
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final icons = [
      Assets.home,
      Assets.explore,
      Assets.favorite,
      Assets.chat,
      Assets.profile,

    ];
    final labels = ["Home", "Explore", "Favorite", "Chat", "Profile"];

    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
        EdgeInsets.symmetric(horizontal: isSelected ? 16 : 0, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary.withOpacity(.2): Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(
              icons[index].toString(),
              height: widget.dimens.k25,
              width: widget.dimens.k25,
              color: isSelected ? ColorManager.primary : ColorManager.fieldTextColor,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                labels[index],
                style: TextStyle(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
