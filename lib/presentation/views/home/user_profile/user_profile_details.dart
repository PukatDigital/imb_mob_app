import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/profile_details_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/home_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/user_profile/user_more_dialog.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/toast.dart';
import '../../chat/chat_list_view.dart';

class UserProfileDetailsView extends BaseStateFullWidget {
  // ✅ Typed correctly — receives a single Profiles item from the list
  final String profileId;

   UserProfileDetailsView({super.key, required this.profileId});

  @override
  State<UserProfileDetailsView> createState() => _UserProfileDetailsViewState();
}

class _UserProfileDetailsViewState extends State<UserProfileDetailsView>
    implements Result<String> {
  late GetProfileViewModel detailsVM;

  bool isOnline = false;
  bool isPersonalDetails = false;
  bool isFamilyDetails = false;
  bool isEducationProfession = false;
  bool isLifeStyleInterest = false;
  bool isPartnerPreferences = false;

  // ✅ ProfileData — no conflict with Data from get_all_profile_list_model
  ProfileData? get _d => detailsVM.profileDetailsModel?.data;

  void _showChatMenu(BuildContext context, Offset position) {
    final overlay =
    Overlay.of(context).context.findRenderObject() as RenderBox;
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
          child: UserMoreDialogView(
            userName: "${_d?.profileName ?? ''} ${_d?.lastName ?? ''}".trim(),
            userId:_d!.userId.toString(),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // ✅ widget.profile is Profiles — .profileId is directly accessible
      context.read<GetProfileViewModel>().getAllProfileDetails(
        this,
        profileId: widget.profileId ,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetProfileViewModel>(
      builder: (_, provider, __) {
        detailsVM = provider;
        return Scaffold(
          backgroundColor: Colors.white,
          body: _mainContent(),
        );
      },
    );
  }

  Widget _mainContent() {
    return SingleChildScrollView(
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.dimens.k50.verticalBoxPadding,
              _header(),
              widget.dimens.k40.verticalBoxPadding,
              _profileSection(),
              widget.dimens.k10.verticalBoxPadding,
              _bioCard("Bio", _d?.bio ?? "—"),
              widget.dimens.k10.verticalBoxPadding,
              _bioCard("Marriage Intention", _d?.marriageIntension ?? "—"),
              widget.dimens.k10.verticalBoxPadding,
              _expandableSection(
                title: "Personal Details",
                isExpanded: isPersonalDetails,
                onTap: () =>
                    setState(() => isPersonalDetails = !isPersonalDetails),
                child: _personalDetailsContent(),
              ),
              widget.dimens.k10.verticalBoxPadding,
              _expandableSection(
                title: "Family Details",
                isExpanded: isFamilyDetails,
                onTap: () =>
                    setState(() => isFamilyDetails = !isFamilyDetails),
                child: _familyDetailsContent(),
              ),
              widget.dimens.k10.verticalBoxPadding,
              _expandableSection(
                title: "Education and Profession",
                isExpanded: isEducationProfession,
                onTap: () => setState(
                        () => isEducationProfession = !isEducationProfession),
                child: _educationContent(),
              ),
              widget.dimens.k10.verticalBoxPadding,
              _expandableSection(
                title: "Life Style and Interest",
                isExpanded: isLifeStyleInterest,
                onTap: () =>
                    setState(() => isLifeStyleInterest = !isLifeStyleInterest),
                child: _lifeStyleContent(),
              ),
              widget.dimens.k10.verticalBoxPadding,
              _expandableSection(
                title: "Partner Preferences / Requirements",
                isExpanded: isPartnerPreferences,
                onTap: () => setState(
                        () => isPartnerPreferences = !isPartnerPreferences),
                child: _partnerPreferencesContent(),
              ),
              widget.dimens.k10.verticalBoxPadding,
              _picturesSection(),
              widget.dimens.k20.verticalBoxPadding,
              _chatButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final displayName =
    "${_d?.profileName ?? ''} ${_d?.lastName ?? ''}".trim();
    final fallbackName = _d?.profileName??"";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back,
              size: widget.dimens.k20, color: ColorManager.primary),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              displayName.isEmpty ? fallbackName : displayName,
              style: TextStyle(
                fontSize: widget.dimens.k18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isOnline ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  isOnline ? "Active Now" : "Offline",
                  style: TextStyle(
                      fontSize: widget.dimens.k14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            _showChatMenu(context, details.globalPosition);
          },
          child: Icon(Icons.more_vert, color: ColorManager.primary),
        ),
      ],
    );
  }

  Widget _profileSection() {
    final pictureUrl = _d?.profilePicture?.isNotEmpty == true
        ? _d!.profilePicture!
        : _d?.profilePicture ?? "";

    return Column(
      children: [
        CircleAvatar(
          radius: widget.dimens.k60,
          backgroundColor: ColorManager.halfWhite,
          backgroundImage:
          pictureUrl.isNotEmpty ? NetworkImage(pictureUrl) : null,
          child: pictureUrl.isEmpty
              ? Icon(Icons.person,
              size: widget.dimens.k50, color: ColorManager.fieldTextColor)
              : null,
        ),
        widget.dimens.k10.verticalBoxPadding,
        Text(
          "${_d?.profileName ?? _d?.profileName ?? ''} "
              "${_d?.lastName ?? ''}".trim(),
          style: TextStyle(
              fontSize: widget.dimens.k18, fontWeight: FontWeight.w600),
        ),
        widget.dimens.k5.verticalBoxPadding,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined,
                size: widget.dimens.k20, color: ColorManager.fieldTextColor),
            widget.dimens.k5.horizontalBoxPadding,
            Text(
              _d?.country ?? "—",
              style: TextStyle(
                fontSize: widget.dimens.k13,
                fontWeight: FontWeight.w400,
                color: ColorManager.fieldTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _personalDetailsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailItem(label: "Gender",             value: _d?.gender            ?? "—"),
        _detailItem(label: "Marital Status",     value: _d?.materialStatus    ?? "—"),
        _detailItem(label: "Date of Birth",      value: _d?.dateOfBirth       ?? "—"),
        _detailItem(label: "Mother Tongue",      value: _d?.motherTongue      ?? "—"),
        _detailItem(label: "Caste",              value: _d?.caste             ?? "—"),
        _detailItem(label: "Height",             value: _d?.hight             ?? "—"),
        _detailItem(label: "Weight",             value: _d?.weight            ?? "—"),
        _detailItem(label: "Country",            value: _d?.country           ?? "—"),
        _detailItem(label: "Nationality",        value: _d?.nationality       ?? "—"),
        _detailItem(label: "Ethnicity",          value: _d?.ethnicity         ?? "—"),
        _detailItem(label: "Religion",           value: _d?.religion          ?? "—"),
        _detailItem(label: "Sect",               value: _d?.belongsTo         ?? "—"),
        _detailItem(label: "Religious Practice", value: _d?.religiousPractice ?? "—"),
        _detailItem(label: "Zodiac Sign",        value: _d?.zodiacSign        ?? "—"),
      ],
    );
  }

  Widget _familyDetailsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailItem(label: "Father's Name",            value: _d?.fatherName               ?? "—"),
        _detailItem(label: "Father's Occupation",      value: _d?.fatherOccupation         ?? "—"),
        _detailItem(label: "Family Values",            value: _d?.familyValues             ?? "—"),
        _detailItem(label: "Living Arrangement",       value: _d?.livingArrangement        ?? "—"),
        _detailItem(label: "Siblings Married",         value: _d?.married                  ?? "—"),
        _detailItem(label: "Siblings Unmarried",       value: _d?.unmarried                ?? "—"),
        _detailItem(label: "Size of House",            value: _d?.houseSize                ?? "—"),
        _detailItem(label: "Society / Area",           value: _d?.areaSociety              ?? "—"),
        _detailItem(label: "Move Abroad for Marriage", value: _d?.canMoveAbroadForMarriage ?? "—"),
        _detailItem(label: "Children",                 value: _d?.haveChildern             ?? "—"),
        _detailItem(label: "Other Family Details",     value: _d?.otherFamilyDetails       ?? "—"),
      ],
    );
  }

  Widget _educationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailItem(label: "Qualification",         value: _d?.qualification   ?? "—"),
        _detailItem(label: "Educational Institute", value: _d?.nameInstitution ?? "—"),
        _detailItem(label: "Profession",            value: _d?.profession      ?? "—"),
        _detailItem(label: "Employer",              value: _d?.employer        ?? "—"),
        _detailItem(label: "Employee Type",         value: _d?.employeeType    ?? "—"),
        _detailItem(label: "Job Title / Role",      value: _d?.jobTitle        ?? "—"),
        _detailItem(label: "Monthly Income",        value: _d?.incomeRange     ?? "—"),
        _detailItem(label: "Business",              value: _d?.business        ?? "—"),
      ],
    );
  }

  Widget _lifeStyleContent() {
    final interests = _d?.lifeStyleAndInterest ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (interests.isNotEmpty) ...[
          Text(
            "Life Style And Interest",
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorManager.fieldTextColor,
              fontSize: widget.dimens.k13,
            ),
          ),
          widget.dimens.k8.verticalBoxPadding,
          Wrap(
            spacing: widget.dimens.k8,
            runSpacing: widget.dimens.k8,
            children: interests.map((item) {
              return Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.dimens.k12, vertical: widget.dimens.k6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.dimens.k10),
                  color: ColorManager.loginContainer,
                ),
                child: Text(
                  item.value ?? '',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: ColorManager.textColorSubTitle,
                    fontSize: widget.dimens.k12,
                  ),
                ),
              );
            }).toList(),
          ),
          widget.dimens.k12.verticalBoxPadding,
        ],
        _detailItem(label: "Future Plans",                         value: _d?.futurePlan        ?? "—"),
        _detailItem(label: "Family Involved in Marriage Decision",  value: _d?.familyInvolvement ?? "—"),
        _detailItem(label: "Planning to Get Married",              value: _d?.marriagePeriod    ?? "—"),
        _detailItem(label: "Smoking",                              value: _d?.smoke             ?? "—"),
        _detailItem(label: "Drink Alcohol",                        value: _d?.drinkAlcohol      ?? "—"),
        _detailItem(label: "Eat Only Halal Food",                  value: _d?.halalFood         ?? "—"),
        _detailItem(label: "Prefer to Wear Hijab",                 value: _d?.forGirl           ?? "—"),
        _detailItem(label: "Prefer a Bearded Man",                 value: _d?.forBoy            ?? "—"),
      ],
    );
  }

  Widget _partnerPreferencesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _detailItem(
          label: "What are you looking for in your life partner?",
          value: _d?.lifePartner ?? "—",
        ),
        _detailItem(label: "Chatting Period", value: _d?.chattingPeriod ?? "—"),
        _detailItem(label: "Marriage Period", value: _d?.marriagePeriod ?? "—"),
      ],
    );
  }

  Widget _picturesSection() {
    final att = _d?.attachments;
    final List<String> images = [
      if (att?.attach1 != null && att!.attach1!.isNotEmpty) att.attach1!,
      if (att?.attach2 != null && att!.attach2!.isNotEmpty) att.attach2!,
      if (att?.attach3 != null && att!.attach3!.isNotEmpty) att.attach3!,
      if (att?.attach4 != null && att!.attach4!.isNotEmpty) att.attach4!,
    ];

    if (images.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pictures",
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: ColorManager.fieldTextColor,
            fontSize: widget.dimens.k13,
          ),
        ),
        widget.dimens.k8.verticalBoxPadding,
        SizedBox(
          height: widget.dimens.k300,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: _networkImageBox(images[0], radius: widget.dimens.k20),
              ),
              if (images.length > 1) ...[
                widget.dimens.k8.horizontalBoxPadding,
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Expanded(
                          child: _networkImageBox(images[1],
                              radius: widget.dimens.k15)),
                      if (images.length > 2) ...[
                        widget.dimens.k8.verticalBoxPadding,
                        Expanded(
                            child: _networkImageBox(images[2],
                                radius: widget.dimens.k15)),
                      ],
                      if (images.length > 3) ...[
                        widget.dimens.k8.verticalBoxPadding,
                        Expanded(
                            child: _networkImageBox(images[3],
                                radius: widget.dimens.k15)),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _chatButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k45),
      child: PrimaryButton(
        issquare: true,
        isSafeArea: false,
        color: ColorManager.primary.withOpacity(.1),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => ChatListView()));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: widget.dimens.k25,
              backgroundColor: ColorManager.primary,
              child: Image.asset(Assets.chat,
                  width: 16, height: 16, color: ColorManager.white),
            ),
            widget.dimens.k8.horizontalBoxPadding,
            Text(
              "Chat With ${_d?.profileName ?? _d?.profileName ?? 'User'}",
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: widget.dimens.k15,
                color: ColorManager.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: widget.dimens.k20, horizontal: widget.dimens.k15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.dimens.k25),
        color: ColorManager.halfWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textColor,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.arrow_forward_ios_sharp,
                  color: isExpanded
                      ? ColorManager.textColor
                      : ColorManager.fieldTextColor,
                ),
              ],
            ),
          ),
          if (isExpanded) ...[
            widget.dimens.k10.verticalBoxPadding,
            child,
          ],
        ],
      ),
    );
  }

  Widget _bioCard(String title, String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: widget.dimens.k20, horizontal: widget.dimens.k15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.dimens.k25),
        color: ColorManager.halfWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorManager.textColor,
            ),
          ),
          widget.dimens.k6.verticalBoxPadding,
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorManager.fieldTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailItem({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.dimens.k12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorManager.fieldTextColor,
              fontSize: widget.dimens.k13,
            ),
          ),
          widget.dimens.k4.verticalBoxPadding,
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorManager.fieldHintColor,
              fontSize: widget.dimens.k16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _networkImageBox(String url, {double? radius}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? widget.dimens.k15),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  void onError(String error) => MyToast.showToast(message: error);

  @override
  void onSuccess(String result) {}
}